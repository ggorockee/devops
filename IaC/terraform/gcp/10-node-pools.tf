data "google_service_account" "ggorockee" {
  account_id = "ggorockee"
}

#resource "google_container_node_pool" "general" {
#  name       = "general"
#  cluster    = google_container_cluster.primary.id
#  node_count = 1
#
#  management {
#    auto_repair  = true
#    auto_upgrade = true
#  }
#
#  autoscaling {
#    min_node_count = 3
#    max_node_count = 3
#  }
#
#  node_config {
#    preemptible  = false
#    machine_type = "e2-medium"
#
#    labels = {
#      role = "general"
#    }
#
#    disk_size_gb = 50
#    service_account = data.google_service_account.sa.email
#    oauth_scopes = [
#      "https://www.googleapis.com/auth/devstorage.read_only",
#      "https://www.googleapis.com/auth/logging.write",
#      "https://www.googleapis.com/auth/monitoring",
#      "https://www.googleapis.com/auth/servicecontrol",
#      "https://www.googleapis.com/auth/service.management.readonly",
#      "https://www.googleapis.com/auth/trace.append"
#    ]
#
#    metadata = {
#      disable_legacy_endpoints = true
#    }
#    image_type = "COS_CONTAINERD"
#    disk_type  = "pd-standard"
#    shielded_instance_config {
#      enable_integrity_monitoring = true
#    }
#  }
#}

resource "google_container_node_pool" "spot" {
  name    = "spot"
  cluster = google_container_cluster.primary.id
  node_count = 1


  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 3
    max_node_count = 3
  }

  node_config {
    machine_type = local.node_pool.machine_type

    labels = {
      role = terraform.workspace
    }

    disk_size_gb = local.node_pool.disk_size_gb
    service_account = data.google_service_account.ggorockee.email
    oauth_scopes = local.node_pool.oauth_scopes

    metadata = local.node_pool.metadata
    image_type = local.node_pool.image_type
    disk_type  = local.node_pool.disk_type

    shielded_instance_config {
      enable_integrity_monitoring = local.node_pool.shielded_instance_config.enable_integrity_monitoring
    }
    spot = local.node_pool.spot
  }

}