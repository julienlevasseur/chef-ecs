#
# Cookbook:: ecs
# Recipe:: default
#
# Copyright:: 2018, Julien Levasseur, All Rights Reserved.

package 'apt-transport-https'
package 'ca-certificates'
package 'curl'
package 'software-properties-common'

include_recipe 'ecs::repos'

package 'docker-ce'

include_recipe 'ecs::sysctl'

directories = [
  "/etc/ecs",
  "/var/log/ecs",
  "/var/lib/ecs/",
  "/var/lib/ecs/data"
]

directories.each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

template '/etc/ecs/ecs.config' do
  source 'ecs.config.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    ECS_DATADIR:                           node['ecs']['ECS_DATADIR'],
    ECS_ENABLE_TASK_IAM_ROLE:              node['ecs']['ECS_ENABLE_TASK_IAM_ROLE'],
    ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST: node['ecs']['ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST'],
    ECS_LOGFILE:                           node['ecs']['ECS_LOGFILE'],
    ECS_AVAILABLE_LOGGING_DRIVERS:         node['ecs']['ECS_AVAILABLE_LOGGING_DRIVERS'],
    ECS_LOGLEVEL:                          node['ecs']['ECS_LOGLEVEL'],
    ECS_CLUSTER:                           node['ecs']['ECS_CLUSTER']
    AWS_DEFAULT_REGION:                    node['ecs']['AWS_DEFAULT_REGION']
    AWS_ACCESS_KEY_ID:                     node['ecs']['AWS_ACCESS_KEY_ID']
    AWS_SECRET_ACCESS_KEY:                 node['ecs']['AWS_SECRET_ACCESS_KEY']
  )
end

execute 'Docker Run' do
  command 'docker run --name ecs-agent --detach=true --restart=on-failure:10 --volume=/var/run:/var/run --volume=/var/log/ecs/:/log --volume=/var/lib/ecs/data:/data --volume=/etc/ecs:/etc/ecs --net=host --env-file=/etc/ecs/ecs.config amazon/amazon-ecs-agent:latest'
  not_if "docker ps|grep ecs-agent"
end
