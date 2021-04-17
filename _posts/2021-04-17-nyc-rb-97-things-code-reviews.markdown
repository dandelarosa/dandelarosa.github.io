---
layout: post
title: "My Appearance at nyc.rb: Discussing Code Reviews"
summary: "I discussed 97 Things Every Programmer Should Know: Code Reviews"
---

This week I appeared on a panel for [April’s nyc.rb Meetup](https://www.meetup.com/NYC-rb/events/ccqfgsyccgbsb/). In this event we discussed entries from the book [97 Things Every Programmer Should Know](https://97-things-every-x-should-know.gitbooks.io/97-things-every-programmer-should-know/content/en/index.html). I was selected as one the experts and spoke about the chapter on [Code Reviews](https://97-things-every-x-should-know.gitbooks.io/97-things-every-programmer-should-know/content/en/thing_14/).

At this point everyone is aware of the merits of having code reviews. However, there are good ways and bad ways of conducting them. When done wrong, people become averse to the process. They won’t welcome the process if they feel like their code is being graded, like they’re afraid they’re going to end up with an ‘F’ and a note that says, “see me after class.”

And that’s a perfectly valid fear. My past experience was being a grader for Computer Science, and that was exactly how I conducted these reviews when I started my career.

Later, I assumed the role as the gatekeeper of the codebase, making sure code changes were “good enough” before pulling them in. This is a trap senior engineers fall into.

In the worst case code reviews are a political weapon software architects wield against their junior counterparts. Years ago I spoke to someone who worked at Google and cited that very thing as why he left the company.

So, how do we do it right? The first step is to remind ourselves why we review code to begin with. Code reviews should be an opportunity to coach peers, not condemn them. Instead of finding errors, we should teach developers what constitutes high-quality code.

Additionally, all developers on the team should be allowed to provide feedback. Code reviews aren’t in the exclusive domain of your most senior engineer; even programmers who are completely new can add value to the process. Everyone should be able to assume the role of reviewer, and they should be able to review any part of the codebase.

Author Mattias Karlsson suggests a specific methodology that I hadn’t considered before reading this chapter. Instead of limiting code reviews to pull requests, an entire day should be devoted to code reviews each week.

What should we actually look for during a code review? [Maslow’s pyramid of code reviews](http://www.dein.fr/2015-02-18-maslows-pyramid-of-code-review.html) dictates which aspects of the code to evaluate first. At a bare minimum, the code should work correctly; only afterwards can reviewers comment on readability and other aspects of code quality. These guidelines are useful when one is pressed for time and can’t provide a full review.

Notice what isn’t part of the process. We’re not judging every single detail in the code. This includes styling issues. Hopefully your team uses a linter to enforce styling rules objectively, consistently, and in an automated fashion. Use your tools to get those revisions out of the way and focus on the more pertinent items.

## Read More
- [My Quest for Elegant Code]({% post_url 2020-10-25-my-quest-for-elegant-code %})
- [Extreme Ownership]({% post_url 2020-06-14-extreme-ownership-1 %})
- [Elsewhere in the Universe: TERF Wars Edition (March 2021)]({% post_url 2021-04-03-elsewhere-in-the-universe-march-2021 %})
