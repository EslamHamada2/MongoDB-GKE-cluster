resource "google_container_cluster" "primary_cluster" {
  name       = "my-gke-cluster"
  location   = "europe-west2"
  network    = google_compute_network.my_vpc.id
  subnetwork = google_compute_subnetwork.restricted_subnet.id
  private_cluster_config {
    master_ipv4_cidr_block  = "172.16.0.0/28"
    enable_private_nodes    = true
    enable_private_endpoint = true
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.0.1.0/24"
    }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/21"
    services_ipv4_cidr_block = "/21"
  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "europe-west2"
  cluster    = google_container_cluster.primary_cluster.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    #custom service account for cluster vms.
    service_account = google_service_account.cluster_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}