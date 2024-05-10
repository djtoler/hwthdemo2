# GitHub

#### _Start off by looking at our code on our GitHub repo._ 

##### https://github.com/djtoler/hwthdemo2

# Docker on AWS

## INSTALL DOCKER

##### CURL -O https://github.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/blob/main/auto-docker_install.sh

## CREATE DOCKER FILE (Build the recipe list for making a TV dinner )

##### CURL -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/Dockerfile

##### FROM nginx:alpine

##### RUN git clone https://github.com/djtoler/hwthdemo2.git /tmp/hwthdemo && \ mv /tmp/hwthdemo/hwth.html ./index.html && \rm -rf /tmp/hwthdemo/.git

##### EXPOSE 80

## BUILD DOCKER IMAGE 
### _(Cook the TV dinner from the recipe, package it and store it)_

##### docker build -t djtoler/dk8000 .
##### docker push djtoler/dk8000:latest

## RUN DOCKER CONTAINER FROM IMAGE 
### _(Microwave the TV dinner, unpack it and serve it)_

##### docker run -d -p 80:80 djtoler/dk8000:latest


## Docker on Digital Ocean

#### CREATE KEY
    ssh-keygen -t rsa -b 4096 -C "dk2" -f ~/.ssh/dk2
    cat ~/.ssh/dk2

#### ADD KEY TO DIGITAL OCEAN
    doctl compute ssh-key import "dk2" --public-key-file ~/.ssh/dk2.pub
    doctl compute ssh-key list

#### CREATE DIGITAL OCEAN VIRTIAL MACHINE
##### doctl compute droplet create dk --size s-1vcpu-1gb --image docker-20-04 --region nyc1 --ssh-keys 41914405 --wait

##### _Attach a firewall to make sure port 80 is open_& connect to our virtual machine and make sure Docker is installed_

#### LOGIN TO DOCKER
##### docker login

#### PULL DOCKER IMAGE FROM DOCKERHUB
##### docker images
##### docker pull djtoler/dk8000:latest
##### docker images

#### RUN DOCKER CONTAINER ON DIGITAL OCEAN
##### docker run -d -p 80:80 djtoler/dk8000:latest



## Load Balancing

#### CREATE NEW VIRTUAL MACHNIE IN DIGITAL OCEAN
##### doctl compute droplet create newdesign --size s-1vcpu-1gb --image docker-20-04 --region nyc1 --ssh-keys 41966894 --tag-names hwthdemo --wait

#### AUTOMATE DOCKER BUILD AND RUN
##### curl -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/auto-container.sh
##### chmod +x auto-container.sh
##### ./auto-container.sh

#### Add new virtual machine to the load balancer

## Jenkins
##### Push new code
##### http://18.215.144.104:8080/job/hwthdemo/job/main/

## Kubernetes

##### curl -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/demo.yaml

##### _name: demo-app_
##### _replicas: 2_
##### _image: djtoler/hwthdemoapp2:latest_

##### kubectl apply -f demo.yaml

#####   jmeter -n -t /Users/dwaynetoler/digiital-ocean-demo/jm/t2.xml -l /Users/dwaynetoler/digiital-ocean-demo/jm/results.jtl

##### jmeter -n -t /Users/dwaynetoler/digiital-ocean-demo/jm/t.xml -l /Users/dwaynetoler/digiital-ocean-demo/jm/results2.jtl
