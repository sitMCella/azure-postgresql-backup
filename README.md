# Backup Automation for Azure PostgreSQL Flexible Server

## Table of contents

* [Introduction](#introduction)
* [Requirements](#requirements)
* [Terraform](#terraform)
* [Helm](#helm)

## Introduction

The following project configures one cronjob application in Azure Kubernetes Server to take full backups of a database on one Azure Database for PostgreSQL Flexible Server.

## Requirements

- Terraform
- Azure CLI
- Kubectl
- Helm Chart
- Helmfile

## Terraform

### Configuration

Assign the RBAC roles "Contributor", "User Access Administrator" to the User account on the Subscription level.

Create a file `terraform.tfvars` and specify the values for the following Terraform variables:

```sh
subscription_id="<subscription_id>"
location="<azure_region>" # e.g. "westeurope"
location_abbreviation="<azure_region_abbreviation>" # e.g. "weu"
environment="<environment_name>" # e.g. "test"
workload_name="<workload_name>"
postgresql_administrator_login="<postgresql_administrator_name>"
postgresql_administrator_password="<postgresql_administrator_password>"
allowed_public_ip_address_ranges=[<list_of_allowed_ip_address_ranges>] # Public IP Address ranges allowed to access the Azure resources e.g. "1.2.3.4/32"
allowed_public_ip_addresses=<[<list_of_allowed_ip_addresses>] # Public IP Addresses allowed to access the Azure resources  e.g. "1.2.3.4"
```

Before proceeding with the next sections, open a terminal and login in Azure with Azure CLI using the User account.

### Terraform Project Initialization

```sh
terraform init -reconfigure
```

### Verify the Updates in the Terraform Code

```sh
terraform plan
```

### Apply the Updates from the Terraform Code

```sh
terraform apply -auto-approve
```

### Format Terraform Code

```sh
find . -not -path "*/.terraform/*" -type f -name '*.tf' -print | uniq | xargs -n1 terraform fmt
```

## Helm

### Create Kubernetes Resources

```sh
cd helm
helmfile apply
```

### Check Kubernetes Resources

```sh
kubectl get serviceaccount -n application
kubectl get secret -n application
kubectl get cronjob -n application
```

### Delete Kubernetes Resources

```sh
cd helm
helmfile delete
```

### Check CronJob

```sh
kubectl get jobs -n application
kubectl get pods --selector=job-name=<job-name> -n application
kubectl logs -f <pod-name> -n application
```
