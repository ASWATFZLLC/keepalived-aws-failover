#!/bin/bash

# This script is used by Keepalived as a takeover script for Asterisk failover in AWS
# You need to install and configure AWS CLI and credentials/config files.

# Please see:
# *https://docs.aws.amazon.com/cli/latest/reference/ec2/replace-route.html
# *https://docs.aws.amazon.com/cli/latest/reference/ec2/associate-address.html

INSTANCE_ID="$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
VIP_PRIVATE_IP={{ virtual-ip }}
VIP_PUBLIC_EIP_ID={{ eip-alloc-id }}
ROUTE_TABLE_ID={{ route-table-id }}

# Associate private virtual IP to this instance
aws ec2 replace-route \
--route-table-id ${ROUTE_TABLE_ID} \
--destination-cidr-block ${VIP_PRIVATE_IP} \
--instance-id ${INSTANCE_ID}

# Associate public EIP to this instance
aws ec2 associate-address \
--allow-reassociation \
--instance-id ${INSTANCE_ID} \
--allocation-id ${VIP_PUBLIC_EIP_ID}
