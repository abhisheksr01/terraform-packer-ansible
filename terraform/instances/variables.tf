variable "key_pair_name" {
  description = "EC2 Key pair name"
  default     = "publicKey"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
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
