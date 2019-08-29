---
layout: post
title: "Using Vagrant for Local Development"
---
When I interviewed for my current job I traded notes on engineering practices with my future manager. Test Driven Development was a process he wanted his squad to adopt, and to demonstrate the merits of TDD he wanted to show the codebase's test coverage (my new squad had over 90% code coverage, while my old team struggled to get around 30%). The tests failed to run due to a bug in one of the database libraries installed on my manager's Mac, and we couldn't find a solution since all of the troubleshooting articles we found were written for other UNIX-based operating systems.

Differences between individual development environments are inevitable. Teammates are all on different OS versions, softwares packages are installed from different sources, a tool one developer uses interferes with the system in a way others aren't experiencing. And that's if the team all agrees to work on the same operating system.

[Vagrant](https://www.vagrantup.com/) attempts to solve this problem by providing the tools needed to set up a uniform development environment across your team's devices. It works by propping up a virtual machine on your device for running your software application. By encapsulating the app in a sandbox, Vagrant minimizes the effects the subtle (or not-so-subtle) differences between each developer's machines have on the system.

The remainder of the article will be spent getting your device up to speed with Vagrant and get it to run a simple application.

## Install VirtualBox

Vagrant uses virtual machines, but it does not itself provide them. VirtualBox is a free virtualizer from Oracle, that is what we will use for local development. Download and run the installer from this page: [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

## Install Vagrant

Now download and run the installer for Vagrant from this page: 
[https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

## Creating Your Environment

### The Vagrantfile

Create an empty directory on your computer. Then, create a text file called `Vagrantfile` in that directory. We'll go line by line the contents you'll add to the file.

```
Vagrant.configure("2") do |config|
```

This line tells Vagrant that we'll want to create a configuration object for our project. The "2" indicates that this configuration is compatible for Vagrant versions 1.1 through 2.0.x.

```
  config.vm.box = "ubuntu/bionic64"
```

This selects the box we'll load into the virtual machine. Boxes are prebuilt environments that include the operating system and other essential software, and they serve as the basis for our Vagrant projects. For this project we'll pick the 64-bit version of Ubuntu 18.04.3 (Bionic Beaver).

```
  config.vm.network "forwarded_port", guest: 4567, host: 4567
```

By default, network traffic cannot access the virtual machine. This line takes a port on the host machine (outside the VM) and forwards traffic to a port on the guest machine (within the VM). The host port can be mapped to a value different from the guest port, but for simplicity's sake we'll keep them the same.

I've chosen port 4567 since that is the default port used by the example Sinatra app.

```
  config.vm.provision :shell, privileged: false, path: "setup.sh"
```

This runs a provisioner, which is typically used to install additional software and perform additional configurations during first-time setup. Read [this page](https://www.vagrantup.com/docs/provisioning/) for a more detailed discussion on provisioners in Vagrant. This provisioner will run a script called `setup.sh` which we'll create in the next section. By setting the `privileged` option false the script will run as a non-root user.

```
end
```

This denotes the end of the configuration object.

### Shell Script

Create a new file called `setup.sh` in the same directory as the Vagrantfile.

```
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
```

The application we'll be running is written in Ruby, so we'll install Ruby Version Manager. I've copied the instructions from [https://rvm.io/rvm/install](https://rvm.io/rvm/install).

```
source ~/.rvm/scripts/rvm
```

This initializes RVM properly without needing to restart your terminal session.

```
rvm install 2.6.0
```

This installs version 2.6.0 of the Ruby programming language.

```
gem install bundler
```

This installs [Bundler](https://bundler.io/), a tool for managing dependencies on your Ruby application.

```
cd /vagrant
```

This changes the working directory to `/vagrant`. By default, Vagrant shares the directory the `Vagrantfile` resides in with the virtual machine and mounts it to the `/vagrant` folder on the VM. Any changes that occur to the directory inside Vagrant get reflected outside and vice versa. As a consequence, you can continue to use your favorite IDE and Git client instead of having to code through the terminal.

```
git clone https://github.com/dandelarosa/sinatra-helloworld.git
```

This downloads the source code for the example application from GitHub.

```
cd sinatra-helloworld
```

This changes the working directory to the application's folder.

```
bundle install
```

This installs the dependencies needed to run the example application.

```
if ! grep -q "cd /vagrant/sinatra-helloworld" ~/.bashrc ; then 
  echo "cd /vagrant/sinatra-helloworld" >> ~/.bashrc 
fi
```

By default shell sessions start in the `/home/vagrant` directory which is different from `/vagrant`. We're changing the `.bashrc` file to tell Bash to go to the application directory whenever we start a new session.

## Running Commands

Open up your terminal application and move over to the directory where the `Vagrantfile` is located.

```
vagrant up
```

This creates an instance of the VM on VirtualBox and runs the provisioning scripts. This also relaunches an exisitng instance for when you shut down and restart your computer.

```
vagrant ssh
```

This starts a guest session inside your Vagrant instance.

```
bundle exec ruby myapp.rb -o 0.0.0.0
```

This launches the Sinatra application; setting the server IP to 0.0.0.0 instead of localhost makes the app accessible from both the host and guest machines.

If you browse [http://0.0.0.0:4567/](http://0.0.0.0:4567/) on your favorite browser and see a webpage, the app works! However, there are still a few more items to go through. Press Ctrl-C and enter the `exit` command to quit the session and return to the host machine.

```
vagrant halt
```

This powers down the Vagrant instance and keeps it for future usage. In fact, you can call `vagrant up` immediately afterwards and it'll restart the virtual machine. Notice that the VM starts exactly where it left off – there's no need to wait for everything to install again. Typically my Mac is smart enough to power off any Vagrant instances when I shut down, but it's still a handy command to remember.

```
vagrant destroy
```

There is a possiblity that something goes horribly wrong inside your VM and you'll need to start anew. `vagrant destroy` will terminate the instance, and the next time `vagrant up` is called it will spin up a completely new VM. Keep in mind that `vagrant destroy` will not delete the contents of the folder your `Vagrantfile` is in, but everything else will be eliminated.

## Wrapping Up

The final scripts can be seen below:
<script src="https://gist.github.com/dandelarosa/afa04bfa4ba84fbe295b13aecc3e79d5.js"></script>
