variable "vpc_id" {
  description = "VPC ID onde o RDS será provisionado"
  type        = string
}

variable "subnet1" {
  description = "Subnet 1"
  type        = string
}

variable "subnet2" {
  description = "Subnet 2"
  type        = string
  sensitive   = true
}
