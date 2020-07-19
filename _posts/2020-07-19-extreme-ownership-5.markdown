---
layout: post
title: "Cover and Move"
---

_This is part four of a series on Extreme Ownership. View the previous parts if you haven't already: [Part 1]({% post_url 2020-06-14-extreme-ownership-1 %}) [Part 2]({% post_url 2020-06-28-extreme-ownership-2 %}) [Part 3]({% post_url 2020-07-03-extreme-ownership-3 %}) [Part 4]({% post_url 2020-07-12-extreme-ownership-4 %})_

It’s funny how large software platforms come to be. These behemoths are composed of numerous subsystems, each of which could be a separate product in their own right. These elements were developed by disparate teams, none of them sharing a common vision. Sometimes these systems were in fact separate products in a past life, only glued together as a result of corporate mergers and acquisitions.

I’ve discovered two phenomenon that are prevalent when dealing with these gigantic systems:
* **Telephone** when a message is sent down the chain of communication, its meaning gets lost or altered in translation. This manifests in two forms. The first is when data is passed along from system to system, sometimes changing format going from one to the other. Information may be added or removed, and its final form is unrecognizable from its starting point; in the worst case the data has become unusable and it’s difficult to tell why. The other is when dev teams communicate with one another. You ask for feature X and get Y instead. Often the offending party isn’t the team you interface with directly, but another team deeper in the org chart. A misunderstanding or misinterpretation of the requirements leads to the unexpected result.
* **Square Peg, Round Hole** when you’re trying to make software do what it wasn’t built to do. If you’re in System A you want to send each item in an order to a different recipient…but System B only allows one recipient per order? Split the transaction into multiple orders so that System B can accept it. You're always brushing against the mental models and assumptions held by other developers. Sometimes you can safely work around these incompatibilities; other times the complications multiply once you expand your reach to another system. These haphazard solutions are commonly known as _hacks_.

This post doesn’t address the latter problem; in reality you only have a month or so to roll out a new feature with the tools you have and you can't roll back tech decisions that have already been made. On the other hand, Cover and Move can help teams work together as they navigate these treacherous waters.

When Staples acquired Makr one of the first features they wanted to add to the Makr app was the ability to print and pick up projects in Staples stores. This integration required work on all fronts:
* Makr added a Staples store picker to the app and adjusted the order model to include the selected store.
* PNI Digital Media - another company Staples had acquired - acted as an intermediary and relayed order information from Makr to Staples. PNI handled Staples Design & Print which was why it made sense for print orders to go through them instead of Staples directly.
* Orders then funneled through Staples’ order router, which likely passed through a number of layers internally before eventually reaching the store.

Sending orders for in-store pickup was an exercise in trial and error. It was like playing the Plinko game on _The Price is Right_ and hoping your token doesn’t land on the $0 spot. Orders dropped off in the middle of the pipeline due an invalid value being plugged into the system. Cards would be printed with the wrong color profile or the backs would be printed upside down. Getting the system to work required a lot of communication and the ability to make adjustments quickly.

It was clear that we needed daily check-ins at the very minimum to gauge whether our systems were working as intended. Someone from each team participated in daily calls to ensure that all parties were represented. Every day, each and every order in the test environment was examined and we reviewed how they passed through each stage of the process. If something went wrong we identified which system was at fault and specific actions for fixing the issue. Once these refinements were made we repeated the process with another batch of orders until the entire platform was ready to migrate to production.

Although this initiative was done years before I read _Extreme Ownership_ it was an example of one of the book’s principles, Cover and Move, in play. In summary, Cover and Move calls for everyone to collaborate closely to achieve a singular goal. Here are the core components of the principle:
* Individuals and teams must work together as a single unit. Each party needs to overcome the “us vs. them” mentality and break down silos. Staples actually had this problem in the past, where technology (engineers and IT) were treated as separate vertical called Global Technology. This structural barrier made it hard for them to work effectively with non-technical staff.
* Each party must take actions to support one another. The reason why this principle is named “Cover and Move” is that in the military anecdote that inspired this principle, two units alternated between advancing to a new location and providing cover fire while the other team moved.
* Always keep in mind dependencies between teams. Issues encountered by other teams can’t be dismissed as “not my problem” as they may affect your work down the line.

Contributing to large, complex system is a daunting task, but it is made easier when everyone agrees to work on the same side and take the steps needed to work in harmony.
