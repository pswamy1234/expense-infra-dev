#!/bin/bash
component=$1
environment=$2
dnf install ansible -y
pip3.9 install botocore boto3
ansible-pull -i localhost, -U https://github.com/pswamy1234/swamy-expense-ansible-role-tf.git main.yaml -e component=$component -e env=$environment
