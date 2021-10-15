variable "AWS_REGION" {
  type = string
}
variable "CIDR_BLOCK" {
  type = string
}

variable "subnet_cidr" { 
  type = list(string)
}

variable "subnet_az" {
   type = list(string) 
}