---
layout: post
title: "Always Build the Naive Solution First"
---

As my manager remains on parental leave, I regularly revisit his past blog posts to make sure the team follows our established procedures and that these procedures achieve their intended goals. I reread my manager’s [article on writing user stories](https://redgreenrepeat.com/2020/10/02/how-to-write-better-sprint-stories/) and one part caught my eye:

> Omitting the “how to solve a story” gives the implementer freedom to approach the story as they wish. A newer team member can implement a naive solution while meeting all requirements. A senior can take a sophisticated approach.

I’m starting to think that this should not be the aspect that separates senior engineers from their junior counterparts. Specifically, developers of all experience levels should take the most naive solution as a first resort when implementing a user story.

This insight was probably a result of the work I did last quarter. The team had to add a billing feature in our application and I built a table in our database for entering the cost associated with each data vendor. Later, it turned out there was a complex ruleset for how costs were calculated; we had to write custom logic to make sure all scenarios were accounted for. In the end the team had no use for a lookup table, and my work ended up being a complete waste.

My team follows the principles of Test-Driven Development. As part of the methodology, a developer should only write enough code to satisfy the tests representing the story’s requirements. If I had just written a function that returned a hardcoded cost, that would’ve been more expandable and more relevant to the story’s concerns. This was an instance where the easier, simpler solution was the correct one.

If a more sophisticated solution is the eventual goal, there needs to be additional requirements to justify the extra work. Maybe the feature needs to be usable in other contexts and needs to take in other types of input. Maybe admins want to be able to modify the data, not just read it. Maybe there’s another metric - like runtime performance - that needs to be kept within an acceptable range. When these criteria aren’t explicit engineers might still build a solution that satisfies them all, but the extra work would not be counted when measuring our productivity. This was the very thing my manager wanted to avoid.

This begs the question: what should be the differences between senior and junior engineers? I’ve thought about three aspects that distinguish these levels apart:

- **Faster Development:** This is probably the most straightforward one to explain. Quality remaining equal, senior developers get stories done quicker, meaning they can complete more stories than their peers in a single sprint.
- **Higher Code Quality:** Senior developers should consistently write simple, readable code. The tests they write cover a wide range of conditions and are also easy to understand. However, junior developers should still take an effect to build this skill so that code quality is at the same level across the entire team.
- **Ability to See the Bigger Picture:** Senior developers have a system-wide understanding of their work, unlike their peers whose focus is limited to smaller-scoped assignments. Seniors are responsible for sharing this understanding, so that the rest of the team can build systems with the same level of awareness.

In the end, development speed should be the only metric that distinguishes engineers apart, especially if a team refuses to compromise on the other aspects of development.

If a user story can result in a wide variety of solutions, that means the story wasn’t specific enough. An engineer should stride for the simplest solution possible, provided that code quality is maintained, to move on to the next story and deliver the maximum value per time spent. A larger set of requirements needs to be written out to convince an engineer to build a more sophisticated solution.
