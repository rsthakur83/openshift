#!/bin/bash


asg1=`sudo aws autoscaling describe-auto-scaling-groups --region us-east-1|grep AutoScalingGroupName|awk '{print $2}'|cut -c 2-19`
fis="fis"
sec="sec"
sub1="subnet-de55faf2"
sub2="subnet-39335671"

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
