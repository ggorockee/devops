resource "google_container_cluster" "primary" {
  name = "${var.project_name}-gke"
  node_locations = local.k8s.node_locations
  remove_default_node_pool = local.k8s.remove_default_node_pool
  initial_node_count = local.k8s.initial_node_count
  network = google_compute_network.main.self_link
  subnetwork = google_compute_subnetwork.private.self_link
  logging_service          = local.k8s.logging_service
  monitoring_service       = local.k8s.monitoring_service
  networking_mode          = local.k8s.networking_mode
  deletion_protection = local.k8s.deletion_protection

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
    dns_cache_config {
      enabled = false
    }
    gcp_filestore_csi_driver_config {
      enabled = true
    }
  }

  datapath_provider = local.k8s.datapath_provider

  release_channel {
    channel = local.k8s.release_channel.channel
  }

  workload_identity_config {
    workload_pool = local.k8s.workload_identity_config.workload_pool
  }

  ip_allocation_policy {
    cluster_secondary_range_name = local.subnets.secondary_ip_range_pod.range_name
    services_secondary_range_name = local.subnets.secondary_ip_range_svc.range_name
  }

  private_cluster_config {
    enable_private_nodes    = local.k8s.private_cluster_config.enable_private_nodes
    enable_private_endpoint = local.k8s.private_cluster_config.enable_private_endpoint
    master_ipv4_cidr_block  = local.k8s.private_cluster_config.master_ipv4_cidr_block
  }

#   logging_config {
#     enable_components = local.k8s.logging_config.enable_components
#   }

#   monitoring_config {
#     enable_components = local.k8s.momitoring_config.enableComponents
#     managed_prometheus {
#       enabled = true
#     }
#   }

  security_posture_config {
    mode = local.k8s.security_posture_config.mode
    vulnerability_mode = local.k8s.security_posture_config.vulnerabilityMode
  }
}