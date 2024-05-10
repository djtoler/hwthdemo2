# GitHub

#### _Start off by looking at our code on our GitHub repo._ 

##### https://github.com/djtoler/hwthdemo2

# Docker on AWS 
##### (Containerization)

### INSTALL DOCKER

> ##### CURL -O https://github.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/blob/main/auto-docker_install.sh

### CREATE DOCKER FILE _(Build the recipe list for making a TV dinner)_

> ##### CURL -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/Dockerfile

> ##### FROM nginx:alpine

> ##### RUN git clone https://github.com/djtoler/hwthdemo2.git /tmp/hwthdemo && \ mv /tmp/hwthdemo/hwth.html ./index.html && \rm -rf /tmp/hwthdemo/.git

> ##### EXPOSE 80

### BUILD DOCKER IMAGE _(Cook the TV dinner from the recipe, package it and store it)_

> ##### docker build -t djtoler/dk8000 .
> ##### docker push djtoler/dk8000:latest

### RUN DOCKER CONTAINER FROM IMAGE _(Microwave the TV dinner, unpack it and serve it)_

> ##### docker run -d -p 80:80 djtoler/dk8000:latest


# Docker on Digital Ocean 
##### (Saving Money by cotainerizing)

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

#### _CREATE NEW VIRTUAL MACHNIE IN DIGITAL OCEAN_
> ##### doctl compute droplet create newdesign --size s-1vcpu-1gb --image docker-20-04 --region nyc1 --ssh-keys 41966894 --tag-names hwthdemo --wait

#### AUTOMATE DOCKER BUILD AND RUN
> ##### curl -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/auto-container.sh
> ##### chmod +x auto-container.sh
> ##### ./auto-container.sh

#### Add new virtual machine to the load balancer

# Jenkins 
##### (Growth through automation)

> ##### Push new code
> ##### http://18.215.144.104:8080/job/hwthdemo/job/main/

# Kubernetes
##### (Scaling with container orchestration)
> ##### curl -O https://raw.githubusercontent.com/djtoler/Personal-Library-of-Automated-Installation-Scripts-for-UbuntuOS/main/demo.yaml

> ##### _name: demo-app_
> ##### _replicas: 2_
> ##### _image: djtoler/hwthdemoapp2:latest_

> ##### kubectl apply -f demo.yaml

> #####   jmeter -n -t /Users/dwaynetoler/digiital-ocean-demo/jm/t2.xml -l /Users/dwaynetoler/digiital-ocean-demo/jm/results.jtl

> ##### jmeter -n -t /Users/dwaynetoler/digiital-ocean-demo/jm/t.xml -l /Users/dwaynetoler/digiital-ocean-demo/jm/results2.jtl
