apt_repository "ruby2.1" do
    uri "http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu"
    distribution 'precise'
    components ['main']
    keyserver "keyserver.ubuntu.com"
    key "C3173AA6"
    action :add
end

package "rubygems" do
      action :upgrade
end
