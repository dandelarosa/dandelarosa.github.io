---
layout: post
title: "Using Vagrant for Local Development"
---
When I interviewed for my current job I discussed with my future manager the engineering practices adopted by my previous companies. Test Driven Development was a process he wanted his squad to adopt, and to demonstrate the merits of TDD he wanted to show the codebase's test coverage (my new squad had over 90% code coverage, while my old team struggled to get around 30%). The tests failed to run due to a bug in one of the database libraries installed on my manager's Mac, and we couldn't find a solution since all of the troubleshooting articles we found were written for other operating systems.

Differences between individual development environments are inevitable. Teammates are all on different OS versions, softwares packages are installed from different sources, a tool one developer uses interferes with the system in a way others aren't experiencing. And that's if the team all agrees to work on the same operating system.

[Vagrant](https://www.vagrantup.com/) attempts to solve this issue by providing the tools needed to set up a uniform development environment across your team's devices. It works by propping up a virtual machine on your device for running your software application. By encapsulating the app in a sandbox, Vagrant minimizes the effects the subtle (or not-so-subtle) differences between each developer's machines have on the system.

The remainder of the article will be spent getting your device up to speed with Vagrant and get it to run a simple application.

# Install VirtualBox

[https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

# Install Vagrant

[https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

# Creating Your Project's Directory

TODO

# Run the Application

Enter [http://0.0.0.0:4567/](http://0.0.0.0:4567/) on your favorite browser and you should be able to see a webpage.

# Tearing Down and Subsequent Launches

TODO

# Wrapping Up

The final scripts can be seen below:
<script src="https://gist.github.com/dandelarosa/afa04bfa4ba84fbe295b13aecc3e79d5.js"></script>
