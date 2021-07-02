# Make /vagrant the default directory
if ! grep -q "cd /vagrant" ~/.bashrc ; then 
  echo "cd /vagrant" >> ~/.bashrc 
fi

# Install RVM and Ruby
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm -y
sudo usermod -a -G rvm $USER
# Use vagrant ssh to call the rest
rvm user gemsets
rvm install 2.6.0
rvm use 2.6.0
gem install bundler

# Install Ruby dependencies
cd /vagrant
bundle install
