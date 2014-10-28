#!/bin/bash
REGION=eu-west-1
APP_NAME=demo-application
ENV_NAME=$1
STK_NAME="64bit Amazon Linux 2014.03 v1.0.9 running PHP 5.5"
TIER="Version=1.0,Type=Standard,Name=WebServer"
VERSION=$2
ITYPE="Namespace=aws:autoscaling:launchconfiguration,OptionName=InstanceType,Value=t1.micro"
SCALE="Namespace=aws:elasticbeanstalk:environment,OptionName=EnvironmentType,Value=SingleInstance"
KEYPAIR="Namespace=aws:autoscaling:launchconfiguration,OptionName=EC2KeyName,Value=brokcloud"
SG="Namespace=aws:autoscaling:launchconfiguration,OptionName=SecurityGroups,Value=sg-6fe24e0a"
VPC="Namespace=aws:ec2:vpc,OptionName=VPCId,Value=vpc-2ed52b4b"
NET="Namespace=aws:ec2:vpc,OptionName=Subnets,Value=subnet-8138d9d8"
IAM="Namespace=aws:autoscaling:launchconfiguration,OptionName=IamInstanceProfile,Value=aws-elasticbeanstalk-ec2-role"


aws elasticbeanstalk create-environment --region=$REGION --application-name=$APP_NAME --environment-name=$ENV_NAME --solution-stack-name="$STK_NAME" --tier="$TIER" --version-label="$VERSION" --option-settings $ITYPE $SCALE $KEYPAIR $VPC $NET $SG $IAM
