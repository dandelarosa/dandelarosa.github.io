---
layout: post
title: "My New Website"
excerpt: "I rebuilt my personal website using Angular Material."
---

[My main site](https://www.dandelarosa.net) was horribly outdated (I didn't even update it for my last job search) so I spent last month modernizing it. Here's a summary of the changes I made:

# Creating an Angular Project

In order to migrate my website, I first needed to be accustomed to developing in Angular on my machine. Angular runs off of Node, so I used NVM to install Node. I used this page as a reference for installing and using NVM: <https://github.com/nvm-sh/nvm/blob/master/README.md>. Then, I used the instructions on <https://angular.io/guide/setup-local> both to install Angular on my machine and to initialize a new Angular project.

At some point I'll figure out how initialize a Node project using Docker alone, without installing frameworks on my host machine beforehand.

# Local Development Using Docker

After generating a `package.json` file with the dependencies listed I set up a Docker container for hosting the Angular site on localhost while I worked on the code. I used a blog post for a reference for [creating the Dockerfile and docker-compose file](https://medium.com/bb-tutorials-and-thoughts/angular-local-development-with-docker-compose-13719b998e42). Here is the final Dockerfile below:

```
FROM node:lts
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "run", "start"]
```

Additionally, here's the docker-compose file:

```
version: '3'
services:
  angular-ui:
    build:
      context: ./web
      dockerfile: Dockerfile
    ports:
      - "4200:4200"
    container_name: angular-ui
    volumes:
       - ./web/src:/app/src
```

I had trouble exposing the Angular app, so I did some research and ran into [this article](http://imaginativethinking.ca/heck-get-connection-reset-peer-containerizing-angular-4-application/). Long story short, I had to swap out the default `start` method on the package.json with the following: `ng serve --host 0.0.0.0 --port 4200`.

# Switch from Bootstrap to Angular Material

I used Bootstrap as the design system on the previous iteration of the website. In a past attempt to upgrade the website, I tried combining Bootstrap with Angular but I ran into issues with the layout. I had a much easier time switching over to [Angular Material](https://material.angular.io/guide/getting-started) to handle the styling.

# Staging Environment

Rather than spin up an Angular server, I hosted the website on a static S3 bucket with a CloudFront instance for handling the SSL and caching. In order to verify that the setup works, I tested the new website in a staging environment before pushing it to production. Years ago, I wrote a blog post for [setting up AWS infrastructure for an image server]({% post_url 2020-01-20-setting-up-cdn-on-aws %}), I just had to modify the instructions slightly to have it work for a static website:
- Turn on static website hosting on the S3 bucket by going to Properties > Edit static website hosting
- In CloudFront, set the origin domain to the web hosting domain (staging.dandelarosa.net.s3-website-us-east-1.amazonaws.com) instead of the S3 bucket itself

# Additional Reading

All of the code changes can be viewed on this [pull request](https://github.com/dandelarosa/dandelarosa-website/pull/2).
