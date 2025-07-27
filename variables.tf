variable "name" {
  type        = string
  default     = "cint-code-test"
  description = "Root name for resources in this project"
}

variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  type        = string
  description = "VPC cidr block"
}

variable "newbits" {
  default     = 8
  type        = number
  description = "How many bits to extend the VPC cidr block by for each subnet"
}

variable "public_subnet_count" {
  default     = 3
  type        = number
  description = "How many subnets to create"
}

variable "private_subnet_count" {
  default     = 3
  type        = number
  description = "How many private subnets to create"
}

variable "instance_type" {
  default     = "t3.micro"
  type        = string
  description = "EC2 instance type"
}

variable "db_instance_class" {
  default     = "db.r5.large"
  type        = string
  description = "RDS instance class"
}

variable "db_name" {
  default     = "appdb"
  type        = string
  description = "Database name"
}

variable "db_username" {
  default     = "admin"
  type        = string
  description = "Database username"
}

variable "min_size" {
  default     = 2
  type        = number
  description = "Minimum number of instances in ASG"
}

variable "max_size" {
  default     = 4
  type        = number
  description = "Maximum number of instances in ASG"
}