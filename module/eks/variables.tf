variable "vpc_id" {
  type = "string"
}

variable "accessing_computer_ip" {
    type = "string"
    description = "Public IP of the computer accessing the cluster via kubectl or browser."
}

variable "keypair_name" {
  type = "string"
  description = "Keypair file used to access instances via SSH"
}

variable "cluster_subnet_ids" {
  type = "list"
}

variable "cluster_name" {
  type = "string"
}