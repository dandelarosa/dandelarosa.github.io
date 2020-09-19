---
layout: post
title: "Refactoring: Replace Conditional with Polymorphism"
---

At NYU I took a course called Production Quality Software, which was taught by an engineer at Google. While I took the class before I programmed professionally, it served as a foundation on how I approached software development throughout the years. The course taught me several software engineering practices such as refactoring, the act of making code easier to read without changing its functionality.

Recently my team started working on a billing module for our product, which has to follow a vast set of rules. My engineering director was afraid the code would become complex and unmaintainable. Here’s what the code would’ve looked like after sketching it out (the class, method, and variable names have been altered to avoid revealing work secrets):

```ruby
class CostReporter
  def get_price_for_item(item)
    if cart_country.eql? 'US'
      if item.sku.eql? product_1_sku
        if product_1_is_only_item
          return product_1_regular_price * item.qty
        else
          return product_1_discount_price * item.qty
        end
      elsif item.sku.eql? product_2_sku
        if item.variant.eql? product_2_variant_1
          return product_2_variant_1_price * item.qty
        else
          return product_2_variant_2_price * item.qty
        end
      end
    elsif cart_country.eql? 'CA'
      if item.sku.eql? product_3_sku
        return product_3_price * item.qty
      end
    end
  end
end
```

It barely looks manageable now. As time passes we’ll implement more rules and this method will eventually be completely unreadable.

I mentioned a strategy that would make this module easier to manage. Software guru Martin Fowler wrote [a book on refactoring](https://martinfowler.com/books/refactoring.html), cataloging assorted techniques for improving your code’s readability. The catalog of refactorings [is available online](https://refactoring.com/catalog/), and it is a useful resource even if it's missing the detailed explainations from the book. One of the refactorings is called [“Replace Conditional With Polymorphism”](https://refactoring.com/catalog/replaceConditionalWithPolymorphism.html ).

Rather than storing all of the business logic in a nested conditional, each conditional can be encapsulated in a separate class. On the top level you only need to worry about which branch you’ll go into, and the classes give you context on what its respective piece of logic represents.

```ruby
class CostReporter
  def get_price_for_item(item)
    if cart_country.eql? 'US'
      cart = USShoppingCart.new
    elsif cart_country.eql? 'CA'
      cart = CanadaShoppingCart.new
    end

    return cart.get_price_for_item(item)
  end
end

class USShoppingCart
  def get_price_for_item(item)
    if item.sku.eql? product_1_sku
      if product_1_is_only_item
        return product_1_regular_price * item.qty
      else
        return product_1_discount_price * item.qty
      end
    elsif item.sku.eql? product_2_sku
      if item.variant.eql? product_2_variant_1
        return product_2_variant_1_price * item.qty
      else
        return product_2_variant_2_price * item.qty
      end
    end
  end
end

class CanadaShoppingCart
  def get_price_for_item(item)
    if item.sku.eql? product_3_sku
      return product_3_price * item.qty
    end
  end
end
```

Breaking the code down to smaller, easily identifiable chunks makes it easier to navigate. Note how much more compact and straightforward the `CostReporter` class is. I’ve only abstracted out one layer of the code; can you find ways to refactor the code even further?
