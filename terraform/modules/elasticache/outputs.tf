output "elasticache_redis_endpoint" {
  description = "The endpoint of the Redis ElastiCache cluster"
  value       = aws_elasticache_cluster.redis_cluster.cache_nodes[0].address
}

output "redis_cluster_id" {
  description = "The ID of the Redis cluster"
  value       = aws_elasticache_cluster.redis_cluster.cluster_id
}