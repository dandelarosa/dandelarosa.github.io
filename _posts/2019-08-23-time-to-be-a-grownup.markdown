---
layout: post
title: "Time to Be a Grownup With a Grownup Job"
---
Imagine this scenario: the night before you launch your app your team finds a blocker on the site's checkout flow. They can't continue to the next page because of a CORS error. I was an iOS developer; I did some backend and I wrote HTML code as teen but I had no clue how to tackle a browser-side issue like that. Our VP of Engineering coded the web portal and should've been there to take care of it but he flew out on vacation with his fiancé that week. He booked the trip in advance and we were supposed to launch back in July, but of course you can't roll out a brand-new ecommerce platform in three months, and somehow we OK'd moving the launch date to when he was away. We couldn't delay the launch again because we had a Wired article say the app would be out _tomorrow_.

Scrambling to find someone well-versed in Node.js (this was five years ago, before Node ramped up in adoption), we eventually pulled in a dev half-tipsy from a tech meetup. Instead of putting out the tech fire we argued about whether we should host the website on Heroku or our own servers and why an HTTP response said `Cannot GET /`. (Dude, it's the root path of an API, it's not supposed to return anything.) We thought we could fix things by pointing the production servers to the staging database and vice-versa, and by some miracle the CORS error disappeared. Our CEO satisfied, I took an Uber home at midnight (apologies to the lady we almost ran over), and broke the website from home after increasing the number of Heroku dynos to handle the morning's web traffic.

Our VP had to rewire the website from a castle in Germany the following day.
