resource "google_compute_subnetwork" "private" {
  ip_cidr_range = local.subnets.ip_cidr_range
  name          = local.subnets.name
  network       = google_compute_network.main.id
  private_ip_google_access = local.subnets.private_ip_google_access
  region = var.region

  secondary_ip_range {
    range_name = local.subnets.secondary_ip_range_pod.range_name
    ip_cidr_range = local.subnets.secondary_ip_range_pod.ip_cidr_range
  }

  secondary_ip_range {
    range_name = local.subnets.secondary_ip_range_svc.range_name
    ip_cidr_range = local.subnets.secondary_ip_range_svc.ip_cidr_range
  }
}