resource "google_container_cluster" "primary" {
  name = "${var.project_name}-gke"
  node_locations = ["us-west1-a", "us-west1-c", "us-west1-b"]
  remove_default_node_pool = true
  initial_node_count = 1
  network = google_compute_network.main.self_link
  subnetwork = google_compute_subnetwork.private.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"
  deletion_protection = false

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    gcs_fuse_csi_driver_config {
      enabled = true
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "ggorockee-2024-08-16.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = local.subnets.secondary_ip_range_pod.range_name
    services_secondary_range_name = local.subnets.secondary_ip_range_svc.range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}