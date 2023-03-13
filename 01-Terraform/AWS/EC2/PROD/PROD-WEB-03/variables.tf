variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "ami_owner" {
  description = "AMI Owner"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet" {
  description = "Subnet"
  type        = string
}

variable "ssh_key_pair" {
  description = "SSH Key Pair"
  type        = string
}