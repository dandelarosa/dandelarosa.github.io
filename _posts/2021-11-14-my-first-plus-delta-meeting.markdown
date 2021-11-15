---
layout: post
title: "Takeways From My First Plus/Delta Meeting"
summary: "What do my teammates think about my work?"
excerpt: "What do my teammates think about my work?"
---

Last week my team and I went through their first Plus/Delta meeting. [This article](https://leanconstructionblog.com/Using-Plus-Delta-for-Feedback-and-Improving-Social-Processes.html) on the Lean Construction Blog does a good job describing the structure and applications of the Plus/Delta (also known as Do Again/Do Better and Plus/Change) methodology. This time, the subject of our meeting was ourselves.

Each member of our team was paired with one another, in a round robin format so that we had an opportunity to talk to every other member. Each round, we had ten minutes to point our two things the other person has done well and two things the other person should improve. Here's a summary of the feedback given to me.

# Do Again

My teammates view me as a "open book," someone they can look to for information. I'm the team's greatest asset when I **share information**, whether it is on programming techniques or our product's history. I need to remain available to help my teammates out, providing whatever valuable nugget they need to unblock them.

In addition to being knowledgable, my teammates complimented me on being detail oriented, particularly when it comes to the team's roadmap. I'm one of the few people who can **identify the actions the team needs to make to move forward**. I need to continue guiding the team in the right direction, by processing requirements that are vague or unorganized and turn those into concrete tasks the team can take on to complete their objectives.

# Do Better

In previous years the value I provided at work was as an individual contributor, carrying the team by executing tasks well. While it arguably worked for the time, it did leave my teammates to fend for themselves. Last week my team challenged my previous assumption, stating that I bring more value by helping out other members.

Choosing between executing and leading has been difficult choice for me. Picking one over the other has significant consquences:
- If I manage instead of contribute, the team's productivity is reduced. In the worst case, when the team consisted of only two engineers, switching to a more managerial role would cut our work capacity by as much as 50%.
- If I focus solely on executing as an individual contributor, we risk leaving he rest of the team uncoordinated. Teammates may work on the wrong task, or face insurmountable roadblocks in their work.

As my team rehires, the former concern will diminish. The value I add to the team will multiply when I take the focus off of myself and help newer team members get up to speed. **I need to finally accept my new leadership role.**

When discussing solutions with teammates they sometimes notice a resentful tone in my voice. I try to keep a hands-off approach when it comes to API design since [I want my team to deliver quickly]({% post_url 2020-11-22-always-build-naive-solution-first %}) and I don't want to argue about solutions if they don't contradict requirements brought forth by product. However, it is apparent that **I carry some design philosophies that I'm not sharing.**

My manager has more or less solidified guidelines for writing and submitting code changes:
- Use [Test-Driven Development](https://redgreenrepeat.com/2021/11/13/starting-the-test-driven-development-habit-ping-pong/).
- Keep the main repository clean by putting feature branches [on your own fork](https://redgreenrepeat.com/2021/11/10/git-always-fork/).
- Keep the git history concise by encapsulating each feature or bugfix [in a single commit](https://redgreenrepeat.com/2021/11/11/git-always-squash/).
- Turn the git history into a useful piece of documentation by [writing good commit messages](https://redgreenrepeat.com/2021/11/12/git-always-write-good-commit-messages/).

Go one level up, however, and everything is a free-for-all. When writing a backend a number of questions need to be answered, including:
- What are the names of each resource?
- Should each resource be prefixed with a version number e.g. `/v1`?
- What actions can be done on each resource?
- For each action, which HTTP verb should be used to invoke that action (GET, POST, PUT, PATCH, DELETE)?
- Should we suppport custom (non-RESTful) actions on resources?
- How should request bodies be formatted?
- How should response bodies be formatted if the request is sucessful?
- How should response bodies be formatted if we need to report an error?

It's an open-ended exercise, and one we haven't discussed in great depth. Sometimes the other technologies we use impose constraints we can't circumvent, so some decisions have already been made for us. In the past [I found]({% post_url 2020-11-08-reading-list-restful-api-best-practices %}) [some resources]({% post_url 2020-11-15-getting-acquainted-with-json-api %}) to help answer the remaining questions. However, sometimes the guidlines conflict with one another so I cannot simply point to them; there are still decisions the team needs to make on their own. The only way to get the team to design better APIs is to bring up these topics more often.

Last week's Plus/Delta meeting was useful for me, as it identified where to focus my efforts moving forward. I had productive conversations on what my teammates like the most about me and needs the team has that I still need to fulfill. I have some burdens lifted from me now that I have the clarity to make better decisions in the future.
