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
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"
    auto_network_tier = "PREMIUM"
    enable_dynamic_port_allocation = true
    min_ports_per_vm                    = 64
  }

  k8s = {
    node_locations = ["asia-northeast3-a", "asia-northeast3-b", "asia-northeast3-c"]
    remove_default_node_pool = true
    initial_node_count = 1
    logging_service = "logging.googleapis.com/kubernetes"
    monitoring_service = "monitoring.googleapis.com/kubernetes"
    networking_mode          = "VPC_NATIVE"
    deletion_protection = false

    release_channel = {
      channel = "REGULAR"
    }

    workload_identity_config = {
      workload_pool = "${var.project_id}.svc.id.goog"
    }

    private_cluster_config = {
      enable_private_nodes    = true
      enable_private_endpoint = false
      master_ipv4_cidr_block  = "172.16.0.0/28"
    }

    datapath_provider = "ADVANCED_DATAPATH"

    logging_config = {
      enable_components = [
        "SYSTEM_COMPONENTS",
        "WORKLOADS"
      ]
    }

    momitoring_config = {
      enableComponents = [
        "SYSTEM_COMPONENTS",
        "STORAGE",
        "POD",
        "DEPLOYMENT",
        "STATEFULSET",
        "DAEMONSET",
        "HPA",
        "CADVISOR",
        "KUBELET"
      ]
    }

    security_posture_config = {
      mode = "BASIC"
      vulnerabilityMode = "VULNERABILITY_DISABLED"
    }
  }

  node_pool = {
    spot = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    machine_type = "e2-standard-2"
    disk_size_gb = 50

    metadata = {
      disable_legacy_endpoints = true
    }

    image_type = "COS_CONTAINERD"
    disk_type  = "pd-standard"

    shielded_instance_config = {
      enable_integrity_monitoring = true
    }
  }
}