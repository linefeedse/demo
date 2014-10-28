#!/bin/bash
REGION=eu-west-1
APP_NAME=demo-application
ENV_ID=$1

if [ -z "$ENV_ID" ] ; then
  echo "Running environments:"
  aws elasticbeanstalk describe-environments --application-name=$APP_NAME --region=$REGION | egrep 'EnvironmentName|EnvironmentId'
  exit 1
fi

aws elasticbeanstalk terminate-environment --region=$REGION --environment-id=$ENV_ID
