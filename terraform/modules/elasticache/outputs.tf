output "elasticache_redis_endpoint" {
  description = "The endpoint of the Redis ElastiCache cluster"
  value       = aws_elasticache_cluster.redis_cluster.cache_nodes[0].address
}
