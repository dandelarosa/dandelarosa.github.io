---
layout: post
title: "Docker and Backblaze"
summary: "How to prevent your containers and images from being backed up"
excerpt: "How to prevent your containers and images from being backed up"
---

I use [Backblaze](https://secure.backblaze.com/r/01kg35) as the service for backing up my Mac desktop online. Recently, I got a notification from Backblaze saying that my computer was low on disk space. My computer still had 100 GB of free space, so what triggered the notification? [This help article](https://help.backblaze.com/hc/en-us/articles/217665958-Why-do-I-get-a-popup-saying-NOTE-Your-Computer-Is-Low-On-Disk-Space-) provided a hint:

> If your computer's system hard drive has less than 1.1 times the size of the largest file scheduled to be backed up left in free space, Backblaze will not back up that file and alert the user.

Was there a file I created lately that was large enough to bring up the alert? [I started using Docker Desktop]({% post_url 2021-10-31-jekyll-on-docker %}) on my computer last month, and I remember from past experience that the [Docker disk image](https://docs.docker.com/desktop/mac/space/) can be tens of gigabytes large. I wasn't that difficult of an investigation.

[A blog post](https://alexwlchan.net/2020/01/excluding-lots-of-folders-in-backblaze/) by Alex Chan provides a programmatic way of excluding the Docker.raw file and other resources from your Backblaze backups. However, I'll provide a more straightfoward way of making this exclusion.

- In your Terminal window enter the command `open ~/Library/Containers`
- Drag the Containers folder into the Finder window's sidebar. This step is needed since this folder is usually hidden when you browse using Finder normally.

![alt text](https://cdn-blog.dandelarosa.net/2021/post_75/1.png "Step 1")

- Go to System Preferences > Backblaze Backup > Settings...

![alt text](https://cdn-blog.dandelarosa.net/2021/post_75/2.png "Step 2")

- Press the "+" button to add a folder to the list of excluded items
- Enter the Containers directly from the side bar and select the Docker > Containers > Docker folder

![alt text](https://cdn-blog.dandelarosa.net/2021/post_75/3.png "Step 3")

FYI, under the hood the folder is located at ~/library/containers/com.docker.docker

![alt text](https://cdn-blog.dandelarosa.net/2021/post_75/4.png "Step 4")

The applications I run on Docker are built from public images and configurations I've written - with the intention of demolishing and rebuilding an application easily - so there's no need to back up the contents of this environment. By setting up the exclusion, there's much less data that needs to be sent over to Backblaze and Docker is no longer looked at when calculating available space. I hope this tip has helped you as well.
