#!/bin/bash


asg1=`sudo aws autoscaling describe-auto-scaling-groups --region us-east-1|grep AutoScalingGroupName|awk '{print $2}'|cut -c 2-19`
echo "ASG 2 $asg1"
lcfg1="machine-factory-v1"
lcfg2="machine-factory-v2"

if [ "$asg1" == "$lcfg1" ]
then
  echo "Attach Green & Detach Blue Env"
 sudo aws autoscaling attach-load-balancers --auto-scaling-group-name  $lcfg2 --load-balancer-names web-elb --region us-east-1;sudo sleep 60;sudo aws autoscaling detach-load-balancers --auto-scaling-group-name $lcfg1 --load-balancer-names web-elb --region us-east-1;sudo echo "destroy";sudo aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $lcfg1 --region us-east-1
else
  echo "Attach Green & Detach Blue Env"
 sudo aws autoscaling attach-load-balancers --auto-scaling-group-name $lcfg1 --load-balancer-names web-elb --region us-east-1;sudo sleep 60;sudo aws autoscaling detach-load-balancers --auto-scaling-group-name $lcfg2 --load-balancer-names web-elb --region us-east-1;sudo echo "destroy";sudo aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $lcfg2 --region us-east-1

fi
