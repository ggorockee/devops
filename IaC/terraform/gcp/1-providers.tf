provider "google" {
  project     = "ggorockee-2024-08-16"
  region      = "us-west1"
}

#provider "kubernetes" {
#  host                   = "https://${module.gke.endpoint}"
#  token                  = data.google_client_config.default.access_token
#  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
#}