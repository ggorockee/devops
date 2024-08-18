locals {
  env = contains(["dev", "prod"], terraform.workspace) ? terraform.workspace : null
  vpc = {
    routing_mode = var.routing_mode
    auto_create_subnetworks = false
    mtu = 1460
    delete_default_routes_on_create = false
  }

  subnets = {
    ip_cidr_range = "10.0.0.0/18"
    name          = "private"
    private_ip_google_access = true

    secondary_ip_range_pod = {
    range_name = var.secondary_pod_range_name
    ip_cidr_range = "10.48.0.0/14"
    }

    secondary_ip_range_svc = {
    range_name = var.secondary_service_range_name
    ip_cidr_range = "10.52.0.0/20"
    }
  }

  router = {
    name = "${var.project_name}-router"
  }

  nat = {
    name = "${var.project_name}-nat"
    nat_ip_allocate_option = "MANUAL_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  }
}