#!/bin/bash
echo 'Starting'
REGION=`curl http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}'`
echo $REGION
echo 'Configuring region'
aws configure set region $REGION



echo 'Getting S3 Bucket Location'
agentloc=`aws ssm get-parameter --name AgentInstallLocation --query 'Parameter.Value' --output text`

echo $agentloc

echo 'Downloading Agent and Definitions'
aws s3 cp s3://$agentloc/scwp_agent_amazonlinux_package.tar.gz /tmp/scwp_agent_amazonlinux_package.tar.gz

echo 'Change to TMP Dir'
cd /tmp/

echo 'Extracting the Agent'
tar -xvf scwp_agent_amazonlinux_package.tar.gz --directory /tmp/
echo 'Install Agenting'
chmod 755 /tmp/installagent.sh
/tmp/installagent.sh

echo 'Rebooting'
reboot

# Add command to call installer.  For example "yum install .\ExamplePackage.rpm"