# gcloud dns --project=ggorockee-2024-08-16 managed-zones create ggorockee --description="" --dns-name="ggorockee.com." --visibility="public" --dnssec-state="off"

# GET https://dns.googleapis.com/dns/v1/projects/ggorockee-2024-08-16/managedZones/ggorockee
# {
#   "cloudLoggingConfig": {
#     "enableLogging": false
#   },
#   "creationTime": "2024-09-20T07:04:49.937Z",
#   "description": "",
#   "dnsName": "ggorockee.com.",
#   "fingerprint": "3a569726755db212000001920e3f6a11",
#   "id": 4203713493630562834,
#   "location": "global",
#   "name": "ggorockee",
#   "nameServers": [
#     "ns-cloud-c1.googledomains.com.",
#     "ns-cloud-c2.googledomains.com.",
#     "ns-cloud-c3.googledomains.com.",
#     "ns-cloud-c4.googledomains.com."
#   ],
#   "visibility": "public"
# }

# POST https://dns.googleapis.com/dns/v1/projects/ggorockee-2024-08-16/managedZones/ggorockee/changes
# {
#   "additions": [
#     {
#       "name": "wilecard.ggorockee.com.",
#       "rrdatas": [
#         "12.168.0.1",
#         "1.2.3.4"
#       ],
#       "ttl": 300,
#       "type": "A"
#     }
#   ]
# }

# module "dns-public-zone-ggorockee" {
#   source = "terraform-google-modules/cloud-dns/google"
#   version = "4.0"
#   project_id = var.project_id
#   type = "public"
#   name = "ggorockee"
#   domain = "ggorockee.com"

#   recordsets = local.recordsets

# }

# module "dns-public-zone-dev-ggorockee" {
#   source = "terraform-google-modules/cloud-dns/google"
#   version = "4.0"
#   project_id = var.project_id
#   type = "public"
#   name = "ggorockee-dev"
#   domain = "dev.ggorockee.com"

#   recordsets = local.recordsets
# }

# output "dns_public_zone_dev_ggorockee" {
#   value = module.dns-public-zone-dev-ggorockee.name_servers
# }

resource "google_dns_managed_zone" "ggorockee-zone" {
  name        = "ggorockee"
  dns_name    = "ggorockee.com."
  description = "ggorockee DNS zone"

  visibility = "public"
  
}

resource "google_dns_managed_zone" "ggorockee-dev-zone" {
  name        = "ggorockee-dev"
  dns_name    = "dev.ggorockee.com."
  description = "ggorockee dev DNS zone"

  visibility = "public"
  
}

resource "google_dns_record_set" "dev-ns" {
  name         = "dev.${google_dns_managed_zone.ggorockee-zone.dns_name}"
  managed_zone = google_dns_managed_zone.ggorockee-zone.name
  type         = "NS"
  ttl          = 300

  rrdatas = google_dns_managed_zone.ggorockee-dev-zone.name_servers
}

