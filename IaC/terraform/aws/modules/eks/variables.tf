variable "vpc_id" {
  type = string
  description = "vpc id"
}

variable "private_subnets" {
  type = list(string)
  description = "private subnets"
}

variable "owner" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "public_access" {
  type = bool
}

variable "private_access" {
  type = bool
}

variable "capacity_type" {
  type = string
}
variable "instance_types" {
  type = list(string)
}