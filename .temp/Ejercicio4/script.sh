#!/bin/bash

sudo apt-get update
sudo apt-get install wget unzip -y
export TER_VER="0.12.12"
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/