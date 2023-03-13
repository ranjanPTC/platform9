variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "company_name" {
  type    = string
  default = "pf"
}


variable "aws_profile" {
  type    = string
  default = "default"
}

variable "app_name" {
  type    = string
  default = "t3"
}
variable "vpc_cidr" {
  type = string
}

variable "az_count" {
  type    = number
  default = 2
}

variable "private_subnet_app" {
  type    = list(string)
  default = ["private-subnet-app-a", "private-subnet-app-b"]
}

variable "public_subnet" {
  type    = list(string)
  default = ["public-subnet-a", "public-subnet-b"]
}

variable "app_port" {
  type    = number
  default = 80

}
