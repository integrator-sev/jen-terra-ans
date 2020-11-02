#!/bin/bash

#cd /home/nonroot/terra/test2
terraform output public_ip | awk -F\" '{print $2}'  > aws_ip

i=`egrep -v '^#|^$' aws_ip  |  head -n 1 | tail -n 1`

echo -en "[MAVEN]\n$i ansible_ssh_private_key_file=ssh-key ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no'\n" > hosts

i=`egrep -v '^#|^$' aws_ip  |  head -n 2 | tail -n 1`

echo -en "[TOMCAT]\n$i ansible_ssh_private_key_file=ssh-key ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no'\n" >> hosts