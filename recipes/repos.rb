#
# Cookbook:: chef-ecs
# Recipe:: repos
#
# Copyright:: 2018, Julien Levasseur, All Rights Reserved.

apt_update 'update' do
  action :update
end

execute 'add_docker_repo_key' do
  command 'curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -'
  only_if { node['platform'] == 'debian' }
end

execute 'add_docker_repo_key' do
  command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
  only_if { node['platform'] == 'ubuntu' }
end

execute 'add_docker_repo' do
  command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"'
  only_if { node['platform'] == 'debian' }
end

execute 'add_docker_repo' do
  command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
  only_if { node['platform'] == 'ubuntu' }
end
