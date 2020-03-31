#!/bin/bash

# This script is used by Keepalived as a takeover script for Asterisk failover in GCP

gcloud compute routes delete {{ sip.failover.route_name }} --quiet
gcloud compute routes create {{ sip.failover.route_name }} \
    --destination-range {{ sip.failover.vip }}/{{ sip.failover.netmask }} --network {{ sip.failover.network }} \
    --priority 500 --next-hop-address {{ sip.failover.local_ip }} --quiet
