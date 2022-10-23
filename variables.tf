variable "name" {
  description = "Name of the resource share"
  type        = string
  default     = "demo-subnet-share"
}


variable "allow_external_principals" {
  description = "Boolean indicating whether principals outside the AWS organization can be associated with the resource share"
  type        = bool
  default     = false
}

variable "resources" {
  description = "Schema list of resources to associate to the resource share"
  type = list(string)
  default = ["arn:aws:ec2:us-east-1:xxxxxxxxx:subnet/subnet-01f56be65457e3ef8", "arn:aws:ec2:us-east-1:xxxxxxxx:subnet/subnet-020b089f99b32657c"]

}

variable "tags" {
  description = "Map of tags to assign to the resource share"
  type        = map(string)
  default     = {}
}
