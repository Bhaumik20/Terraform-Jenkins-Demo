#!/bin/bash
cd aws/modules/$MODULE/
$TERRAFORM_HOME/terraform apply -auto-approve -var-file="../../config/$ENV/tfvars/$MODULE.tfvars"
