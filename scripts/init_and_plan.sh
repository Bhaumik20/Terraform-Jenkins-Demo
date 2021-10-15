#!/bin/bash
cd aws/modules/$MODULE/
$TERRAFORM_HOME/terraform init -backend-config="../../config/$ENV/backend/$MODULE.conf"
$TERRAFORM_HOME/terraform plan -var-file="../../config/$ENV/tfvars/$MODULE.tfvars"
