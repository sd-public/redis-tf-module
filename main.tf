resource "aws_elasticache_parameter_group" "primary" {
  name   = "elasticache-${var.replication_group_id_suffix}-primary-parameters"
  family = "redis6.x"

  parameter {
    name  = "maxmemory-policy"
    value = var.maxmemory_policy
  }
}

resource "aws_elasticache_replication_group" "primary" {
  provider                   = aws.primary
  replication_group_id       = "elasticache-${var.replication_group_id_suffix}-primary"
  description                = "Primary replication group in ${var.primary_region}"
  engine                     = "redis"
  engine_version             = var.engine_version
  node_type                  = var.node_type
  num_node_groups            = var.cache_clusters
  replicas_per_node_group    = var.replicas
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  parameter_group_name       = aws_elasticache_parameter_group.primary.name
  tags = {
    Owner          = var.owner
    Service        = var.service
    Name           = var.name
    Classification = var.classification
  }
}

resource "aws_elasticache_global_replication_group" "global_rep" {
  global_replication_group_id_suffix = var.replication_group_id_suffix
  primary_replication_group_id       = aws_elasticache_replication_group.primary.id
}

resource "aws_elasticache_replication_group" "secondary-1" {

  provider                    = aws.secondary-1
  replication_group_id        = "example-${var.replication_group_id_suffix}-secondary-1"
  description                 = "Secondary replication group in ${var.secondary_region-1}"
  global_replication_group_id = aws_elasticache_global_replication_group.global_rep.global_replication_group_id

  num_node_groups            = var.cache_clusters
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  tags = {
    Owner          = var.owner
    Service        = var.service
    Name           = var.name
    Classification = var.classification
  }
}

resource "aws_elasticache_replication_group" "secondary-2" {

  provider                    = aws.secondary-2
  replication_group_id        = "example-${var.replication_group_id_suffix}-secondary-1"
  description                 = "Secondary replication group in ${var.secondary_region-2}"
  global_replication_group_id = aws_elasticache_global_replication_group.global_rep.global_replication_group_id

  num_node_groups            = var.cache_clusters
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  tags = {
    Owner          = var.owner
    Service        = var.service
    Name           = var.name
    Classification = var.classification
  }
}

