#!/bin/bash
set -euxo pipefail

sudo dnf install -y python3-pip
sudo pip3 install ansible hvac
#sudo python3.11 -m pip install ansible hvac
ansible-pull -i localhost, \
  -U https://github.com/Manju9876/wmp-ansible \
  wmp.yaml \
  -e env=${ENV} \
  -e component_name=${COMPONENT}
