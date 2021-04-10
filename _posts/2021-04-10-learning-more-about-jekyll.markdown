---
layout: post
title: "Learning More About Jekyll"
summary: "Learning how to tweak meta tags and stuff on my Jekyll blog"
---

When I work on this blog, most of my time is spent writing posts, leaving little room to work on the underlying platform. Fortunately, I had some extra time last week to learn more about Jekyll, the engine running this blog. Here’s a summary of the changes I made to the blog’s functionality.

## Feedly Shows Previews Only

Previously if you’ve subscribed to this blog on Feedly (or other RSS reader) you’ve been able to views full articles on your feed. Sorry readers, but from now on you’re going to have to click through to the actual site to read.

Making the feed excerpt only is one of the built-in settings on the Jekyll-feed plugin. Insert the following into your site’s _config.yml:

```
plugins:
  - jekyll-feed

feed:
  excerpt_only: true
```

## Twitter Card Support

Whenever I posted links to past articles on Twitter the previews were fairly sparse. There’s no image on the Twitter Card, even though Feedly was able to pick up the image in the post. Instead of an excerpt from the post, the Twitter Card embeds the "About" section of my blog. All previews until now were way too generic.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Happy New Year! Instead of picking a New Year&#39;s Resolution, I&#39;m writing about one mistake I made (professional or otherwise) each year for the past five years.<br><br>In 2017: I Almost Started a Sports Bar (and Put My Friend in Financial Trouble) <a href="https://t.co/AwutftZCbw">https://t.co/AwutftZCbw</a></p>&mdash; Dan Dela Rosa (@dandelarosadev) <a href="https://twitter.com/dandelarosadev/status/1348345553554468865?ref_src=twsrc%5Etfw">January 10, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Last week I figured out what needed to be done get the Twitter Cards to appear the way I wanted. I can now specify which image appears on the preview (if there's one present) and add some flavor text too. My Twitter posts are starting to look legitimate now.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">On this month’s recap: an anime series (not live action), video games (still not live action), Triple J’s Like a Version (more live than live action), and an author’s personal vendettas (too real). <a href="https://t.co/P3YKxUTq1y">https://t.co/P3YKxUTq1y</a></p>&mdash; Dan Dela Rosa (@dandelarosadev) <a href="https://twitter.com/dandelarosadev/status/1378459831779069957?ref_src=twsrc%5Etfw">April 3, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

A quick Google search sent me to [this post](https://brianbunke.com/blog/2017/09/06/twitter-cards-on-jekyll/) showing me how to get this done in Jekyll. I needed to override the Minima theme, injecting my own [head.html](https://github.com/dandelarosa/dandelarosa.github.io/blob/08ca454860c627e7ed2f9f0f8aa02c110284f975/_includes/head.html) and adding a [custom-head.html](https://github.com/dandelarosa/dandelarosa.github.io/blob/08ca454860c627e7ed2f9f0f8aa02c110284f975/_includes/custom-head.html) for generating and embedding the meta tags.

## Hosting a Staging Environment With S3

I needed to safe way to validate that the above functionality would work, especially given the major changes made to the code. Luckily, [Twitter has a tool for previewing Twitter Cards](https://cards-dev.twitter.com/validator) (Twitter login required). However it only takes in URLs, meaning a test version of the blog has to be present somewhere on the Internet (not on my local machine).

Fortunately, Jekyll works by rendering static files, which I can upload into an S3 bucket. I revisited [an article I previously wrote]({% post_url 2020-01-20-setting-up-cdn-on-aws %}) on setting up a CloudFront instance for serving static files. Since the location is meant to be secret I skipped part where I set up a local domain - though I probably could’ve peeled back one more layer and worked with the S3 bucket directly. Nonetheless I was able to get the Twitter Card to appear exactly how I wanted to be without having to test in production.
