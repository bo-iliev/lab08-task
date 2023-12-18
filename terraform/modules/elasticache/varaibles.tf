variable "subnet_ids" {
  description = "The subnet IDs for the ElastiCache cluster"
  type        = list(string)
}

variable "cluster_id" {
  description = "The ID of the ElastiCache cluster"
  type        = string
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes in the node group"
  type        = string
}

variable "num_cache_nodes" {
  description = "The number of cache nodes that the cache cluster should have"
  type        = number
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the ElastiCache cluster"
  type        = string
}
