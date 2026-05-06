#!/bin/bash

sudo labauto ansible
ansible-pull -i localhost, -U https://github.com/Manju9876/wmp-ansible wmp.yaml -e env=${ENV} -e component_name=${COMPONENT}