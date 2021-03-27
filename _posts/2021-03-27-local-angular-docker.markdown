---
layout: post
title: "How to Run a Stand-alone Angular App in Docker for Local Development"
---

[My website](https://www.dandelarosa.net) hasn’t been worked on in three years and it’s horribly outdated. A lot has changed in that time gap, including a change of employers. It doesn’t even link to this blog! The site’s due for a refresh.

However I’m not interested in merely editing some HTML files. This time I’m completely revamping my site so that it uses Angular, the frontend framework I use at work. This way I’ll have an opportunity to develop my frontend skills, on a real project, outside of my job.

I initially thought of using Vagrant and VirtualBox as the infrastructure for running the site locally, [like I have for previous projects]({% post_url 2019-08-29-using-vagrant-for-local-development %}). However, I caught a word of warning when listening to an episode of the Security Now! Podcast from last year. Apparently, Oracle, the creators of VirtualBox, charges users large sums of money for using their software for commercial use. (See pages 8-9 of [https://www.grc.com/sn/sn-764-notes.pdf](https://www.grc.com/sn/sn-764-notes.pdf)) Despite the fact that the license only applies to a specific extension, and the fact that I’m only using this technology for my personal site, I’d rather avoid the risk altogether. Plus, I haven’t used Docker for local development in a while so I might as well learn how to use it for my purposes.

Thankfully I’ve gotten help from my friends over at Conversant. Lead Engineer Nate Tovo wrote [an article](http://engineering.conversantmedia.com/technology/2019/10/01/typescript-hot-reload/) on running both a backend and a frontend using TypeScript. However, I’m only interested in running the frontend portion of the app so I modified the instructions to suit my needs.

Note: The following instructions are for running on macOS Mojave. Apologies you if need instructions for a different operating system.

## Install Homebrew

Homebrew is the package manager we’ll use for installing most of our dependencies on our Mac. Refer to [https://brew.sh/](https://brew.sh/) for specific installation instructions.

## Install Node

`brew install node`

## Install NPM

Currently [npm 7 is incompatible with Angular](https://github.com/angular/angular-cli/issues/19957#issuecomment-775407654), so we’ll need to downgrade to v6 for now.

`npm install --global npm@6`

## Install the Angular CLI

`npm install -g @angular/cli`

## Create the Project

Create a new folder, and go to that folder in Terminal. Initialize your project.

```
npm init
npm install tslib
```

Replace the "scripts" section of `package.json` with the following:

```
  "scripts": {
    "start": "docker-compose up -d",
    "debug:client": "npm run debug -C client",
    "postinstall": "npm install -C client"
  },
```

## Generate the Client App

Run this command: `ng new client`

During the process the Angular CLI will ask you to select a set of options.
* Say “yes” to stricter type checking
* Say “yes” to Angular routing
* Select Sass as the stylesheet format (since it’s the format used at work)

Switch over the `client` folder and edit the "scripts" section of website’s `package.json`

```
  "scripts": {
    "debug": "ng serve --host 0.0.0.0 --disable-host-check --poll=100",
  }
```

Pull back to the parent folder and test the app by calling `npm run debug:client`. The Angular application should be available at [http://localhost:4200/](http://localhost:4200/). Shut down the app before proceeding.

## Install Docker

Download the installer at [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)

## Create the Dockerfile

The `Dockerfile` has been modified to only run the frontend.

```
FROM node:12-alpine as base

WORKDIR /var/build

#---------- PRE-REQS ----------
FROM base as prereq

COPY package*.json ./
COPY client/package*.json client/ts*.json client/angular.json client/

RUN npm install --quiet --unsafe-perm --no-progress --no-audit --only=production

#---------- DEVELOPMENT ----------
FROM prereq as development

RUN npm install --quiet --unsafe-perm --no-progress --no-audit --only=development

## All files will be volume mounted into the container

EXPOSE 4200
```

## Create docker-compose.yml

Again, this file has been trimmed from the original so that it only runs the Angular part.

```
version: '3.6'
services:
  client:
    build:
      context: .
      target: development
    command: ["npm", "run", "debug:client"]
    container_name: client
    ports:
      - '4200:4200'
    volumes:
      - './client/src:/var/build/client/src:delegated'
      - './shared/src:/var/build/shared/src:delegated'
```

## Run the Application

Enter the command: `docker-compose up --build -d`

The site should be up again at [http://localhost:4200/](http://localhost:4200/).

See what's going on in your container by calling `docker logs --tail 100 -f client`

To shut down use `docker-compose stop`

## Closing Thoughts

I hope this setup can be used as starting point for working on your Angular application. As I mentioned, this is part of the process of updating my website. Feel free to follow its progress on the [`2.0`](https://github.com/dandelarosa/dandelarosa-website/tree/2.0) branch of the project on GitHub.
