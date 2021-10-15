variable "AMI" {
  type = string
}

variable "subnet_list" {
    type = list(string)
}

variable "elb-securitygroup" {
    type = list(string)
}

variable "instance-securitygroup" {
    type = list(string)
}

variable "key_name" {
    type = string
}