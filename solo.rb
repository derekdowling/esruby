# Chef Solo Config File
# This is what powers our actual node cluster installations

log_level          :info
log_location       STDOUT
file_cache_path    "/var/chef/cookbooks"
role_path          "/var/chef/cookbooks/esruby/roles"
cookbook_path      "/var/chef/cookbooks"
