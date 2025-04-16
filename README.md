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



fork repo

cd terraform

terraform init
terraform apply -var-file vars.tfvars

enter db password
enter db username

# to create jenkins master

docker container run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 jenkins/jenkins:lts

# in master machine
echo "Host bastion
  HostName public_ip_bastion  
  User ubuntu
  IdentityFile ~/.ssh/new.pem

Host jenkins-slave
  HostName private_ip_jenkins_slave
  User ubuntu
  IdentityFile ~/.ssh/new.pem
  ProxyJump bastion
" > ~/.ssh/config 


cd ansible/jenkins_slave
ansible-playbook ansible.yml


# to enable port forwarding between bastion server and localhost (master jenkins)
ssh bastion
sudo bash -c 'echo -e "GatewayPorts yes\nAllowTcpForwarding yes" >> /etc/ssh/sshd_config'
sudo systemctl restart sshd
ssh -i ~/.ssh/new.pem -R 8080:localhost:8080 ubuntu@34.239.0.65  -N



# ssh manual jenkins_slave
ssh jenkins_slave

# change them according to your own jenkins master
curl -sO http://public_ip_bastion:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://public_ip_bastion:8080/ -secret 1c34c898d68c47a3e7ddc106533981c6ef7b839e513b6e4677f92e4289e4d975 -name "jenkins_slave" -webSocket -workDir "/home/ubuntu/jenkins"


# add github repo webhook

http://public_ip_bastion:8080/github-webhook/



# set jenkins credentials
DB_PASSWORD
DB_USERNAME
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
ansible-ssh-key (your own private key) 


# add jenkins pipeline

# push change to github repo