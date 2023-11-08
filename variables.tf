variable "api" {
  type    = list(string)
  default = ["dns.googleapis.com", "compute.googleapis.com", "cloudresourcemanager.googleapis.com"] # 填寫欲啟用的 api
}

variable "gcp_project_id" {
  default = "project-name" # 填寫 project id
}

variable "gcp_region" {
  default = "asia-east1" # 填寫 gcp region
}

variable "gcp_vpc_name" {
  default = "vpc-name" # 填寫 vpc name
}

variable "gcp_vpc_subnet" {
  type = object({
    name          = string,
    ip_cidr_range = string,
    region        = string
  })

  default = {
    name          = "subnet-name", # 填寫 subnet name
    ip_cidr_range = "10.0.0.0/24" # 填寫 subnet CIDR range
    region        = "asia-east1"  # 填寫 subnet region
  }
}

variable "dns_name" {
  type = map(string)
  default = {
    # name = zone_name
    "accounts-google-com"              = "accounts.google.com.",
    "appengine-google-com"             = "appengine.google.com.",
    "appspot-com"                      = "appspot.com.",
    "backupdr-cloud-google-com"        = "backupdr.cloud.google.com.",
    "backupdr-googleusercontent-com"   = "backupdr.googleusercontent.com.",
    "cloudfunctions-net"               = "cloudfunctions.net.",
    "cloudproxy-app"                   = "cloudproxy.app.",
    "composer-cloud-google-com"        = "composer.cloud.google.com.",
    "composer-googleusercontent-com"   = "composer.googleusercontent.com.",
    "datafusion-cloud-google-com"      = "datafusion.cloud.google.com.",
    "datafusion-googleusercontent-com" = "datafusion.googleusercontent.com.",
    "dataproc-cloud-google-com"        = "dataproc.cloud.google.com.",
    "dataproc-googleusercontent-com"   = "dataproc.googleusercontent.com.",
    "dl-google-com"                    = "dl.google.com.",
    "gcr-io"                           = "gcr.io.",
    "googleadapis-com"                 = "googleadapis.com.",
    "googleapis-com"                   = "googleapis.com.",
    "gstatic-com"                      = "gstatic.com.",
    "ltsapis-goog"                     = "ltsapis.goog.",
    "notebooks-cloud-google-com"       = "notebooks.cloud.google.com.",
    "notebooks-googleusercontent-com"  = "notebooks.googleusercontent.com.",
    "packages-cloud-google-com"        = "packages.cloud.google.com.",
    "pkg-dev"                          = "pkg.dev.",
    "pki-goog"                         = "pki.goog.",
    "run-app"                          = "run.app.",
    "source-developers-google-com"     = "source.developers.google.com."
  }
}

variable "rrdatas" {
  type = object({
    private    = list(string),
    restricted = list(string)
  })

  default = {
    private    = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"],
    restricted = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
  }
}
