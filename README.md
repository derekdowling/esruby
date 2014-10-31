To make this work:

# Logging In To The VM
kitchen login

# Installation
bundle install
berks install
kitchen converge

# If It Says Something About The Kitchen Not Being Started
cd .kitchen/kitchen-vagrant/default-ubuntu-1404
from there run, "vagrant up"
cd back to the root director
run "kitchen converge"
