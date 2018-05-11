#
# Cookbook:: chef-ecs
# Recipe:: repos
#
# Copyright:: 2018, Julien Levasseur, All Rights Reserved.

apt_update 'update' do
  action :update
end

apt_repository 'docker.io' do
  uri 'https://download.docker.com/linux/debian/'
  components ['main']
  key 'https://download.docker.com/linux/debian/gpg'
  only_if { node['platform'] == 'debian' }
end

apt_repository 'docker.io' do
  uri 'https://download.docker.com/linux/ubuntu/'
  key 'https://download.docker.com/linux/ubuntu/gpg'
  only_if { node['platform'] == 'ubuntu' }
end

apt_repository 'docker.io' do
  uri 'https://download.docker.com/linux/centos/'
  key 'https://download.docker.com/linux/centos/gpg'
  only_if { node['platform'] == 'centos' }
end
