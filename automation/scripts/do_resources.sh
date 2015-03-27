#!/bin/bash

test -f do_access.sh && source do_access.sh

# List resources in Digital Ocean

if [ -z "$1" ] ; then
  echo "usage: $0 images|regions|account/keys|sizes|droplets"
  exit 1
fi

if [ -z "$DO_API_TOKEN" ] ; then
  echo "need DO_API_TOKEN env var"
  exit 1
fi

curl -X GET -H 'Content-Type: application/json' -H 'Authorization: Bearer '$DO_API_TOKEN "https://api.digitalocean.com/v2/$1" | python -mjson.tool
