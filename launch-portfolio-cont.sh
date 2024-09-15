#!/bin/bash
sudo apt-get update
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
touch "userdata-scriptlogs_$timestamp.txt"
echo "Instance name - $(hostname -f)" >> userdata-scriptlogs_$timestamp.txt
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

echo "Add Docker's official GPG key:" >> userdata-scriptlogs_$timestamp.txt
sudo apt-get update -y
echo "Y" | sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Add the repository to Apt sources:" >> userdata-scriptlogs_$timestamp.txt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Install docker packages" >> userdata-scriptlogs_$timestamp.txt
echo "Y" | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Install my portfolio" >> userdata-scriptlogs_$timestamp.txt
sudo docker pull jbeaver1/my-portfolio:1.0
sudo docker run -d -p 8080:80 jbeaver1/my-portfolio:1.0