---
layout: post
title: "How to Properly Mock a Class in Rspec"
summary: "A tip on writing better tests"
excerpt: "A tip on writing better tests"
---

A good portion of the code I write at work interact with external APIs. For example, let’s say there’s a class called `ExternalAPIService` that sends HTTP requests an external API. The purpose of this is to abstract out the details of making the request from the code that consumes it (the `ExamplesService` in this example).

```ruby
class ExamplesService
  def list_all
    ExternalAPIService.new.list_all_examples
  end
end
```

Tests for the `ExamplesService` typically look like the listing below.

```ruby
describe ExamplesService do
  describe '#list_all' do
    let(:examples) { [] } # Pretend this returns a list of examples instead

    before do
      allow_any_instance_of(ExternalAPIService).to receive(:list_all_examples).and_return(examples)
    end

    it 'returns the examples provided by the external API' do
      returned_examples = described_class.new.list_all

      expect(returned_examples).to match_array(examples)
    end
  end
end
```

If you run RuboCop on this spec file, you’ll see this message among the linter errors:

```
'Avoid stubbing using `:allow_any_instance_of`'
```

The specs triggered the [`RuboCop::Cop::RSpec::AnyInstance`](https://www.rubydoc.info/gems/rubocop-rspec/1.6.0/RuboCop/Cop/RSpec/AnyInstance) cop. Why is this an issue? The Rspec documentation shines a light on why the “any instance” methods [are discouraged](https://relishapp.com/rspec/rspec-mocks/docs/working-with-legacy-code/any-instance):

> * The rspec-mocks API is designed for individual object instances, but this feature operates on entire classes of objects. As a result there are some semantically confusing edge cases. For example, in expect_any_instance_of(Widget).to receive(:name).twice it isn't clear whether a specific instance is expected to receive name twice, or if two receives total are expected. (It's the former.)
> * Using this feature is often a design smell. It may be that your test is trying to do too much or that the object under test is too complex.
> * It is the most complicated feature of rspec-mocks, and has historically received the most bug reports. (None of the core team actively use it, which doesn't help.)

The issue can be solved by replacing the `allow_any_instance_of` with an [instance double](https://relishapp.com/rspec/rspec-mocks/v/3-10/docs/verifying-doubles/using-an-instance-double):

```ruby
describe ExamplesService do
  describe '#list_all' do
    let(:examples) { [] } # Pretend this returns a list of examples instead
    let(:example_service_double) { instance_double(ExternalAPIService) }

    before do
      allow(ExternalAPIService).to receive(:new).and_return(example_service_double)
      allow(example_service_double).to receive(:foo).and_return(examples)
    end

    it 'returns the examples provided by the external API' do
      returned_examples = described_class.new.list_all

      expect(returned_examples).to match_array(examples)
    end
  end
end
```

Instead of altering the entire class, this code only modifies the behavior of a single instance. Additionally, it verifies that method signature matches and that the correct number of arguments are passed in, raising an error if the method is different in the original class. This way you can test classes with as close to real conditions as possible without making network calls.
