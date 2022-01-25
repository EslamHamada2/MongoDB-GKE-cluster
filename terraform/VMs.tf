resource "google_compute_instance" "my_instance" {
  name         = "myinstance"
  machine_type = "e2-micro"
  zone         = "europe-west2-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network    = google_compute_network.my_vpc.id
    subnetwork = google_compute_subnetwork.management_subnet.id
  }
  service_account {
    email  = google_service_account.instance_sa.email
    scopes = ["cloud-platform"]
  }
}