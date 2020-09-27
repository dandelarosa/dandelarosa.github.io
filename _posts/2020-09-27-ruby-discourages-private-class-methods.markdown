---
layout: post
title: "Ruby Discourages Private Class Methods"
---

Ruby is an object-oriented language. As such, applications written in Ruby consist mostly of operations performed on objects. Even primitive values like integers are objects in Ruby. One may want to transition to a pure functional approach to programming, but aspects of this language limit one’s ability to do so.

A coder may emulate a pure function by writing a class level method. Consider the following snippet:

```ruby
class DividendCalculator1
  def self.yield_for_stock(stock)
    if stock['payout_schedule'].eql? 'quarterly'
      payouts = stock['dividend_payments'].last(4)
    elsif stock['payout_schedule'].eql? 'monthly'
      payouts = stock['dividend_payments'].last(12)
    else
      payouts = stock['dividend_payments'].last(1)
    end

    total_payout = payouts.reduce(:+)

    dividend_yield = total_payout / stock['price']

    format('%<yield>.2f%%', yield: dividend_yield)
  end
end
```

So far it looks okay. Problems arise when refactoring. Let’s exact a part of this method into an internal helper function.

```ruby
class DividendCalculator2
  def self.yield_for_stock(stock)
    payouts = payouts_for_stock(stock)

    total_payout = payouts.reduce(:+)

    dividend_yield = total_payout / stock['price']

    format('%<yield>.2f%%', yield: dividend_yield)
  end

  private

  def self.payouts_for_stock(stock)
    if stock['payout_schedule'].eql? 'quarterly'
      stock['dividend_payments'].last(4)
    elsif stock['payout_schedule'].eql? 'monthly'
      stock['dividend_payments'].last(12)
    else
      stock['dividend_payments'].last(1)
    end
  end
end
```

This code also runs as intended, without throwing errors. Let’s see what my code linter RuboCop has to say.

```
vagrant@ubuntu-bionic:/vagrant/calculator$ bundle exec rubocop lib/dividend_calculator_2.rb
(...)
lib/dividend_calculator_2.rb:12:3: W: Lint/UselessAccessModifier: Useless private access modifier.
  private
  ^^^^^^^
lib/dividend_calculator_2.rb:14:3: W: Lint/IneffectiveAccessModifier: private (on line 12) does not make singleton methods private. Use private_class_method or private inside a class << self block instead.
  def self.payouts_for_stock(stock)
  ^^^
(...)
```

So it ain’t so. Can these private methods be called?

```
vagrant@ubuntu-bionic:/vagrant/calculator$ irb
2.6.0 :001 > require './lib/dividend_calculator_2'
(...)
2.6.0 :024 > puts DividendCalculator2.payouts_for_stock(stock)
0.13
0.13
0.13
0.13
 => nil 
```

That’s not good. By exposing these methods we’re giving other developers the false impression that these are freely available to use. It also restricts our ability to remove or relocate the code without advance notice.

In Ruby the `private` keyword applies to instance-level methods but not class-level methods. In its place, RuboCop suggests using the `private_class_method` keyword. This can be used as a quick fix, but one must remember to apply the keyword for every class-level method that needs to be made private.

```ruby
class DividendCalculator3
  def self.yield_for_stock(stock)
    dividend_yield = dividend_yield_for_stock(stock)

    format('%<yield>.2f%%', yield: dividend_yield)
  end

  private_class_method def self.dividend_yield_for_stock(stock)
    payouts = payouts_for_stock(stock)

    total_payout = payouts.reduce(:+)

    total_payout / stock['price']
  end

  private_class_method def self.payouts_for_stock(stock)
    if stock['payout_schedule'].eql? 'quarterly'
      stock['dividend_payments'].last(4)
    elsif stock['payout_schedule'].eql? 'monthly'
      stock['dividend_payments'].last(12)
    else
      stock['dividend_payments'].last(1)
    end
  end
end
```

Let's load the class in the Ruby console to ensure that privacy is enforced.

```
vagrant@ubuntu-bionic:/vagrant/calculator$ irb
2.6.0 :001 > require './lib/dividend_calculator_3'
(...)
2.6.0 :024 > puts DividendCalculator3.payouts_for_stock(stock)
Traceback (most recent call last):
        4: from /home/vagrant/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `<main>'
        3: from /home/vagrant/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `load'
        2: from /home/vagrant/.rvm/rubies/ruby-2.6.0/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        1: from (irb):24
NoMethodError (private method `payouts_for_stock' called for DividendCalculator3:Class)
```

Another way to have Ruby respect privacy is to shift these methods from the class level to the instance level. You'll only need to declare `private` once; no need for `private_class_method`, and no need for `self.` when defining methods. The only tradeoff is that we’ll have to create an instance of the class before calling its functions.

```ruby
class DividendCalculator4
  def yield_for_stock(stock)
    dividend_yield = dividend_yield_for_stock(stock)

    format('%<yield>.2f%%', yield: dividend_yield)
  end

  private

  def dividend_yield_for_stock(stock)
    payouts = payouts_for_stock(stock)

    total_payout = payouts.reduce(:+)

    total_payout / stock['price']
  end

  def payouts_for_stock(stock)
    if stock['payout_schedule'].eql? 'quarterly'
      stock['dividend_payments'].last(4)
    elsif stock['payout_schedule'].eql? 'monthly'
      stock['dividend_payments'].last(12)
    else
      stock['dividend_payments'].last(1)
    end
  end
end
```

Let's use the new class and verify that it runs as expected and enforces method privacy.

```
vagrant@ubuntu-bionic:/vagrant/calculator$ irb
2.6.0 :001 > require './lib/dividend_calculator_4'
0.04%
 => true 
(...)
2.6.0 :024 > puts DividendCalculator4.new.yield_for_stock(stock)
0.04%
 => nil 
2.6.0 :025 > puts DividendCalculator4.new.dividend_yield_for_stock(stock)
Traceback (most recent call last):
        4: from /home/vagrant/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `<main>'
        3: from /home/vagrant/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `load'
        2: from /home/vagrant/.rvm/rubies/ruby-2.6.0/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        1: from (irb):25
NoMethodError (private method `dividend_yield_for_stock' called for #<DividendCalculator4:0x000055adf0bb14c8>)
2.6.0 :026 > puts DividendCalculator4.new.payouts_for_stock(stock)
Traceback (most recent call last):
        5: from /home/vagrant/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `<main>'
        4: from /home/vagrant/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `load'
        3: from /home/vagrant/.rvm/rubies/ruby-2.6.0/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        2: from (irb):26
        1: from (irb):26:in `rescue in irb_binding'
NoMethodError (private method `payouts_for_stock' called for #<DividendCalculator4:0x000055adf0bd2768>)
```

If you feel like it’s inappropriate to have multiple instances of your class, consider using the Singleton design pattern to ensure that only one gets created. Fortunately, Ruby has a module built right into the language for turning a class into a singleton. All it takes is two additional lines in your code. Just as a reminder - the Singleton pattern can be abused so please use it judiciously.

```ruby
require 'singleton'

class DividendCalculator5
  include Singleton

  def yield_for_stock(stock)
    dividend_yield = dividend_yield_for_stock(stock)

    format('%<yield>.2f%%', yield: dividend_yield)
  end

  private

  def dividend_yield_for_stock(stock)
    payouts = payouts_for_stock(stock)

    total_payout = payouts.reduce(:+)

    total_payout / stock['price']
  end

  def payouts_for_stock(stock)
    if stock['payout_schedule'].eql? 'quarterly'
      stock['dividend_payments'].last(4)
    elsif stock['payout_schedule'].eql? 'monthly'
      stock['dividend_payments'].last(12)
    else
      stock['dividend_payments'].last(1)
    end
  end
end
```

Hopefully this example gives you an insight on how the aspects of a language affects how we end up writing code.

[View the source code for the example on GiHub.](https://github.com/dandelarosa/ruby-private-class-methods)
