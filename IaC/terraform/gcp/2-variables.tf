#region = "us-west1"
#project_id = "ggorockee-2024-08-16"

variable "project_name" {
  type = string
  description = "project name"
}

variable "project_id" {
  type        = string
  description = "project id"
  default     = ""

  validation {
    condition     = length(var.project_id) > 0
    error_message = "The project_id must not be empty."
  }
}


## VPC SETTING
variable "routing_mode" {
  type = string
  default = "REGIONAL"
}

variable "secondary_pod_range_name" {
  type = string
  default = "k8s-pod-range"
}

variable "secondary_service_range_name" {
  type = string
  default = "k8s-service-range"
}
#variable "network" {
#  type        = string
#  description = "The VPC network"
#  default     = "gke-network"
#}
#
variable "region" {
  type        = string
  description = "cluster region"
  default     = ""

  validation {
    condition     = can(regex("^asia-northeast3", var.region))
    error_message = "The region must start with 'asia-northeast3'."
  }
}
#variable "env" {
#  type        = string
#  description = "The environment for the GKE cluster"
#  validation {
#    condition = contains(["dev", "prod"], var.env)
#    error_message = "the env is \"dev\" or \"prod\""
#  }
#}
#
#
#variable "zones" {
#  type        = list(string)
#  description = "to host cluster in"
#  default     = ["asia-northeast3-a", "asia-northeast3-b", "asia-northeast3-c"]
#
#  validation {
#    condition     = length(var.zones) > 0
#    error_message = "At least one zone must be specified."
#  }
#}
#
#variable "ip_range_pods_name" {
#  type        = string
#  description = "The secondary ip ranges for pods"
#  default     = "subnet-01-pods"
#}
#
#variable "ip_range_services_name" {
#  type        = string
#  description = "The secondary ip ranges for services"
#  default     = "subnet-01-services"
#}
#
### gke cluster
#variable "cluster_name" {
#  type = string
#  default = "ggorockee-gke"
#}