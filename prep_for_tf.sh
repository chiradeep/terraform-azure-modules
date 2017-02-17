#!/bin/bash

# set -x
APP_NAME=Terraform1
APP_URL=http://terraformer.io
APP_PASSWORD=T5rrafhre4rm.

#find the subscription id. Warning: assumes exactly one item in the list
sub_id=$(azure account list --json | jq -r ".[] | .id")

# tenant id. assumes exactly one subscription
tenant_id=$(azure account list --json | jq -r ".[] | .tenantId")

# create an app called Terraform
azure ad app create -n $APP_NAME  -m $APP_URL -i $APP_URL -p $APP_PASSWORD

echo "Sleeping...."
sleep 5

# find the app id
app_id=$(azure ad app list --json | jq -r ".[] | select(.displayName | contains(\"$APP_NAME\"))| .appId")

# create a service principal
azure ad sp create -a $app_id

echo "Sleeping...."
sleep 15

# give it Owner permissions (alternatives: "Contributor")
azure role assignment create --spn $APP_URL -o "Owner" -c /subscriptions/$sub_id

echo "export ARM_SUBSCRIPTION_ID=$sub_id" >> .env
echo "export ARM_CLIENT_ID=$app_id" >> .env
echo "export ARM_CLIENT_SECRET=$APP_PASSWORD" >> .env
echo "export ARM_TENANT_ID=$tenant_id" >> .env
