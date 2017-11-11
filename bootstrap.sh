#!/bin/sh
cd ansible
ansible-playbook -i ../conf/hosts cloudera-director-server.yaml -vvv
cd ..
echo "Done."
