#!/bin/bash


asg1=`sudo aws autoscaling describe-auto-scaling-groups --region us-east-1|grep AutoScalingGroupName|awk '{print $2}'|cut -c 2-19`
fis="fis"
sec="sec"

echo "ASG 2 $asg1"
lcfg1="machine-factory-v1"
lcfg2="machine-factory-v2"

if [ "$asg1" == "$lcfg1" ]
then
  rm -rf $fis/terraform.*;cp userdata.sh $fis;cd $fis;sudo terraform plan;sudo terraform apply
  sleep 180
  echo "Attach Green & Detach Blue Env"
 sudo aws autoscaling attach-load-balancers --auto-scaling-group-name  $lcfg2 --load-balancer-names web-elb --region us-east-1
  sleep 180
 sudo aws autoscaling detach-load-balancers --auto-scaling-group-name $lcfg1 --load-balancer-names web-elb --region us-east-1
 aws autoscaling delete-auto-scaling-group --auto-scaling-group-name  $lcfg1 --force-delete
sudo aws autoscaling delete-launch-configuration --launch-configuration-name  $lcfg1


else
  rm -rf $fis/terraform.*;cp userdata.sh $sec;cd $sec;sudo terraform plan;sudo terraform apply
  sleep 180
  echo "Attach Green & Detach Blue Env"
 sudo aws autoscaling attach-load-balancers --auto-scaling-group-name $lcfg1 --load-balancer-names web-elb --region us-east-1
  sleep 180
 sudo aws autoscaling detach-load-balancers --auto-scaling-group-name $lcfg2 --load-balancer-names web-elb --region us-east-1
 sudo aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $lcfg2 --region us-east-1 --force-delete
 sudo aws autoscaling delete-launch-configuration --launch-configuration-name $lcfg2
fi
