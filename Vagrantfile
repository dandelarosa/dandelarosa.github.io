Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.provision :shell, privileged: false, inline: <<-SHELL
    # Install RVM and Ruby
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm install 2.6.0
    rvm use 2.6.0
    gem install bundler

    # Install Ruby dependencies
    cd /vagrant
    bundle install

    # Make /vagrant the default directory
    if ! grep -q "cd /vagrant" ~/.bashrc ; then 
      echo "cd /vagrant" >> ~/.bashrc 
    fi 
  SHELL
end
