---
layout: post
title: "Simple"
---

_This is part six of a series on Extreme Ownership. View the previous parts if you haven't already: [Part 1]({% post_url 2020-06-14-extreme-ownership-1 %}) [Part 2]({% post_url 2020-06-28-extreme-ownership-2 %}) [Part 3]({% post_url 2020-07-03-extreme-ownership-3 %}) [Part 4]({% post_url 2020-07-12-extreme-ownership-4 %}) [Part 5]({% post_url 2020-07-19-extreme-ownership-5 %})_

It’s been a year since I interviewed for my current job, and my one-year work anniversary is right around the corner. I’ll use this time to reflect on the challenges my company faced going in and how Extreme Ownership aided us through one of these challenges.

One of my interviews I had for this job was with the company’s SVP of Product Engineering. One of the goals he wanted to achieve was to improve the productivity of the squads who worked on PeopleCloud. I when first joined the Audience Squad we made regular contributions, but without a singular vision the squad’s actions were relatively aimless. That began to change when the company Epsilon became a part of Publicis Groupe and absorbed the PeopleCloud ecosystem. We were put under leadership who had clear, tangible goals for our product, and these goals were tied to specific sprints. Now with an ambitious plan my squad needed to make sure we can deliver and hit these targets on time.

When the new year rolled around the Audience Squad experimented with a formula for evaluating how much work got done. At the end of each sprint, the squad got a score based on the point values of the stories completed, the point values of stories left incomplete, and the number of bugs fixed. Each category was weighted differently: incomplete stories subtracted from the total at double the rate as stories completed, stories being carried over multiple sprints brought on additional penalties, and bugs were tallied at one point each. The formula was structured to incentivize completing stories on time.

Sticking to the pointing system was difficult. First, tracking each story was a manual process; the act of measurement took up time that could’ve been spent on actual assignments. The formula did a bad job at identifying the work that took the highest priority; there were times where severe bugs had to be addressed quickly, pushing aside smaller features that offered points but were not as urgent. Lastly, our SVP ignored the formula in favor of [velocity charts](https://support.atlassian.com/jira-software-cloud/docs/view-and-understand-the-velocity-chart/), which was already a built-in feature in our project management software.

After a few months we shifted to a simpler system, one that was more rule-based instead of relying on manual work. The velocity chart showed us the total number of points completed in each sprint, and that allowed it to become our primary tool for measuring productivity. By having a single figure to focus on, we discovered improvements in our other processes to more accurately measure story completion.
* A readjustment on what is considered a story and what is considered a bug. In order for an issue to be filed as a bug it needs to cite a requirement that was violated in a previously completed story. Otherwise it needs to be considered net new work.
* Any bug whose solution requires a significant piece of work (e.g. a new API endpoint) would be converted to a story.
* When writing stories enough detail must be present so that hidden work isn’t discovered later on. We also held weekly grooming sessions so that engineering, product, and QA were all in agreement on what the requirements are for considering a story as complete. This allowed us to more accurately estimate story points.

Part of our journey of increasing productivity was making sure we were measuring it correctly to begin with. It turns out there was a lot of work we accomplished it but didn’t count in our existing system, giving our stakeholders the wrong impression that we weren’t making progress. The squad couldn't find or address this hole if we were actively managing a more complex system.

One of the principles in _Extreme Ownership_ is Simple. Leaders need to make sure plans and orders don’t become too complicated. If instructions are convoluted people may not understand them and thus won’t act on them. Each layer of complexity adds something that can go wrong; when things go wrong these factors compound on each other and spiral out of control.

Our squad was able to avoid total disaster by concentrating on one goal and adopting a leaner process. You should find ways to simplify how your team works to achieve better results.
