---
layout: post
title: "Leading Up and Down the Chain of Command"
---

_This is part nine of a series on Extreme Ownership. View the previous parts if you haven't already: [Part 1]({% post_url 2020-06-14-extreme-ownership-1 %}) [Part 2]({% post_url 2020-06-28-extreme-ownership-2 %}) [Part 3]({% post_url 2020-07-03-extreme-ownership-3 %}) [Part 4]({% post_url 2020-07-12-extreme-ownership-4 %}) [Part 5]({% post_url 2020-07-19-extreme-ownership-5 %}) [Part 6]({% post_url 2020-07-25-extreme-ownership-6 %}) [Part 7]({% post_url 2020-08-02-extreme-ownership-7 %}) [Part 8]({% post_url 2020-08-09-extreme-ownership-8 %}) [Part 9]({% post_url 2020-08-16-extreme-ownership-9 %})_

Leadership is bidirectional. On one hand, leaders must give a sufficient explanation on why a team embarks on a mission and how they fit into the bigger picture. On the flip the side, leaders have the ability to influence their superiors as well. Like in the book _Extreme Ownership_, I’ll provide anecdotes that demonstrate the importance of communication up and down the org chart.

# Leading Down the Chain

In the past my team operated without a strict agenda. The company's product managers mostly planned for the short term, having us create features or fix bugs that felt right at that moment. Without a sense of urgency we approached work with a casual attitude, sometimes letting tasks slip from sprint to sprint. We got away with this for years since there weren’t any consequences for slow delivery. However, we had to take things more seriously once our product fell under new management.

New ownership gave us specific objectives to reach. The Senior VP who took over the product conducted conference calls every quarter describing the features he wanted us to add in those three months. Those translated down the chain to work plans devised by each product team. My product manager and my engineering director developed a work schedule in which specific user stories would be completed in each sprint. We couldn’t let work slip anymore, since doing so would cause a domino effect of goals not being hit.

Our engineering director found ways for the team to work more productively. Before each sprint we went over how each story could be implemented, allowing us to hit the ground running when the sprint began. Rather than run in circles for days trying to solve a problem, team members reached out experts in the organization the moment they ran into trouble. In exchange, we asked product managers for more detailed user stories; by having specific expectations we produced the correct deliverable on our first attempt and reduced the number of times work had to be redone. We were able to adhere to our increased responsibilities without committing extra hours in the week to do so.

# Leading Up the Chain

Our product is split into two sections, each managed by an independent team. My manager is the engineering director for our team’s section of the app. While he is an expert in Ruby on Rails he is not as savvy with frontend development.

I was recently tasked with taking in code that another team wrote to be used in our section of the app. At first it seemed like all I had to do was reference a function they wrote, but it turned out there was a long list of prerequisites that had to be fulfilled in order for this to work. Not only did I have to import the service containing the method, but also all of its dependencies. This process had to be done in not just the components that used this function but also in all of their tests. Even after doing this I found out the data wasn’t even flowing from service to service during runtime. What started off as a simple task ended up being excessively complicated.

_Extreme Ownership_ suggests bringing senior leadership on to the field to show them the problems being encountered on the ground floor. That’s exactly what I did when I had my weekly pair programming session with my manager. I showed my manager the steps I took to get to my current situation, and it was enough to convince him that there were things we could’ve done better leading up to this task. The other team wrote their methods specifically to serve their part of the UI, and our team made the faulty assumption that we could reuse it for our purposes. I ended up writing my own version of the function and shelved the discussion of reusability for later. We learned a valuable lesson that the product teams need to work more closely in order to set each other up for success.

# Conclusion

Don’t keep your team in the dark. Often there is crucial information that can decide the outcome of an initiative and that needs to be brought up with the people who can take action on it. The people above and below you want you to succeed, but they can’t read your mind. You’re responsible for letting them know what’s going on so you can get them to serve your needs.
