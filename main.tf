provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  #version    = ">= 2.60.0"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
#  version = "2.6.0"

  name                                   = "buildly-vpc"
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

#  public_subnet_tags = {
#    "kubernetes.io/cluster/buildly-${random_string.suffix.result}" = "shared"
#    "kubernetes.io/role/elb"                                       = "1"
#  }
#
#  private_subnet_tags = {
#    "kubernetes.io/cluster/buildly-${random_string.suffix.result}" = "shared"
#    "kubernetes.io/role/internal-elb"                              = "1"
#  }
}

module "nomad-buildly" {
  source                = "hashicorp/nomad-starter/aws"
#  version               = "0.1.1"
  allowed_inbound_cidrs = ["0.0.0.0/0"]
  vpc_id                = module.vpc.vpc_id
  consul_version        = "1.8.5"
  nomad_version         = "0.12.7"
  owner                 = "cdunlap"
  name_prefix           = "buildly"
  key_name              = "cdunlap-aws"
  nomad_servers         = 3
  nomad_clients         = 3
}