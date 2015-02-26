#!/bin/bash
#
# This is an example script that brings up two tiers of Elastic Beanstalk
# and an RDS instance. VPC and Security Groups are hardcoded
#

REGION=eu-west-1
APP_NAME=demo-application
ENV_NAME=$1
BENV_NAME=${ENV_NAME}-be
STK_NAME="64bit Amazon Linux 2014.03 v1.0.9 running PHP 5.5"
TIER1="Version=1.0,Type=Standard,Name=WebServer"
TIER2="Version=1.1,Type=SQS/HTTP,Name=Worker"
VERSION=$2
ITYPE="Namespace=aws:autoscaling:launchconfiguration,OptionName=InstanceType,Value=t1.micro"
SCALE="Namespace=aws:elasticbeanstalk:environment,OptionName=EnvironmentType,Value=SingleInstance"
KEYPAIR="Namespace=aws:autoscaling:launchconfiguration,OptionName=EC2KeyName,Value=brokcloud"
SG="Namespace=aws:autoscaling:launchconfiguration,OptionName=SecurityGroups,Value=sg-6fe24e0a"
VPC="Namespace=aws:ec2:vpc,OptionName=VPCId,Value=vpc-2ed52b4b"
NET="Namespace=aws:ec2:vpc,OptionName=Subnets,Value=subnet-8138d9d8"
IAM="Namespace=aws:autoscaling:launchconfiguration,OptionName=IamInstanceProfile,Value=aws-elasticbeanstalk-ec2-role"
NOPUBIP="Namespace=aws:ec2:vpc,OptionName=AssociatePublicIpAddress,Value=false"
DB_ID=demo-application-prod
DB_SUB=default
DB_OG="default:mysql-5-6"
DB_INST_TYPE="db.t2.micro"

### No tweaks below this line ##########

#RDS_TO_START=$(aws rds describe-db-snapshots --region=$REGION --db-instance-identifier $DB_ID --query DBSnapshots[*].DBSnapshotIdentifier | tail -n 2 | head -n 1 | awk -F "\"" '{print $2}')

#aws rds restore-db-instance-from-db-snapshot --region=$REGION --db-snapshot-identifier $RDS_TO_START --db-instance-class $DB_INST_TYPE --db-subnet-group-name $DB_SUB --no-multi-az --db-instance-identifier $ENV_NAME --no-publicly-accessible --option-group-name $DB_OG

#while aws rds describe-db-instances --region=$REGION --db-instance-id=$ENV_NAME | grep DBInstanceStatus | grep creating ; do sleep 30 ; done

aws elasticbeanstalk create-environment --region=$REGION --application-name=$APP_NAME --environment-name=$ENV_NAME --solution-stack-name="$STK_NAME" --tier="$TIER1" --version-label="$VERSION" --option-settings $ITYPE $SCALE $KEYPAIR $VPC $NET $SG $IAM

aws elasticbeanstalk create-environment --region=$REGION --application-name=$APP_NAME --environment-name=$BENV_NAME --solution-stack-name="$STK_NAME" --tier="$TIER2" --version-label="$VERSION" --option-settings $ITYPE $SCALE $KEYPAIR $VPC $NET $SG $IAM $NOPUBIP

while aws elasticbeanstalk describe-environments --region=eu-west-1 --application-name=$APP_NAME --environment-name=$ENV_NAME | grep Status | grep Launching ; do sleep 30 ; done
while aws elasticbeanstalk describe-environments --region=eu-west-1 --application-name=$APP_NAME --environment-name=$BENV_NAME | grep Status | grep Launching ; do sleep 10 ; done
