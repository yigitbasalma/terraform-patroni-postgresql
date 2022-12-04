locals {
    # Environment suffix mapping
    env_suffix = {
        test = "t"
        qa   = "q"
        prod = "p"
    }

    # Tags for all resources
    tags = merge(
        var.base_tags,
        {
            Environment = var.environment,
            CostCenter  = "postgresql-${var.project_name}-${var.environment}",
            Project     = var.project_name,
            Domain      = var.domain
        }
    )

    # Create hostname prefix for hosts
    haproxy_hostname_prefix = "wrv${var.project_code}haprx"
    etcd_hostname_prefix = "wrv${var.project_code}etcd"
    postgres_hostname_prefix = "wrvg${var.project_code}psql"
}