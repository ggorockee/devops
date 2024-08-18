#resource "google_project_service" "compute" {
#  service = "compute.googleapis.com"
#  project = var.project_id
#}
#
#resource "google_project_service" "container" {
#  service = "container.googleapis.com"
#  project = var.project_id
#}

resource "google_compute_network" "main" {
  name = "${var.project_name}-${local.env}"
  routing_mode = local.vpc.routing_mode
  auto_create_subnetworks = local.vpc.auto_create_subnetworks
  mtu = local.vpc.mtu
  delete_default_routes_on_create = local.vpc.delete_default_routes_on_create
}