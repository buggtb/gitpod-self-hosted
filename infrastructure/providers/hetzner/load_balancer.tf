resource "hcloud_load_balancer" "load_balancer" {
  name               = format(module.common.name_format, local.location, "kubernetes")
  load_balancer_type = local.deployment[var.size].load_balancer
  location           = var.location
  algorithm {
    type = "round_robin"
  }
}

resource "hcloud_load_balancer_service" "http" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "http"
  listen_port      = 80
}

resource "hcloud_load_balancer_service" "https" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "tcp" # Use tcp not https as cert is generated by cluster
  listen_port      = 443
  destination_port = 443
}
