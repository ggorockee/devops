#resource "google_project_iam_member" "ggorockee" {
#  project = "ggorockee-2024-08-16"
#  role = "roles/storage.admin"
#  member = "serviceAccount:${data.google_service_account.ggorockee.email}"
#}
#
#resource "google_service_account_iam_member" "ggorockee" {
#  member             = "serviceAccount:${var.project_id}.svc.id.goog[staging/ggorockee]"
#  role               = "roles/iam.workloadIdentityUser"
#  service_account_id = data.google_service_account.ggorockee.id
#}