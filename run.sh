#!/bin/sh

terraform apply -auto-approve -input=false -var-file="$1".tfvars -target="null_resource.mac-"$1""