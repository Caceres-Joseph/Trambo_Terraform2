#!/bin/bash

sudo apt-get update
sudo apt-get install wget unzip -y
export VER="0.12.9"
wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
unzip terraform_${VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/