#!/bin/bash -
config_file=$(cd "$(dirname "./vars.yaml")"; pwd)/$(basename "./vars.yaml")
ansible-playbook -vv -i ansible/inventory ansible/infra.yaml --extra-vars "mode=apply config_file=$config_file" 