---
layout: post
title: "Using `sort` and `sort_by` on Ruby Arrays"
summary: "A comparison of two native sorting methods, plus cryptic errors that are difficult to debug"
excerpt: "A comparison of two native sorting methods, plus cryptic errors that are difficult to debug"
---

Suppose you have a class written Ruby and you want to sort an array of instances of that class:

```ruby
class Player
  attr_accessor :name, :avg, :hr, :rbi

  def initialize(name, avg, hr, rbi)
    @name = name
    @avg = avg
    @hr = hr
    @rbi = rbi
  end
end

players = [
  Player.new('Dominic Smith', 0.253, 11, 43),
  Player.new('Brandon Nimmo', 0.299, 2, 14),
  Player.new('Michael Conforto', 0.203, 6, 24)
]
```

According to [this blog post](https://brandon.dimcheff.com/2009/11/18/rubys-sort-vs-sort-by/) by Brandon Dimcheff, there are two methods built into Ruby arrays for sorting: `sort` and `sort_by`.

The `sort` method calls a comparator block that you define. The block compares two objects at a time and it must return -1 the first item is less than the second, 0 if the two objects are equal, or 1 if the first item is greater than the second one.

```ruby
players.sort { |first_player, second_player| first_player.avg <=> second_player.avg }
```

The `sort_by` methods also calls a block, but in this case the block only takes in one argument. The array is then sorted by value returned by that block. `sort_by` uses a [Schwartzian Transform](http://en.wikipedia.org/wiki/Schwartzian_transform) which turns each element into a tuple with the value you want to sort by as the first element in each tuple, then the tuples are sorted by that first value. `sort_by` may result in faster performance, especially when the comparison between two objects is expensive, since the operator only gets called once for each element.

```ruby
players.sort_by { |player| player.avg }
```

In both cases, errors arise when the method tries to compare values that cannot be compared – namely `nil`. When this happens, execution stops and an exception is thrown. I had to debug such an issue at work, where an object had a `nil` value in one of its fields. I can't share the data I used at work, but I can replace it with this example:

```ruby
players = [
  Player.new('Dominic Smith', 0.253, 11, 43),
  Player.new('Brandon Nimmo', 0.299, 2, 14),
  Player.new('Michael Conforto', nil, 6, 24)
]
```

When calling `sort` again, this happens:

```ruby
irb(main):016:0> players.sort { |first_player, second_player| first_player.avg <=> second_player.avg }
Traceback (most recent call last):
        5: from /Users/creativedan/.rbenv/versions/2.6.3/bin/irb:23:in `<main>'
        4: from /Users/creativedan/.rbenv/versions/2.6.3/bin/irb:23:in `load'
        3: from /Users/creativedan/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        2: from (irb):16
        1: from (irb):16:in `sort'
ArgumentError (comparison of Player with Player failed)
```

The error, while incidating that there is a problem with the comparison, doesn't explain _why_ the comparison failed. Let's see what happens when we call `sort_by`:

```ruby
irb(main):017:0> players.sort_by { |player| player.avg }
Traceback (most recent call last):
        6: from /Users/creativedan/.rbenv/versions/2.6.3/bin/irb:23:in `<main>'
        5: from /Users/creativedan/.rbenv/versions/2.6.3/bin/irb:23:in `load'
        4: from /Users/creativedan/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        3: from (irb):17
        2: from (irb):17:in `rescue in irb_binding'
        1: from (irb):17:in `sort_by'
ArgumentError (comparison of Float with nil failed)
```

That's slightly better, since it at least shows that the `nil` value is the one at fault.

The error becomes more obscure when sorting objects by multiple fields. This can be done by calling `sort_by` and having the block return an array of values. However, the sort errors out when any of the values in the array is `nil`:

```ruby
irb(main):018:0> players.sort_by { |player| [player.avg, player.hr] }
Traceback (most recent call last):
        6: from /Users/creativedan/.rbenv/versions/2.6.3/bin/irb:23:in `<main>'
        5: from /Users/creativedan/.rbenv/versions/2.6.3/bin/irb:23:in `load'
        4: from /Users/creativedan/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        3: from (irb):18
        2: from (irb):18:in `rescue in irb_binding'
        1: from (irb):18:in `sort_by'
ArgumentError (comparison of Array with Array failed)
```

It's that specific error (`comparison of Array with Array failed`) that I encountered in a teammate's code. Fortunately, [Tomer Brisker](https://medium.com/@tbrisker/when-an-array-is-not-an-array-f0e7499d5817) on Medium encountered a similar issue in his codebase and provided a key clue on getting the error resolved.

If you want to sort arrays without a hitch, you'll need to do either of the following:
- Ensure there are no `nil`s in your input
- Handle `nil` values in your comparator block

Most importantly, you need to be aware that `nil`s will cause your sorting method to crash.

I wrote a [Gist](https://gist.github.com/dandelarosa/3359605e90115e5dc17d483855ec03ce) if you're interested in running the code examples above.
