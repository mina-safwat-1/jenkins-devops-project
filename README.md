# jenkins-devops-project

## Create infrastructure pipeline to run terraform with jenkins

###  Create ansible script to configure application ec2(private) 
#### 1- configure ansible to run over private ips through bastion (~/.ssh/config)
#### 2- write ansible script to configure ec2 to run  as jenkins slaves
#### 3- configure slave in jenkins dashboard (with private ip)
#### 4- create pipeline to deploy nodejs_example fro branch (rds_redis)
#### 5- add application load balancer to your terraform code to expose your nodejs app on port 80 on the load balancer
#### 6- test your application by calling loadbalancer_url/db and /redis
#### 7- create documentation illustrating your steps with screenshots
