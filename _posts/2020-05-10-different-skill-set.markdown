---
layout: post
title: "Do I Just Have a Different Skillset?"
---

I initially had a couple of projects in the works that would become the topic of upcoming posts. However, I heard a tidbit from [last week's episode](https://omny.fm/shows/unsupervised-learning/unsupervised-learning-no-227) of Daniel Miessler's podcast Unsupervised Learning that I chose to use as a conversation starter instead. From the 16:19 mark:

> The most popular phone interview question at Google: How do you detect the first repeated character in a string?

Given that I interviewed for engineering jobs last year I decided to give it a shot. The first two things I recognized from the problem are:

- A string a sequence of characters, so the algorithm is likely to look at each character in the given order.
- For each character we'll need to remember whether we've encountered it previously, so let's use a `HashMap` to map between a string and a boolean value. (Java was first language I learned in any serious capacity which why I often use the class names from Java's Collections framework to refer to different data structures.)

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

- It took a couple of minutes to think about the interview question, even to get to those first two points. Maybe this was because I was listening the podcast early in the morning while making my bed, but that doesn't excuse me if I'm not quick to mind in an actual interview setting either.
- I kept misusing syntax from various languages in my script. I initially wrote the for loop as `for(i = 0; i < s.length; i++)` which results in a runtime error in Ruby, and honestly I had to look up how to write a loop that goes from one integer to another. Ruby has become the programming language I've used the most at work but there still aspects of the language I've used less often that are necessary to bring to a coding interview, causing me to fall back on experiences with other languages that translate poorly to my primary one.
- Typically there would be follow-up questions discussing the performance of the script and ways to optimize it. I didn't realize there were alternate solutions until I found [this solution](https://stackoverflow.com/a/51596685) on Stack Overflow that used two for loops instead of one for loop and a hash. Maybe I would state that the former trades off time complexity to save space, but I fear I wouldn't get to that point if didn't get a hint from the interviewer.

Last year I interviewed with twenty companies and only landed an offer from one. You could argue that the position I ended up with is only the one that matters, but it's difficult to call a .050 batting average a success given my techincal founder status. My former coworkers were confident I would easily land a job after Makr dissolved, and my current team would probably say the same now. At the same time I feel insecure seeing how poorly my last journey went. Will I be lucky the next time around?

Maybe I'm just overthinking this. Simply put, I would've been more successful if I spent more time practicing interview questions instead of trying to start three companies while looking for a job.
