variable "buckets" {
  default = ["javahome", "javahome2"]
  type    = set(string)
}

resource "aws_s3_bucket" "b" {
  for_each = var.buckets
  bucket   = "${each.value}-${uuid()}"
  acl      = "private"

  tags = {
    Name        = "${each.value}-bucket"
    Environment = "Dev"
  }
  lifecycle {
    ignore_changes = [
      bucket
    ]
  }
}