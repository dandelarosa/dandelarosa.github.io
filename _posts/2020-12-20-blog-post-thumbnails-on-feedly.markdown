---
layout: post
title: "Blog Post Thumbnails on Feedly"
---

I use Feedly as my news aggregator, and I subscribe to my own blog on Feedly to see how it appears on the platform. I don’t always include images with my posts, but I’m excited whenever this causes a thumbnail to appear on the feed. I’ll talk about a situation I’m investigating where a blog post contains images but doesn’t show a thumbnail in the preview.

Earlier this year [I set up a CDN]({% post_url 2020-01-20-setting-up-cdn-on-aws %}) for hosting the images that accompany my posts. This method was successful in getting thumbnails to appear in the feed.

![alt text](https://cdn-blog.dandelarosa.net/2020/post_37/1.png "Thumbnails Early 2020")

I didn’t use images again until the fall. This time I fiddled around with the process and I hosted images in the same repository as the textual content. I made the change because I wanted to start new blogs, and since these blogs would be self-hosted I would have to solve a new set of problems. If successful I would have a more streamlined workflow for writing blog posts. However, as demonstrated by [this blog post]({% post_url 2020-10-18-video-game-predictions-2005-part-2 %}) in October, the preview didn’t include any images.

![alt text](https://cdn-blog.dandelarosa.net/2020/post_37/2.png "No Thumbnails October 2020")

In [a recent post]({% post_url 2020-12-06-international-holiday-calendars-google-calendar %}) I went back to hosting images on the CDN and that resulted a thumbnail. It’s good to know I can still use that method in future posts.

![alt text](https://cdn-blog.dandelarosa.net/2020/post_37/3.png "Thumbnails Again December 2020")

My current theory is that Feedly only picks up images are hosted on a CDN subdomain (e.g. cdn-blog.dandelarosa.net). However, that is only one of the factors that could determine whether an image appears in the preview. I’ll run a more thorough investigation and report when I find more conclusive results.
