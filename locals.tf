locals {
  tags          = merge(var.vpc_tags, { Name = "iac-6pm-${terraform.workspace}" })
  az_names      = data.aws_availability_zones.available.names
  az_count      = length(local.az_names)
  pub_sub_ids   = aws_subnet.main.*.id
  pub_sub_count = length(aws_subnet.main.*.id)
}