default['ecs']['ECS_DATADIR']                           = "/data"
default['ecs']['ECS_ENABLE_TASK_IAM_ROLE']              = true
default['ecs']['ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST'] = true
default['ecs']['ECS_LOGFILE']                           = "/log/ecs-agent.log"
default['ecs']['ECS_AVAILABLE_LOGGING_DRIVERS']         = [
                                                            "json-file",
                                                            "awslogs"
                                                          ]
default['ecs']['ECS_LOGLEVEL']                          = "info"
default['ecs']['ECS_CLUSTER']                           = "/data"
