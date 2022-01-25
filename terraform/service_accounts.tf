##private instance service account
resource "google_service_account" "instance_sa" {
  account_id   = "instance-service-account-id"
  display_name = "Service Account2"
}

resource "google_project_iam_binding" "project2" {
  project = "databasemigrationproject0"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.instance_sa.email}"
  ]
}

#cluster instances service account
resource "google_service_account" "cluster_sa" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}
resource "google_project_iam_binding" "project" {
  project = "databasemigrationproject0"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.cluster_sa.email}"
  ]
}