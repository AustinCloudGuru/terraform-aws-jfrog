variable "name" {
  description = "Security Group Name"
  type        = string
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "security_group_ingress" {
  description = "Can be specified multiple times for each ingress rule. "
  type = map(object({
    from_port   = number
    protocol    = string
    to_port     = number
    self        = bool
    cidr_blocks = list(string)
    description = string
  }))
  default = {
    ssh         = { from_port = 22, protocol = "tcp", to_port = 22, self = true, cidr_blocks = null, description = "SSH" }
    http        = { from_port = 80, protocol = "tcp", to_port = 80, self = true, cidr_blocks = null, description = "HTTP Access" }
    artifactory = { from_port = 8081, protocol = "tcp", to_port = 8081, self = true, cidr_blocks = null, description = "Artifactory Service" }
    access      = { from_port = 8040, protocol = "tcp", to_port = 8040, self = true, cidr_blocks = null, description = "Access" }
    accessGrpc  = { from_port = 8045, protocol = "tcp", to_port = 8048, self = true, cidr_blocks = null, description = "AccessGrpc" }
  }
}

variable "security_group_egress" {
  description = "Can be specified multiple times for each egress rule. "
  type = map(object({
    description = string
    from_port   = number
    protocol    = string
    to_port     = number
    self        = bool
    cidr_blocks = list(string)
  }))
  default = {
    default = {
      description = "Allow All Outbound"
      from_port   = 0
      protocol    = "-1"
      to_port     = 0
      self        = false
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
