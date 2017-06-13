#!/bin/bash

vpcid="vpc-9db414e4"

#asg1=`sudo aws autoscaling describe-auto-scaling-groups --region us-east-1|grep AutoScalingGroupName|awk '{print $2}'|cut -c 2-19`
asg1=`sudo aws autoscaling describe-launch-configurations --region us-east-1|grep LaunchConfigurationName|awk '{print $2}'|cut -c 2-19`
fis="fis"
sec="sec"
sub1="aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpcid"|grep "SubnetId"|awk '{print $2}'|cut -c 2-16|tail -1"
sub2="aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpcid"|grep "SubnetId"|awk '{print $2}'|cut -c 2-16|head -1"

echo "ASG 2 $asg1"
lcfg1="machine-factory-v1"
lcfg2="machine-factory-v2"

if [ "$asg1" == "$lcfg1" ]
then
  rm -rf $fis/terraform.*;cp userdata.sh $fis;cd $fis;sudo terraform plan;sudo terraform apply
sleep 180
aws autoscaling update-auto-scaling-group --auto-scaling-group-name machine-factory-v1 --launch-configuration-name $lcfg2  --min-size 1 --max-size 1 --vpc-zone-identifier $sub1
aws autoscaling update-auto-scaling-group --auto-scaling-group-name machine-factory-v1 --launch-configuration-name $lcfg2  --min-size 1 --max-size 1 --vpc-zone-identifier $sub2
aws autoscaling delete-launch-configuration --launch-configuration-name $lcfg1

else
  rm -rf $fis/terraform.*;cp userdata.sh $sec;cd $sec;sudo terraform plan;sudo terraform apply
 sleep 180
aws autoscaling update-auto-scaling-group --auto-scaling-group-name machine-factory-v1 --launch-configuration-name $lcfg1  --min-size 1 --max-size 1 --vpc-zone-identifier $sub1
aws autoscaling update-auto-scaling-group --auto-scaling-group-name machine-factory-v1 --launch-configuration-name $lcfg1  --min-size 1 --max-size 1 --vpc-zone-identifier $sub2
aws autoscaling delete-launch-configuration --launch-configuration-name $lcfg2

fi
