#
# Cookbook Name:: esruby
# Recipe:: default
#
# Copyright (c) 2014 Derek Dowling
#

# Basic ES Setup

include_recipe "java"
include_recipe "elasticsearch::default"

# BASIC TOOLS
include_recipe "ufw"
include_recipe "firewall"

# Open ES and Kibana Ports
firewall_rule "es" do
    protocol :tcp
    ports [9200, 9300, 5601]
    action :allow
    notifies :enable, 'firewall[ufw]'
end
