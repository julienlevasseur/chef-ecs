#
# Cookbook:: chef-ecs
# Recipe:: repos
#
# Copyright:: 2018, Julien Levasseur, All Rights Reserved.

apt_update 'update' do
  action :update
end

platforms = [
  'debian',
  'ubuntu'
]

platforms.each do |platform|
  execute 'add_docker_repo_key' do
    command "curl -fsSL https://download.docker.com/linux/#{platform}/gpg | apt-key add -"
    not_if "apt-key list|grep Docker"
    only_if { node['platform'] == platform }
  end

  execute 'add_docker_repo' do
    command "add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/#{platform} $(lsb_release -cs) stable\""
    not_if "grep docker /etc/apt/sources.list"
    only_if { node['platform'] == platform }
  end
end
