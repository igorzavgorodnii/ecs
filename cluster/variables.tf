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
        us-east-1 = "ami-0cff7528ff583bf9a"
    }
}

variable "ssh_pubkey_file" {
    description = "Path to an SSH public key"
    default = "~/.ssh/id_rsa.pub"
}

# variable "subnets" {
#   type    = "list"
#   default = ["subnet-ada14af6", "subnet-36e64951", "subnet-bd6fdaf4"]
# }

# variable "security_groups" {
#   type    = "list"
#   default = ["sg-0c7ec2400da41a170", "sg-d5defca8"]
# }
