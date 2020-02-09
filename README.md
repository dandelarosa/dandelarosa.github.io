# Initial Setup

## Install VirtualBox

_Curently Vagrant doesn't support the newest version of VirtualBox so you'll need to install an early version instead._ https://www.virtualbox.org/wiki/Download_Old_Builds_6_0

https://www.virtualbox.org/wiki/Downloads

## Install Vagrant

https://www.vagrantup.com/downloads.html

# Running from Vagrant

## Start up the machine
`vagrant up`

## Log into the machine
`vagrant ssh`

## Launching the local Jekyll site

Use the `--force_polling` flag to work around the issue where the blog doesn't automatically update locally.

`bundle exec jekyll serve --force_polling`

To test Google Analytics

`JEKYLL_ENV=production bundle exec jekyll serve --force_polling`

# Shutting down

Press ctrl-c to stop the server and `exit` out of the Vagrant SSH session.

Then use `vagrant halt` to power down the virtual instance.
