# #VPC ID
# output "vpc_id" {
#   value = aws_vpc.eks_vpc.id
# }

#VPC ID
output "ec2instance_id" {
  value = aws_instance.foo.id
}

# #ID of subnet in AZ 1

# output "public_subnet_az1" {
#   value = aws_subnet.public_subnet_az1.id
# }

# #ID of subnet in AZ 2

# output "public_subnet_az2" {
#   value = aws_subnet.public_subnet_az2.id
# }

# #ID of internet gateway

# output "eks_internet_gateway" {
#   value = aws_internet_gateway.eks_internet_gateway.id
# }