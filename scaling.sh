#!/bin/bash


asg1=`aws autoscaling describe-auto-scaling-groups|grep AutoScalingGroupName|awk '{print $2}'|cut -c 2-19`
echo "ASG 2 $asg1"
lcfg1="machine-factory-v1"
lcfg2="machine-factory-v2"

if [ "$asg1" == "$lcfg1" ]
then
  echo "Attach Green & Detach Blue Env"
  aws autoscaling attach-load-balancers --auto-scaling-group-name $lcfg2 --load-balancer-names my-lb;sleep 60; aws autoscaling detach-load-balancers --auto-scaling-group-name $lcfg1 --load-balancer-names my-lb;echo "destroy";aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $lcfg1
else
  echo "Attach Green & Detach Blue Env"
  aws autoscaling attach-load-balancers --auto-scaling-group-name $lcfg1 --load-balancer-names my-lb;sleep 60; aws autoscaling detach-load-balancers --auto-scaling-group-name $lcfg2 --load-balancer-names my-lb;echo "destroy";aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $lcfg2

fi
