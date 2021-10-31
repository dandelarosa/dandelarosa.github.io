---
layout: post
title: "Jekyll on Docker"
summary: "Transitioning from VirtualBox & Vagrant to docker-compose"
excerpt: "Transitioning from VirtualBox & Vagrant to docker-compose"
---

I just upgraded the local environment for developing this blog. Previously, I used [a combination of Vagrant and VirtualBox]({% post_url 2019-08-29-using-vagrant-for-local-development %}) to run Jekyll; now I've found out how to do it all from Docker. I did this for the following reasons:

- As I hinted at [in an earlier blog post]({% post_url 2021-03-27-local-angular-docker %}), there are [legal risks](https://www.grc.com/sn/sn-764-notes.pdf) to using VirtualBox that I'd rather avoid altogether.
- There's only so much that Vagrant and VirtualBox provides out of the box. I had to write separate scripts for installing Ruby, Jekyll, and other dependencies. By contrast, there's a [Docker image](https://github.com/envygeeks/jekyll-docker) that does the heavy lifting for you.
- Every time there is a new version of either Vagrant, VirtualBox, or Ubuntu I would have to up manually update that dependency (and sometimes the latest versions of each aren't compatible with each other). With Docker I only need to install new versions of Docker Desktop when they arrive, and since my team [is now using Docker](https://engineering.conversantmedia.com/technology/2019/10/01/typescript-hot-reload/) in our everyday work it's something I'm already keeping up to date.

Transitioning to Docker was pretty easy. [This blog comment](https://dev.to/hyzyla/comment/o6oa) provided a Compose file for running Jekyll locally. I only needed to make small edits to get it to work for my purposes:

```yaml
version: "3.8"
services:
  web:
    container_name: dandelarosa-blog
    image: jekyll/jekyll:latest
    command: jekyll serve --livereload
    ports:
      - "4000:4000"
    volumes:
      - .:/srv/jekyll
```

All I need to do now to launch my Jekyll project is call `docker-compose up` on my project root. I'm glad that I'm finally on a single-line setup.
