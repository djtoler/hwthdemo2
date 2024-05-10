##### _[Live Coding Demo Notes](https://github.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/blob/main/templates/lcnotes.txt)_

# GitHub

#### _Start off by looking at our code on our GitHub repo._ 

##### https://github.com/djtoler/hwthdemo2

# Docker on AWS 
##### (Containerization)
##### [Show AWS pricing]

### INSTALL DOCKER

> ##### curl -O https://github.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/blob/main/auto-docker_install.sh

### CREATE DOCKER FILE _(Build the recipe list for making a TV dinner)_

> ##### curl -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/Dockerfile

> ##### FROM nginx:alpine

> ##### RUN git clone https://github.com/djtoler/hwthdemo2.git /tmp/hwthdemo && \ mv /tmp/hwthdemo/hwth.html ./index.html && \rm -rf /tmp/hwthdemo/.git

> ##### EXPOSE 80

### BUILD DOCKER IMAGE _(Cook the TV dinner from the recipe, package it and store it)_

> ##### docker build -t djtoler/dk8000 .
> ##### docker push djtoler/dk8000:latest

### RUN DOCKER CONTAINER FROM IMAGE _(Microwave the TV dinner, unpack it and serve it)_

> ##### docker run -d -p 80:80 djtoler/dk8000:latest


# Docker on Digital Ocean 
##### (Saving Money by containerizing)
##### [Show AWS pricing vs Digital Ocean pricing]

#### _CREATE KEY_
> ##### ssh-keygen -t rsa -b 4096 -C "dk2" -f ~/.ssh/dk2
> #### cat ~/.ssh/dk2

#### _ADD KEY TO DIGITAL OCEAN_
> ##### doctl compute ssh-key import "dk2" --public-key-file ~/.ssh/dk2.pub
> ##### doctl compute ssh-key list

#### _CREATE DIGITAL OCEAN VIRTIAL MACHINE_
> ##### doctl compute droplet create dk --size s-1vcpu-1gb --image docker-20-04 --region nyc1 --ssh-keys 41914405 --wait

> ##### _Attach a firewall to make sure port 80 is open_& connect to our virtual machine and make sure Docker is installed_

#### _LOGIN TO DOCKER_
> ##### docker login

#### _PULL DOCKER IMAGE FROM DOCKERHUB_
> ##### docker images
> ##### docker pull djtoler/dk8000:latest
> ##### docker images

#### _RUN DOCKER CONTAINER ON DIGITAL OCEAN_
> ##### docker run -d -p 80:80 djtoler/dk8000:latest

# Load Balancing
##### (Growth through load balancers plus automation)
##### [Create a new VM, run container and load balancer to show split testing 2 different design versions]

#### _CREATE NEW VIRTUAL MACHNIE IN DIGITAL OCEAN_
> ##### doctl compute droplet create newdesign --size s-1vcpu-1gb --image docker-20-04 --region nyc1 --ssh-keys 41966894 --tag-names hwthdemo --wait

#### AUTOMATE DOCKER BUILD AND RUN
> ##### curl -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/auto-container.sh
> ##### chmod +x auto-container.sh
> ##### ./auto-container.sh

#### Add new virtual machine to the load balancer

# Jenkins 
##### (Growth through code deployment automation)
##### [Show a Jenkins building stoping all red color backgrounds because a check in the testing stage]

> ##### curl -O https://github.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/blob/main/auto-jenkins.sh
> ##### [Setting up Jenkins pipeline](https://github.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/blob/main/manual_jenkins_multi_branch.txt)
> ##### Push new code
> ##### http://18.215.144.104:8080/job/hwthdemo/job/main/

# Kubernetes
##### (Scaling with container orchestration)
##### [Showing auto-scaling through manual vm termination and load testing with JMeter]
> ##### curl -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/demo.yaml

> ##### _name: demo-app_
> ##### _replicas: 2_
> ##### _image: djtoler/hwthdemoapp2:latest_

> ##### kubectl apply -f demo.yaml

>#### _JMeter_ 

> #####   jmeter -n -t /Users/dwaynetoler/digiital-ocean-demo/jm/t2.xml -l /Users/dwaynetoler/digiital-ocean-demo/jm/results.jtl

> ##### jmeter -n -t /Users/dwaynetoler/digiital-ocean-demo/jm/t.xml -l /Users/dwaynetoler/digiital-ocean-demo/jm/results2.jtl

---

### _Full Kubernetes Setup_

#### Build infrastructure for Kubernetes with Terraform
##### Deploy 2 public subnets, 2 private subnets, nat gateway and igw in  vpc
##### Make sure theres a public ip is enabled for the public subnets

```
provider "aws" {
  region = "us-east-1"  
    access_key = ""
  secret_key = ""
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public Subnet 1"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public Subnet 2"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet1.id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_rta1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rta2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "private_rta1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_rta2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table.id
}
```

#### Install and configure Kubernets/EKS CLI
##### curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
##### chmod +x ./kubectl
##### sudo mv ./kubectl /usr/local/bin/kubectl
##### curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
##### sudo mv /tmp/eksctl /usr/local/bin

#### Check if its installed
##### eksctl version 

#### Create & check cluster
##### eksctl create cluster hdemo1  --vpc-public-subnets=subnet-0bdd9cfe1d31dd007,subnet-0b2cf4f54836a40a0 --vpc-private-subnets=subnet-02fc79c488a8d2d4f,subnet-0cd170827ac07c419 --without-nodegroup
##### eksctl create nodegroup --cluster hdemo1 --name demofrontend --node-type t2.medium --nodes 2 --nodes-min 1 --nodes-max 10

#### Configure IAM for EKS Loadbalancer if it doesnt already exist
##### wget https://raw.githubusercontent.com/kura-labs-org/Template/main/iam_policy.json
##### aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json

##### eksctl create iamserviceaccount \
  ##### --cluster=hdemo1 \
  ##### --namespace=kube-system \
  ##### --name=aws-load-balancer-controller \
  ##### --attach-policy-arn=arn:aws:iam::851725223937:policy/AWSLoadBalancerControllerIAMPolicy \
  ##### --approve
  
##### kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds"

##### wget https://github.com/aws/eks-charts/releases/download/aws-load-balancer-controller-v2.4.7/v2_4_7_full.yaml

##### kubectl apply -f v2_4_7_full.yaml

##### kubectl apply -f ingressClass.yaml
#### kubectl apply -f ingress.yaml
##### Apply service & deployment files

