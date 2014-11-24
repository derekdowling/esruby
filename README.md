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

# Bulk Load Optimizations:

Index settings:
index.refresh_interval = -1
index.number_of_replicas: 0

cluster settings:
indices.store.throttle_type = none
