Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.provision :shell, privileged: false, path: "setup.sh"
end
