---
layout: post
title: "Use Ruby's Splat Operator to Test Presence of a Randomly Generated Array"
summary: "How to check for an array of arbitrary length in Rspec"
excerpt: "How to check for an array of arbitrary length in Rspec"
---

Suppose you’re writing an e-commerce site that allows users to order between one and three products and sends that user an email including the items that were requested. One the tests you would write is to make sure the names of the products are present in the email. Let’s assume that the names are passed in as an array as opposed to being a property in a list of product records:

```ruby
describe OrderService do
  describe '#place_order' do
    context 'with a list of product names' do
      let(:product_names) { Array.new(Faker::Number.between(from: 1, to: 3)) { Faker::Name.name } }
      let(:email) { ActionMailer::Base.deliveries.last }

      it 'includes the product names in the email body' do
        described_class.new.place_order(product_names)

        # TODO: write expectations
      end
    end
  end
end
```

Rspec has the [`include`](https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/include-matcher) matcher to check for the presence of a string (a product name) within a string (the email body). The method allows for multiple parameters if you want to check for multiple values in one statement:

```ruby
describe OrderService do
  describe '#place_order' do
    context 'with a list of product names' do
      let(:product_names) { Array.new(Faker::Number.between(from: 1, to: 3)) { Faker::Name.name } }
      let(:email) { ActionMailer::Base.deliveries.last }

      it 'includes the product names in the email body' do
        described_class.new.place_order(product_names)

        expect(mail.body.to_s).to include(product_names.first, product_names.second, product_names.third)
      end
    end
  end
end
```

There are several limitations to this approach. First, the test will fail if you pass in the array; each element must be passed in as individual parameters. The act of listing each string explicitly is misleading because, for example, there would not be a second or third element if there is only product name passed in. Additionally, there would be two places that need to be updated if we want to support longer arrays: in the definition of `product_names` and in the arguments for the call to `include`.

Fortunately, there is a way to write this test in a more extendable way. I looked for a way to [convert an array into a list of arguments](https://stackoverflow.com/q/4643277) and it turned out the `*` operator, also known as the splat operator, does exactly that. Meagan Waller has written [a comprehensive article on the splat operator](https://meaganwaller.com/the-splat-operator) if you want to know more about what it does. Anyway, here’s what the test looks like with the change:

```ruby
describe OrderService do
  describe '#place_order' do
    context 'with a list of product names' do
      let(:product_names) { Array.new(Faker::Number.between(from: 1, to: 3)) { Faker::Name.name } }
      let(:email) { ActionMailer::Base.deliveries.last }

      it 'includes the product names in the email body' do
        described_class.new.place_order(product_names)

        expect(mail.body.to_s).to include(*product_names)
      end
    end
  end
end
```

In this version, the `include` invocation can be made without knowning the length of the array in advance. By using this syntax it’s much closer to the intent of the test. I’ve added this technique to my toolset to use in future tests involving arrays of arbitrary length.
