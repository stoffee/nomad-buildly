variable "aws_access_key" {
  description = "access key"
}

variable "aws_secret_key" {
  description = "secret key"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "allowed_inbound_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks to permit inbound Nomad access from"
 # default = "["0.0.0.0/0"]"
}

variable "bootstrap" {
  type        = bool
  default     = true
  description = "Initial Bootstrap configurations"
}

variable "nomad_clients" {
  default     = "3"
  description = "number of Nomad instances"
}

variable "consul_config" {
  description = "HCL Object with additional configuration overrides supplied to the consul servers.  This is converted to JSON before rendering via the template."
  default     = {}
}

variable "consul_cluster_version" {
  default     = "0.0.1"
  description = "Custom Version Tag for Upgrade Migrations"
}

variable "nomad_servers" {
  default     = "3"
  description = "number of Nomad instances"
}

variable "consul_version" {
  description = "Consul version"
  default = "1.8.5"
}

variable "nomad_version" {
  description = "Nomad version"
  default = "0.12.7"
}

variable "enable_connect" {
  type        = bool
  description = "Whether Consul Connect should be enabled on the cluster"
  default     = false
}

variable "instance_type" {
  default     = "m5.large"
  description = "Instance type for Nomad instances"
}

variable "key_name" {
  default     = "default"
  description = "SSH key name for Nomad instances"
}

variable "name_prefix" {
  description = "prefix used in resource names"
}

variable "owner" {
  description = "value of owner tag on EC2 instances"
}

variable "public_ip" {
  type        = bool
  default     = true
  description = "should ec2 instance have public ip?"
}