---
layout: post
title: "Coding Wins: June 19, 2021"
summary: "This week I highlight a couple of the ways I’ve reorganized the test code for my application’s Rails controller."
excerpt: "This week I highlight a couple of the ways I’ve reorganized the test code for my application’s Rails controller."
---

I’m starting a new series of blog posts summarizing insights gained while programming at work. These snippets assume some familiarity with the subject matter, and a longer article may be needed to provide background information or explain the benefits of the changes described. That being said, I want to present these ideas upfront while they’re fresh in my head and conduct a deeper discussion only when it is warranted.

This week I highlight a couple of the ways I’ve reorganized the test code for my application’s Rails controller.

## Grouping Error States By Response Code

My team uses [Rswag](https://github.com/rswag/rswag) to write integration tests for the controllers in our API. The spec files look something like the snippet below:

```ruby
require 'swagger_helper'

describe 'Blogs API' do

  path '/blogs' do

    post 'Creates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :blog, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :string }
        },
        required: [ 'title', 'content' ]
      }

      # Assume there's a test here for successful creations

      response '400', 'error when the title is missing' do
        let(:blog) { { title: nil, content: 'content' } }
        run_test!
      end

      response '400', 'error when the content is missing' do
        let(:blog) { { title: 'title', content: nil } }
        run_test!
      end

      # Assume some other tests are here...

    end
  end
end
```

Notice that there is more than one entry for response code 400. When generating the docs for this endpoint, there will be two blocks with nearly identical information. We only need to indicate once that the API handles invalid requests, so let’s consolidate the blocks into one:

```ruby
      response '400', 'error when the request is invalid' do
        context 'when the title is missing' do
          let(:blog) { { title: nil, content: 'content' } }
          run_test!
        end

        context 'when the content is missing' do
          let(:blog) { { title: 'title', content: nil } }
          run_test!
        end
      end
```

## Overriding Variables Declares in a `shared_context` Block

I’ve been using [`shared_context`](https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-context) as a means of DRY-ing up my test code. You can write reusable snippets of code in a block and invoke it in multiple areas in your tests.

In a previous version of my controller spec, I had two `shared_context`s: one general one defining how a request is defined and one for declaring a complete request. Incomplete requests - ones with missing fields - had to be made from the bottom up. Here’s what it looks like in action:

```ruby
      shared_context 'with blog request' do
        let(:blog) { { title: title, content: content } }
      end

      shared_context 'with complete blog request' do
        include_context 'with blog request' do
          let(:title) { 'title' }
          let(:content) { 'content' }
        end
      end

      response '201', 'blog created' do
        include_context 'with complete blog request'
        run_test!
      end

      response '400', 'error when the request is invalid' do
        context 'when the title is missing' do
          include_context 'with blog request' do
            let(:title) { nil }
            let(:content) { 'content' }
          end

          run_test!
        end

        context 'when the content is missing' do
          include_context 'with blog request' do
            let(:title) { 'title' }
            let(:content) { nil }
          end

          run_test!
        end
      end
```

This can be refactored even further. In fact, there is no need for two separate blocks for the general and complete versions of the context. In Rspec, you can append an `include_context` call [with an additional block](https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-context#declare-a-shared-context,-include-it-with-%60include-context%60-and-extend-it-with-an-additional-block) that can set additional variables, or override ones declared in the original `shared_context`. That way you can have one block with the completed request as default, and then override the block by setting a specific field to a different value when testing edge cases. This has the additional benefit of only having to declare the “happy path” fields once, removing the need to define them in every context. Here’s what the code looks like with the aforementioned changes applied:

```ruby
      shared_context 'with blog request' do
        let(:title) { 'title' }
        let(:content) { 'content' }
        let(:blog) { { title: title, content: content } }
      end

      response '201', 'blog created' do
        include_context 'with blog request'
        run_test!
      end

      response '400', 'error when the request is invalid' do
        context 'when the title is missing' do
          include_context 'with blog request' do
            let(:title) { nil }
          end

          run_test!
        end

        context 'when the content is missing' do
          include_context 'with blog request' do
            let(:content) { nil }
          end

          run_test!
        end
      end
```

As a result, the same tests have been implemented in a more compact file. This should improve the readability of the application’s specs. Over time, I’ll find more ways of refactoring and reorganizing my team’s codebase and I’ll share those insights when I discover them.
