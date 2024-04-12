## Goal
Write a script for creation of a service, and a healthcheck script to verify it is up and responding correctly.
## Prerequisites
You will need an AWS account. Create one if you don't own one already. You can use free-tier resources for this test.
## The Task
You are required to provision and deploy a new service in AWS. It must-
* Be publicly accessible, but *only* on port 80.
* Return the current time on `/now`.
## Mandatory Work
- Script your service using CloudFormation or using any other IaC tool such as terraform etc. and your server configuration management tool of choice should you need one.
- Provision the service (if you want to give them a go and run the service inside a Docker container and make it highly available.) in your AWS account.
- Write a healthcheck script in Python/Go that can be run externally to periodically check if the service is up and its clock is not desynchronised by more than 1 second.
- Alter the README to contain instructions required to:
  * Provision the service.
  * Run the healthcheck script.

Once done, save the code under the `aws-coding-challenge` folder. Feel free to ask questions as you go if anything is unclear, confusing about any part.


# Update

## Provisioning the service

### Prerequisites

- AWS account
- AWS CLI
- Python
- Terraform

### Steps

Travel to `./terraform` or use `terraform -chdir=./terraform ...`

```bash
# Note you can optionally pass variables for: env, app and ami.

terraform init
terraform plan
terraform apply -var="public_key=your_ssh_public_key"
```

### Outputs

This will create a file in the ./terraform called public_ip.txt. This file will contain the public IP of the EC2 instance which is used by the healthcheck script.

## Running the healthcheck script

### Steps

```bash
# Python 3
python3 ./healthcheck_script.py

# Pipenv
pipenv install
pipenv run python ./healthcheck_script.py
```

You should get a response like:

```bash
Current Time (UTC):  2024-04-12 05:09:15.163024+00:00
Server Time (UTC): 2024-04-12 04:44:25+00:00
Service is up but clock is desynchronized by more than 1 second.
Healthcheck result: False
```

## Periodic Healthchecks

Can be setup using a cron job or a scheduled task. E.G.,

```bash
crontab -e
# Add the following line to check every minute
* * * * * /usr/bin/python3 /path/to/healthcheck_script.py
```

## Notes

Only accessible on port 80, if you try to view view your browser you'd need to use `http`, not `https`.