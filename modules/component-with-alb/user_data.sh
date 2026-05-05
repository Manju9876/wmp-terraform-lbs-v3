#!/bin/bash

sudo labauto ansible
ansible-pull -i localhost, -U https://github.com/raghudevopsb88/wmp-ansible-v4.git main.yml -e env=${ENV} -e COMPONENT=${COMPONENT}