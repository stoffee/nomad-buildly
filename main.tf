provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                                   = "${var.name_prefix}-vpc"
  cidr                                   = "10.0.0.0/16"
  azs                                    = data.aws_availability_zones.available.names
  private_subnets                        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets                         = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway                     = true
  single_nat_gateway                     = true
  enable_dns_hostnames                   = true
  create_database_subnet_group           = true
  create_database_internet_gateway_route = true
  create_database_nat_gateway_route      = true

}


module "nomad_cluster" {
  source = "./modules/nomad_cluster"

  allowed_inbound_cidrs  = var.allowed_inbound_cidrs
  instance_type          = var.instance_type
  consul_version         = var.consul_version
  nomad_version          = var.nomad_version
  consul_cluster_version = var.consul_cluster_version
  bootstrap              = var.bootstrap
  key_name               = var.key_name
  name_prefix            = var.name_prefix
  vpc_id                 = module.vpc.vpc_id
  public_ip              = var.public_ip
  nomad_servers          = var.nomad_servers
  nomad_clients          = var.nomad_clients
  consul_config          = var.consul_config
  enable_connect         = var.enable_connect
  owner                  = var.owner
}
