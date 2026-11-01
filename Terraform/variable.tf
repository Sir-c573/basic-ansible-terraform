variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ssh_cidr" {
  description = "your public IP address allowed ssh"
  type        = string
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}