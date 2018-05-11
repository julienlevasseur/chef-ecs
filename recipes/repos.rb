#
# Cookbook:: chef-ecs
# Recipe:: repos
#
# Copyright:: 2018, Julien Levasseur, All Rights Reserved.

apt_update 'update' do
  action :update
end

execute 'apache_configtest' do
  command 'curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -'
  only_if { node['platform'] == 'debian' }
end

execute 'apache_configtest' do
  command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
  only_if { node['platform'] == 'ubuntu' }
end

apt_repository 'docker.io' do
  uri 'https://download.docker.com/linux/debian/'
  components ['main']
  only_if { node['platform'] == 'debian' }
end

apt_repository 'docker.io' do
  uri 'https://download.docker.com/linux/ubuntu/'
  only_if { node['platform'] == 'ubuntu' }
end
