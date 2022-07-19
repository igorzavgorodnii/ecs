variable "service_name" {
  default = "app"
}


variable "region" {
  default = "us-east-1"
}

variable "availability_zone" {
  default = "us-east-1b"
}

variable "ecs_cluster_name" {
  default = "test"
}

variable "infra_type" {
  default = "ecs"
}

variable "autoscale_min" {
  default = "1"
}

variable "autoscale_max" {
  default = "5"
}

variable "autoscale_desired" {
  default = "2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "amis" {
  description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."
  # TODO: support other regions.
  default = {
    us-east-1 = "ami-00129b193dc81bc31"
  }
}

variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "deregistration_delay" {
  default = 30
}


variable "health_check_path" {
  default     = "/"
  description = "The default health check path"
}


variable "name" {
  description = "Name of the subnet, actual name will be, for example: name_eu-west-1a"
  default     = "name_eu-west-1a"
}

variable "environment" {
  description = "The name of the environment"
  default     = "test"
}

variable "cidrs" {
  type        = list(any)
  description = "List of cidrs"
  default = [
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "availability_zones" {
  type        = list(any)
  description = "List of availability zones"
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}
