resource "google_compute_router_nat" "nat" {
  name                               = local.nat.name
  nat_ip_allocate_option             = local.nat.nat_ip_allocate_option
  router                             = google_compute_router.router.name
  source_subnetwork_ip_ranges_to_nat = local.nat.source_subnetwork_ip_ranges_to_nat
  region = var.region

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_address" "nat" {
  name = local.nat.name
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}