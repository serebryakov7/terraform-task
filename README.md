# Terraform task

```
1. Develop Terraform module to deploy simple EKS cluster

2.
a. Develop Lambda function which will create dayly snapshots for EBS volumes attached to instances based on Tags
b. Develop Terraform deployment for Lambda function developed for 2a

3. Provide acces to GitHub or GitLab repositories with the code created for tasks 1,2
```

## Usage
Provide AWS keys, accessing IP address, region and avaliability zones to tfvars file.

#### Deployment
```
terraform init
terraform plan
terraform apply
```

As an output you are given an SSH key that is used in every node within EKS cluster.
Accessing IP is used in security group. It's CIDR is /32
As default tag for EBS backup