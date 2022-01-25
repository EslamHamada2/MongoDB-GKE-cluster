# vpc resource
resource "google_compute_network" "my_vpc" {
  project                 = "databasemigrationproject0"
  name                    = "myvpc"
  auto_create_subnetworks = false
}

# Router and nat-gateway
resource "google_compute_router" "my_router" {
  name    = "myrouter"
  region  = google_compute_subnetwork.management_subnet.region
  network = google_compute_network.my_vpc.id

  bgp {
    asn = 64514
  }
}
resource "google_compute_router_nat" "nat_gateway" {
  name                               = "my-router-nat"
  router                             = google_compute_router.my_router.name
  region                             = google_compute_router.my_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.management_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# firewall role to allow access only through IAP
resource "google_compute_firewall" "default-fw" {
  name    = "test-firewall"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  direction     = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
}