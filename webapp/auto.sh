#!/bin/bash

sg1=`aws ec2 describe-security-groups --filters Name=tag:Name,Values=asg1 --query 'SecurityGroups[].GroupId' --output text`
sg2=`aws ec2 describe-security-groups --filters Name=tag:Name,Values=asg2 --query 'SecurityGroups[].GroupId' --output text`
vpcid=`aws ec2 describe-vpcs --filters Name=tag:Name,Values=myappvpc --query 'Vpcs[].[VpcId]' --output text`

sed -i -e "s/sg1/$sg1/g" fis/sg.tf
sed -i -e "s/sg2/$sg2/g" fis/sg.tf

sed -i -e "s/sg1/$sg1/g" sec/sg.tf
sed -i -e "s/sg2/$sg2/g" sec/sg.tf

sed -i -e "s/myappvpc/$vpcid/g" scaling.sh
