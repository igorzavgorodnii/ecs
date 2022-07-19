provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.1.8"
}

resource "aws_key_pair" "admin" {
  key_name   = "admin-key"
  public_key = file(var.ssh_pubkey_file)
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "Terraform VPC"
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.ecs_cluster_name}-app"
}

resource "aws_autoscaling_group" "ecs-cluster" {
  #availability_zones = ["${var.availability_zone}"]
  name                      = "ECS ${var.ecs_cluster_name}"
  launch_configuration      = aws_launch_configuration.ecs.name
  vpc_zone_identifier       = ["${aws_subnet.main.id}"]
  min_size                  = var.autoscale_min
  max_size                  = var.autoscale_max
  desired_capacity          = var.autoscale_desired
  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_launch_configuration" "ecs" {
  name                 = "ECS ${var.ecs_cluster_name}"
  image_id             = lookup(var.amis, var.region)
  instance_type        = var.instance_type
  security_groups      = ["${aws_security_group.ecs.id}"]
  iam_instance_profile = aws_iam_instance_profile.ecs.name
  # TODO: is there a good way to make the key configurable sanely?
  key_name                    = aws_key_pair.admin.key_name
  associate_public_ip_address = true
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=test-app >> /etc/ecs/ecs.config"

  lifecycle {
    create_before_destroy = true
  }
}


output "cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
