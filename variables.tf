variable "aws_region" {
 type = "string"
 description = "AWS Region."
}

variable "aws_avaliability_zones" {
  type = "list"
  description = "AWS avaliability zone for subnets (2 values a-z)."
}

variable "aws_access_key" {
 type = "string"
 description = "The account identification key used by Terraform client."
}

variable "aws_secret_key" {
 type = "string"
 description = "The secret key used by terraform client to access AWS."
}

variable "accessing_computer_ip" {
    type = "string"
    description = "Public IP of the computer accessing the cluster via kubectl or browser."
}

variable "keypair_name" {
  type = "string"
  description = "Keypair file used to access instances via SSH"
}

variable "cluster_name" {
  type = "string"
  description = "K8S cluester name"
  default = "simple"
}