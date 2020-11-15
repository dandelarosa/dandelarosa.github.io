---
layout: post
title: "Getting Acquainted With JSON API"
---

Recently, my manager suggested using [jsonapi-rb](https://github.com/jsonapi-rb/jsonapi-rb) for serializing responses in our Rails application after he learned that the [Active Model Serializers gem was no longer actively maintained](https://github.com/jsonapi-rb/jsonapi-rb). At first I first I thought this change was inconsequential, since it sounded like all we had to do was change libraries. However, I learned what the upgrade entailed the hard way when I helped a teammate diagnose an error in our frontend. The UI code expected the fields of a record to be present in specific locations, but our new serializer formatted our API responses into a structure the program couldn't recognize. After reading about the jsonapi-rb gem I found out this is the intended behavior, as it conforms to a web standard called [JSON API](https://jsonapi.org/). I have mixed feelings about conducting the migration haphazardly, but I've found my own reasons to accept the change.

## The Envelope Debate and JSON API's Position

One long-standing debate in API design is whether to enclose data sent to a client in a data structure called an "envelope." Imagine if the website baseball-reference.com had an API for retrieving information on baseball players. Here's what a list of player records would look like without an envelope:

```json
[
  {
    "id": "degrom001jac",
    "name": "Jacob deGrom",
    "position": "Starting Pitcher",
    "bats": "Left",
    "throws": "Right",
    "height": "6-4",
    "weight": "180lb",
    "team": "New York Mets"
  },
  {
    "id": "judgeaa01",
    "name": "Aaron Judge",
    "position": "Rightfielder",
    "bats": "Right",
    "throws": "Right",
    "height": "6-7",
    "weight": "282lb",
    "team": "New York Yankees"
  }
]
```

To get Jacob deGrom's name, your client would use the expression `response.body[0].name`.

The envelope is a object that places the above array in the `data` field. The higher-level object can be used to include metadata, such as the `count` of records in the array.

```json
{
  "count": 2,
  "data": [
    {
      "id": "degrom001jac",
      "name": "Jacob deGrom",
      "position": "Starting Pitcher",
      "bats": "Left",
      "throws": "Right",
      "height": "6-4",
      "weight": "180lb",
      "team": "New York Mets"
    },
    {
      "id": "judgeaa01",
      "name": "Aaron Judge",
      "position": "Rightfielder",
      "bats": "Right",
      "throws": "Right",
      "height": "6-7",
      "weight": "282lb",
      "team": "New York Yankees"
    }
  ]
}
```

Your client's expression needs to be updated: `response.body`**`.data`**`[0].name`.

The JSON API specification takes things one step further, placing each individual record in an envelope. All fields apart from the ID are moved to an `attributes` object:

```json
{
  "count": 2,
  "data": [
    {
      "type": "players",
      "id": "degrom001jac",
      "attributes": {
        "name": "Jacob deGrom",
        "position": "Starting Pitcher",
        "bats": "Left",
        "throws": "Right",
        "height": "6-4",
        "weight": "180lb",
        "team": "New York Mets"
      }
    },
    {
      "type": "players",
      "id": "judgeaa01",
      "attributes": {
        "name": "Aaron Judge",
        "position": "Rightfielder",
        "bats": "Right",
        "throws": "Right",
        "height": "6-7",
        "weight": "282lb",
        "team": "New York Yankees"
      }
    }
  ]
}
```

Once again, your client's expression will need to be changed: `response.body.data[0]`**`.attributes`**`.name`.

In [last week’s post]({% post_url 2020-11-08-reading-list-restful-api-best-practices %}) I wrote about Vinay Sahni's list of API design best practices. One of the pieces of advice [discourages the use of envelopes in API responses](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#envelope). However, with jsonapi-rb's adoption [reaching the millions](https://rubygems.org/gems/jsonapi-rb), APIs are starting to lean toward the pro-envelope side of the debate.

## My Reasons for Sticking with a Standard

I recently groomed a user story that required the creation of a new endopint in our API. Since the story involved a legacy UI, I had to find out how similar endpoints worked to write the specification for the new one. This was a time-consuming process and prevented me from tackling other tasks. I want to change our development philosophy to use the following two ideas.

1. Our backend should conform to a comprehensive set of standards. This can be a combination of guidelines taken from the JSON API standard, Vinay Sahni's blog post, or elsewhere. By following standards, it reduces the number of requirements that need to be written explicitly; I can use the time saved to groom additional stories or actually implement them.
2. Whenever possible, have the backend dictate how the frontend and other clients use it. This is preferrable over the reverse, where clients dictate how the backend should function; we would lose the benefits of the former since we would have to write requirements that are unique to that use case and they may override our adopted standards.

Ideally our API design is driven by widely accepted standards and by our product manager's requirements, eliminating our need for fine grained technical criteria.

## Upcoming Challenges

JSON API is new to our team, so obviously one of our next steps is to learn more about it. There are other parts of the specification we should become familiar with, such as relationships and links. My discussion so far has exclusively been about API responses; we'll need to learn what the specification says about requests as well.

Other engineering teams in our organization need to become aware of JSON API as well. We'll try our best to push adoption, but the more likely scenario is that we split our API into endpoints the conform to JSON API and ones that conform to the custom requirements.
