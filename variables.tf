variable "primary_region" {
  description = "The primary AWS region where the Elasticache Replication Group will be created."
  default     = "us-east-2"
}

variable "secondary_region-1" {
  type        = string
  description = "Secondary region for Elasticache replication."
  default     = "eu-west-1"
}

variable "secondary_region-2" {
  type        = string
  description = "Secondary region for Elasticache replication."
  default     = "ap-east-1"
}

variable "replication_group_id_suffix" {
  type = string
  description = "The suffix to be used in replication group IDs."
}

variable "node_type" {
  type    = string
  default = "cache.r5.large"
}

variable "engine_version" {
  type    = string
  default = "6.x"
}

variable "cache_clusters" {
  description = "The number of node groups (shards) on the global replication group."
  type        = number
  default     = 2
}

variable "replicas" {
  type    = number
  default = 1
}

variable "owner" {
  type = string
  description = "Owner of the Elasticache resources."
  validation {
    condition     = can(regex("^(Data Services|Platform API|Infrastructure|Web)$", var.owner))
    error_message = "Invalid value for Owner variable. Allowed values: Data Services, Platform API, Infrastructure, Web."
  }
}

variable "service" {
  type = string
  description = "Service name of the Elasticache resources."
}

variable "name" {
  type = string
  description = "Name of the Elasticache resources."
}

variable "classification" {
  type = string
  description = "Classification of the Elasticache resources."
  validation {
    condition     = can(regex("^(Internal|Confidental|Public)$", var.classification))
    error_message = "Invalid value for Classification variable. Allowed values: Internal, Confidental, Public."
  }
}

variable "maxmemory_policy" {
  type = string
  description = "The maxmemory-policy Redis parameter."
  default     = "allKeys-lru"
}
