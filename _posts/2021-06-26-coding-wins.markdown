---
layout: post
title: "Coding Wins: June 26, 2021"
summary: "A refresh on coding in Angular, and other lessons learned this week"
excerpt: "A refresh on coding in Angular, and other lessons learned this week"
---

In this series I share lessons learned while programming at work. These snippets assume some familiarity with the subject matter, and a longer article may be needed to provide background information or explain the benefits of the changes described. That being said, I want to present these ideas upfront while they’re fresh in my head and conduct a deeper discussion only when it is warranted.

## Returning to Development in Angular

The vast majority of the work my team and I do deals with the Rails microservices that are a part of our application, but sometimes we need to add features to our app's frontend which is written in Angular. This week I was tasked with building a new menu with custom components; here's a lightning round of things I had to look up:

- Using the [`ngClass`](https://angular.io/api/common/NgClass) directive to conditionally add CSS classes to a component. Although the example `<some-element [ngClass]="{'first': true, 'second': true, 'third': false}">...</some-element>` sets boolean literals as the object values, you can replace `true` and `false` with calls to functions defined in the TypeScript class.
- Want to apply a particular style when multiple selectors are detected? This can be done in Sass in the following way: ([modified from the original written in SCSS](https://stackoverflow.com/a/11084798))

```
// Your HTML
<div class="first_class second_class">
  ...
</div>

// Your Sass File
.first_class
    background: red
    &.second_class
       background: blue
```

- When you add a border to an HTML element it affects the sizing and positioning of that element. What if you want the ability to toggle the border on and off and easily compensate for those changes? Have the [`border-color`](https://developer.mozilla.org/en-US/docs/Web/CSS/border-color) property alternate between `transparent` and the regular border color; that way there's only one thing to modify when switching the border on or off.
- Angular [click events](https://angular.io/guide/event-binding) can be used to respond to clicks on buttons, `a` tags (in order to call a method instead of opening a link), and to regular `div` elements.

## Returning Errors in JSON API

I'm continuing to learn more about the JSON:API specification after [starting my journey last year]({% post_url 2020-11-15-getting-acquainted-with-json-api %}). Previously I learned how to properly render a list of records when those records are retrieved successfully; this week I found the right way to show errors that occurred in API responses. [This page](https://jsonapi.org/examples/#error-objects) shows examples of what error objects should look like in JSON API. [This page](https://jsonapi.org/format/#error-objects) shows what fields can be included in an error object, and they are all optional, but I say the `detail` field should at least be a part of the object.

```
HTTP/1.1 400 Bad Request
Content-Type: application/vnd.api+json

{
  "errors": [
    {
      "detail": "Position must be one of the following: P, C, 1B, 2B, 3B, SS, LF, CF, RF."
    }
  ]
}

```

If you use the [jsonapi-rails](https://github.com/jsonapi-rb/jsonapi-rails) gem, you can render error responses in a manner like so:

```ruby
def create
  errors = [
    {
      'detail' => 'Position must be one of the following: P, C, 1B, 2B, 3B, SS, LF, CF, RF.'
    }
  ]
  render jsonapi_errors: errors, status: :bad_request
end
```

## Writing Engineering Tasks for a Small Team

In our journey to adopt a DevOps culture, my team has set out a goal of "any story, any developer, any time" for this quarter; to accomplish this we started breaking down user stories into smaller engineering tasks. What we didn't anticipate was that we would do this without a product manager and with our engineering team cut in half. A lot of the responsibility of writing stories and getting them done has fallen on me.

In the past, there were several bugs in our application arisen from edge cases not being accounted for. Recently, in a measure these occurrences, I've started writing full specification of endpoints in our stories. I added very specific requirements on endpoint locations, the structure of requests and responses, and the behind-the-scenes behavior in different conditions.

While noble, I ended up overspecifying stories. With each requirement added it increases the effort needed to complete a given story. Worse off, a story kept going back and forth between engineering and QA because I failed to satisfy requirements I had written myself. It's clear that decision ended up slowing the team down.

As our team continues to work under these restraints, I need to continue to walk this fine line. To keep stories small, I need to find the exact minimum requirements to get an endpoint up. We should always avoid serious errors, so we can't skip measures that prevent those. But anything else is potentially window dressing, while there may be ways to improve the app's behavior we must be able to come to with making those secondary concerns, especially if it means shelving them indefinitely.
