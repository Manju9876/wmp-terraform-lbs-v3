#!/bin/bash

sudo python3.11 -m pip install ansible hvac
ansible-pull -i localhost, -U https://github.com/Manju9876/wmp-ansible wmp.yaml -e component_name=${COMPONENT} -e env=${ENV}