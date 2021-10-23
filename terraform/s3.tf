resource "aws_s3_bucket_object" "dist" {
  for_each = fileset(var.dist_dir, "**")

  bucket = aws_s3_bucket.www_bucket.bucket
  key    = each.value
  source = "${var.dist_dir}${each.value}"
  etag   = filemd5("${var.dist_dir}${each.value}")
}

resource aws_s3_bucket www_bucket {
  bucket = "cashcade-app"
  acl    = "private"
}
