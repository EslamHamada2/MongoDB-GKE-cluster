# Management subnet, includes nat-gateway and private VM 
resource "google_compute_subnetwork" "management_subnet" {
  name          = "managementsubnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west2"
  network       = google_compute_network.my_vpc.id
}

# Restricted subnet, has a private standard GKE cluster
resource "google_compute_subnetwork" "restricted_subnet" {
  name          = "restrictedsubnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west2"
  network       = google_compute_network.my_vpc.id
}
