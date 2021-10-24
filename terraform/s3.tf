resource "aws_s3_bucket_object" "dist_html" {
  for_each = fileset(var.dist_dir, "**/*.html")

  bucket = aws_s3_bucket.www_bucket.bucket
  key    = each.value
  source = "${var.dist_dir}${each.value}"
  content_type = "text/html"
  etag   = filemd5("${var.dist_dir}${each.value}")
}

resource "aws_s3_bucket_object" "dist_css" {
  for_each = fileset(var.dist_dir, "**/*.css")

  bucket = aws_s3_bucket.www_bucket.bucket
  key    = each.value
  source = "${var.dist_dir}${each.value}"
  content_type = "text/css"
  etag   = filemd5("${var.dist_dir}${each.value}")
}

resource "aws_s3_bucket_object" "dist_js" {
  for_each = fileset(var.dist_dir, "**/*.js")

  bucket = aws_s3_bucket.www_bucket.bucket
  key    = each.value
  source = "${var.dist_dir}${each.value}"
  content_type = "text/javascript"
  etag   = filemd5("${var.dist_dir}${each.value}")
}

resource "aws_s3_bucket_object" "dist_image" {
  for_each = fileset(var.dist_dir, "**/*.{png,jpeg}")

  bucket = aws_s3_bucket.www_bucket.bucket
  key    = each.value
  source = "${var.dist_dir}${each.value}"
  content_type = "image"
  etag   = filemd5("${var.dist_dir}${each.value}")
}

resource "aws_s3_bucket_object" "dist_data" {
  for_each = fileset(var.dist_dir, "**/*.{map,json}")

  bucket = aws_s3_bucket.www_bucket.bucket
  key    = each.value
  source = "${var.dist_dir}${each.value}"
  content_type = "application/json"
  etag   = filemd5("${var.dist_dir}${each.value}")
}

resource "aws_s3_bucket" "www_bucket" {
  bucket = var.domain_name
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_policy.json

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

data "aws_iam_policy_document" "website_policy" {
  statement {
    actions   = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.domain_name}/*"
    ]
  }
}

