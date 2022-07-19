# resource "aws_subnet" "public" {
#   vpc_id            = "${aws_vpc.main.id}"
#   cidr_block        = element(var.cidrs, count.index)
#   availability_zone = element(var.availability_zones, count.index)
#   count             = length(var.cidrs)
#   map_public_ip_on_launch = true

#   tags = {
#     Name        = "${var.name}_${element(var.availability_zones, count.index)}"
#     Environment = var.environment
#   }
# }