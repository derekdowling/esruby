#!/usr/bin/env bash

# This script is used to handle provisioning new nodes in the Elasticsearch Cluster
# It performs some initial bootstrapping of tool installation and then uses the
# Chef-Solo provisioner to complete the installation.
#
# Also requires a slight change to the OPTS path with the own path to your PEM file

export PROXY="199.116.235.83"
export CHEF="/var/chef/cookbooks/esruby"
export OPTS="-A -t -o User=ubuntu -i /Users/derek/.ssh/391project.pem"
export SUB_OPTS="-A -t -o User=ubuntu"

# Nodes To Run Against
nodes=( 10.1.0.247 10.1.0.249 10.1.1.41 10.1.1.44 )

if [ -z "${1}" ]; then
	cat <<-HELP
		options:
			-l list available nodes
			-s <node_ip> provision a specific node
			-a provision all nodes
		HELP
fi

if [ "${1}" = "-l" ]; then
	for host in "${nodes[@]}"
	do
		echo ${host}
	done
	exit 0
fi

# See if we are proxying through our public IP, checks if $SUB_HOST is set
if [ "${1}" = "-s" ]; then
	nodes=( ${2} )
fi
# See if we are proxying through our public IP, checks if $SUB_HOST is set
if [ "${1}" = "-a" ] || [ "${1}" = "-s" ]; then
	if [ "${1}" = "-s" ]; then
		nodes=( ${2} )
	fi
	for host in "${nodes[@]}"
	do
		echo "starting installation on ${host}"
		ssh $OPTS $PROXY ssh $SUB_OPTS $host <<-END
			sudo apt-get update
			sudo apt-get install build-essential curl git vim -y
			curl -# -L http://www.opscode.com/chef/install.sh | sudo bash -s --
			curl -# -L -k -o /tmp/esruby.tar.gz https://github.com/derekdowling/esruby/archive/master.tar.gz
			sudo mkdir -p /etc/chef/; sudo mkdir -p $CHEF
			sudo tar --strip 1 -C $CHEF -xf /tmp/esruby.tar.gz
			sudo apt-get install bison zlib1g-dev libopenssl-ruby1.9.1 libssl-dev libyaml-0-2 libxslt-dev libxml2-dev libreadline-gplv2-dev libncurses5-dev file ruby1.9.3 git --yes --fix-missing
			sudo /opt/chef/embedded/bin/gem install berkshelf --no-rdoc --no-ri
			sudo /opt/chef/embedded/bin/berks vendor /var/chef/cookbooks -b $CHEF/Berksfile
			sudo chef-solo -N 391Cluster -j $CHEF/cluster.json -c $CHEF/solo.rb
			END
	done
	echo "Installation Complete"
fi
