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

# Not Secure At All, But Convenient
firewall_rule "es" do
    protocol :tcp
    ports [9200, 9300]
    action :allow
    notifies :enable, 'firewall[ufw]'
end
