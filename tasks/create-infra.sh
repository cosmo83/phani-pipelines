#!/bin/bash
ROOT=$PWD
set -eu
ls -al terraform-state/

function main(){

  terraform init "$ROOT/phani-pipelines/terraform"

  terraform plan \
   -var "os_tenant_name=${OS_PROJECT_NAME}" \
   -var "os_username=${OS_USERNAME}" \
   -var "os_password=${OS_PASSWORD}" \
   -var "os_auth_url=${OS_AUTH_URL}" \
   -var "os_region=${OS_REGION_NAME}" \
   -var "os_domain_name=${OS_USER_DOMAIN_NAME}" \
   -var "infra_dns=${INFRA_DNS}" \
   -var "phani_subnet_cidr=${PHANI_SUBNET_CIDR}" \
   -out "terraform.tfplan" \
   -state "terraform-state/*.tfstate" \
   "$ROOT/phani-pipelines/terraform"


  terraform apply \
    -state-out "$ROOT/create-infrastructure-output/terraform.tfstate" \
    -parallelism=5 \
    terraform.tfplan

}
main
