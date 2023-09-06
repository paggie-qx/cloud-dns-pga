# enable api
resource "google_project_service" "service" {
  for_each = toset(var.api)
  project  = var.gcp_project_id
  service  = each.key
}

# create custom vpc
resource "google_compute_network" "vpc_network" {
  # (resource arguments)
  name                            = var.gcp_vpc_name
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
  enable_ula_internal_ipv6        = false
  mtu                             = 1460
  timeouts {}
  depends_on = [google_project_service.service]
}

# create subnet
resource "google_compute_subnetwork" "vpc_subnetwork" {
  name                     = var.gcp_vpc_subnet.name
  ip_cidr_range            = var.gcp_vpc_subnet.ip_cidr_range
  region                   = var.gcp_vpc_subnet.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
  depends_on               = [google_compute_network.vpc_network]
}

# create Cloud DNS private zone 
resource "google_dns_managed_zone" "private_zone" {
  for_each    = var.dns_name
  name        = each.key
  dns_name    = each.value
  description = "Required domain for Private Google Access"

  visibility = "private"
  depends_on = [google_project_service.service]

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc_network.id
    }
  }
}

# create type CNAME record set
resource "google_dns_record_set" "cname" {
  for_each     = var.dns_name
  managed_zone = each.key
  name         = "*.${each.value}"
  type         = "CNAME"
  rrdatas      = [each.value]
  ttl          = 300
  depends_on   = [google_dns_managed_zone.private_zone]
}

# create type A record set
resource "google_dns_record_set" "a" {
  for_each     = var.dns_name
  managed_zone = each.key
  name         = each.value
  type         = "A"
  rrdatas      = var.rrdatas.private
  ttl          = 300
  depends_on   = [google_dns_managed_zone.private_zone]
}

# create inbound policy
resource "google_dns_policy" "default" {
  name                      = "pga-policy"
  enable_inbound_forwarding = true

  networks {
    network_url = google_compute_network.vpc_network.id
  }
}
