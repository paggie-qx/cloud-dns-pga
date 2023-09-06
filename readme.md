# Cloud DNS PGA setup
##  This Terraform code will execute following actions:
1. enable api: "dns.googleapis.com", "compute.googleapis.com", "cloudresourcemanager.googleapis.com"
2. create custom vpc
3. create 1 subnet without external IP ranges
4. create Cloud DNS private zone
5. create type CNAME record set
6. create type A record set

##  What you should do:
1. open variables.tf file and setup arguments
2. run terraform init command
3. run terraform apply command

## Caution
Noted that if you run terraform destroy command, the entire infrastructure build along with this terraform code will be destroyed. Thus, if you still need the dns.googleapis.com or compute.googleapis.com API to be enabled, you shall annotate the google_project_service.service resource block in order to protect it from being destroyed.


Reference: https://cloud.google.com/vpc/docs/configure-private-google-access-hybrid#config 