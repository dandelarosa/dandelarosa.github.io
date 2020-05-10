---
layout: post
title: "Do I Just Have a Different Skillset?"
---

I initially had a couple of projects in the works that would become the topic of upcoming posts. However, I heard a tidbit from [last week's episode](https://omny.fm/shows/unsupervised-learning/unsupervised-learning-no-227) of Daniel Miessler's podcast Unsupervised Learning that I'd like to use as a conversation starter instead. From the 16:19 mark:

> The most popular phone interview question at Google: How do you detect the first repeated character in a string?

Given that I interviewed for engineering jobs last year I decided to give it a shot. The first two things I recognized from the problem are:

- A string a sequence of characters, so the algorithm is likely to look at each character in the given order.
- For each character we'll need to remember whether we've encountered it previously, so we'll need a `HashMap` to map between a string and a boolean value. (Java was first language I learned in any serious capacity which why I often use the class names from Java's Collections framework to refer to different data structures.)

Here's the Ruby code I wrote that implements the solution:

```
#!/usr/bin/ruby

str = 'abacab'

def first_repeated_character(s)
  seen = Hash.new
  for i in 0..s.length
    c = s[i]
    if seen[c]
      return c
    else
      seen[c] = true
    end
  end
end

puts first_repeated_character(str)
```

Not bad, right? However, there were problems I ran into while completing the exercise.

- I had trouble with waht most would consider Ruby basics. language (`for(i = 0; i < s.length; i++)`) this is mainly because I mostly use `collection.each do |item|`
