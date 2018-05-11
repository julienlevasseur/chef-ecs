#
# Cookbook:: chef-ecs
# Recipe:: sysctl
#
# Copyright:: 2018, Julien Levasseur, All Rights Reserved.

sysctl_param "net.ipv4.conf.all.route_localnet" do
  value 1
end