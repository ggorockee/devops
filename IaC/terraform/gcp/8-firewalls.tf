# Create Firewall in GCP using Terraform
# The next resource is a firewall.
# We don't need to create any firewalls manually for GKE;

resource "google_compute_firewall" "allow-ssh" {
  name    = "${var.project_name}-allow-ssh"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}