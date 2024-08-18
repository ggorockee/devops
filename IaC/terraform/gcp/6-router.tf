resource "google_compute_router" "router" {
  name    = local.router.name
  network = google_compute_network.main.id
  region = var.region
}