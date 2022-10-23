provider "aws" {
  region  = "us-east-1"
  profile = "adminmember"
}


provider "aws" {
  alias   = "adminmaster"
  profile = "adminmaster"
  region  = "us-east-1"
}


resource "aws_ram_resource_share" "demo" {
  provider = aws.adminmaster  
  name = var.name
  tags = var.tags

  allow_external_principals = var.allow_external_principals
}

resource "aws_ram_resource_association" "assos" {
  provider = aws.adminmaster  
  for_each = { for resource in var.resources : resource.name => resource }
  resource_arn       = each.value.resource_arn # ARN resource you want to associate with the RAM resource share 
  resource_share_arn = aws_ram_resource_share.demo.arn         # ARN of the RAM resource share 
}


resource "aws_ram_principal_association" "something" {
  provider = aws.adminmaster  
  principal             = data.aws_caller_identity.this.account_id   # The principal to associate with the resource share. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN.
  resource_share_arn    = aws_ram_resource_share.demo.arn   # The ARN of the RAM resource share.
}
data "aws_caller_identity" "this" {} 