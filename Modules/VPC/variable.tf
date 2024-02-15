#environment
variable "env" {
    type = string
}

#type
variable "type" {
  type = string
}

# Stack name
variable "cluster_name" {
  type = string
}

#VPC CIDR
variable "vpc_cidr" {
  type = string
  default = "10.0.1.0/24"
}

# CIDR of public subet in AZ1 
variable "public_subnet_az1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}


#  CIDR of ppublic subnet in AZ2
variable "public_subnet_az2_cidr" {
  type = string
  default = "10.0.2.0/24"
}
