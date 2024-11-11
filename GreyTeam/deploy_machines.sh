#!/bin/bash

#Create Blue1 network and subnet
openstack network create COMP-Blue1
openstack subnet create --network COMP-Blue1 --subnet-range 10.22.1.0/24 COMP-Blue1

#Creates competition router and adds network to interface
openstack router create Router-Charlie-Comp --external-gateway external249
openstack router add subnet Router-Charlie-Comp COMP-Blue1

#SSHJump ID
SSHJUMP=$(openstack network list -f value | grep SSHJumpNet -w | awk '{print $1}')

#Creates network ports to be able to assign IP addresses
openstack port create --network "COMP-Blue1" --fixed-ip subnet="COMP-Blue1",ip-address=10.22.1.21 "AD1-Port"
openstack port create --network "COMP-Blue1" --fixed-ip subnet="COMP-Blue1",ip-address=10.22.1.22 "SMB1-Port"
openstack port create --network "COMP-Blue1" --fixed-ip subnet="COMP-Blue1",ip-address=10.22.1.23 "SQL1-Port"
openstack port create --network "COMP-Blue1" --fixed-ip subnet="COMP-Blue1",ip-address=10.22.1.24 "MAIL1-Port"
openstack port create --network "COMP-Blue1" --fixed-ip subnet="COMP-Blue1",ip-address=10.22.1.25 "APACHE1-Port"

#Creates boxes for Blue1
openstack server create --flavor jumbo --image WinSrv2019-2024.7 --key-name Grey-Team --nic port-id="AD1-Port" --nic net-id=$SSHJUMP --security-group default --wait AD1
openstack server create --flavor jumbo --image Win10-23H2 --key-name Grey-Team --nic port-id="SMB1-Port" --nic net-id=$SSHJUMP --security-group default --wait SMB1
openstack server create --flavor xlarge --image ParrotSecurityOS6.1 --key-name Grey-Team --nic port-id="SQL1-Port" --nic net-id=$SSHJUMP --security-group default --wait SQL1
openstack server create --flavor xlarge --image DebianBookworm12-Desktop --key-name Grey-Team --nic port-id="MAIL1-Port" --nic net-id=$SSHJUMP --security-group default --wait MAIL1
openstack server create --flavor large --image haiku2024x64 --key-name Grey-Team --nic port-id="APACHE1-Port" --nic net-id=$SSHJUMP --security-group default --wait APACHE1

echo "Finished setting up Blue1 boxes"

#Creates network and subnet for Blue2
openstack network create COMP-Blue2
openstack subnet create --network COMP-Blue2 --subnet-range 10.22.2.0/24 COMP-Blue2

#Adds Blue2 network to router
openstack router add subnet Router-Charlie-Comp COMP-Blue2

#Creates network ports for Blue2 to assign IP addresses
openstack port create --network "COMP-Blue2" --fixed-ip subnet="COMP-Blue2",ip-address=10.22.2.21 "AD2-Port"
openstack port create --network "COMP-Blue2" --fixed-ip subnet="COMP-Blue2",ip-address=10.22.2.22 "SMB2-Port"
openstack port create --network "COMP-Blue2" --fixed-ip subnet="COMP-Blue2",ip-address=10.22.2.23 "SQL2-Port"
openstack port create --network "COMP-Blue2" --fixed-ip subnet="COMP-Blue2",ip-address=10.22.2.24 "MAIL2-Port"
openstack port create --network "COMP-Blue2" --fixed-ip subnet="COMP-Blue2",ip-address=10.22.2.25 "APACHE2-Port"

#Creates boxes for Blue2
openstack server create --flavor jumbo --image WinSrv2019-2024.7 --key-name Grey-Team --nic port-id="AD2-Port" --nic net-id=$SSHJUMP --security-group default --wait AD2
openstack server create --flavor jumbo --image Win10-23H2 --key-name Grey-Team --nic port-id="SMB2-Port" --nic net-id=$SSHJUMP --security-group default --wait SMB2
openstack server create --flavor xlarge --image ParrotSecurityOS6.1 --key-name Grey-Team --nic port-id="SQL2-Port" --nic net-id=$SSHJUMP --security-group default --wait SQL2
openstack server create --flavor xlarge --image DebianBookworm12-Desktop --key-name Grey-Team --nic port-id="MAIL2-Port" --nic net-id=$SSHJUMP --security-group default --wait MAIL2
openstack server create --flavor large --image haiku2024x64 --key-name Grey-Team --nic port-id="APACHE2-Port" --nic net-id=$SSHJUMP --security-group default --wait APACHE2

echo "Finished setting up Blue2 boxes"

#Creates Grey network and subnet
openstack network create COMP-Grey
openstack subnet create --network COMP-Grey --subnet-range 10.22.17.0/24 COMP-Grey

#Adds Grey network to router
openstack router add subnet Router-Charlie-Comp COMP-Grey

#Creates network ports for Grey IP to assign IP addresses
openstack port create --network "COMP-Grey" --fixed-ip subnet="COMP-Grey",ip-address=10.22.17.45 "Scoring-Port"
openstack port create --network "COMP-Grey" --fixed-ip subnet="COMP-Grey",ip-address=10.22.17.46 "Ansible-Port"

#Creates Grey boxes
openstack server create --flavor xxlarge --image DebianBookworm12-Desktop --key-name Grey-Team --nic port-id="Scoring-Port" --nic net-id=$SSHJUMP --security-group default --wait Scoring
openstack server create --flavor xxlarge --image DebianBookworm12-Desktop --key-name Grey-Team --nic port-id="Ansible-Port" --nic net-id=$SSHJUMP --security-group default --wait Ansible

echo "Finished setting up all machines"