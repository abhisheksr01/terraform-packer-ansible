variable "availability_zone" {
  default = "eu-west-2a"
}
variable "cidr_block_range" {
  description = "The CIDR block for the VPC"
  default     = "10.1.0.0/16"
}
variable "subnet1_cidr_block_range" {
  description = "The CIDR block for public subnet of VPC"
  default     = "10.1.0.0/24"
}
variable "subnet2_cidr_block_range" {
  description = "The CIDR block for private subnet of VPC"
  default     = "10.2.0.0/24"
}
variable "default_tags" {
  type = object({
    Owner       = string
    Team        = string
    Environment = string
    Description = string
    Repository  = string
    Provisioner = string
  })
}
variable "public_key_path" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}
