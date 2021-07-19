output "vpc_arn" {
  value = aws_vpc.main.arn
}
output "vpc_tags" {
  value = aws_vpc.main.tags
}
output "az_names" {
  value = local.az_names
}

output "subnet_ids" {
  value = aws_subnet.main.*.id
}