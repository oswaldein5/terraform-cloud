#* Assign values to declared vars
virgina_cidr = "10.10.0.0/16"

# public_subnet  = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-07caf09b362be10b8"
  "instance_type" = "t2.micro"
}

enable_monitoring = 0

ingress_ports_list = [22, 80, 443]

tags = {
  "env"         = "DEV"
  "contributor" = "Oswaldo Solano"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC-v"       = "1.8.2"
  "project"     = "nemesis"
  "region"      = "virginia"
}
