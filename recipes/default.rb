#
# Cookbook Name:: ES-Ruby
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.
#

# FUTURE ELASTICSEARCH SERVER
# Until we start provisioning different types of production servers, this will be
# sufficient. Otherwise, these cookbooks are better suited to specific run lists
# that are determined by the role played by node.
include_recipe "java"
include_recipe "elasticsearch::default"
include_recipe "elasticsearch::search_discovery"

# BASIC TOOLS
include_recipe "ufw"
include_recipe "firewall"

firewall_rule "es" do
    protocol :tcp
    ports [9200, 9300]
    action :allow
    notifies :enable, 'firewall[ufw]'
end
