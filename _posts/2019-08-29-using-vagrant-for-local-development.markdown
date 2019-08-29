---
layout: post
title: "Using Vagrant for Local Development"
---
When I interviewed for my current job I discussed with my future manager the engineering practices adopted by my previous companies. Test Driven Development was a process he wanted his team to adopt, and to demonstrate the merits of TDD he wanted to show the codebase's test coverage (my squad's product had over 90% code coverage, while my previous team struggled to get around 30%). The tests failed to run due a bug in one of the database libraries installed on my manager's Mac, and we couldn't find a solution since all the troubleshooting articles we found were written for other operating systems.

You can read more about Vagrant on [the official website](https://www.vagrantup.com/).

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
