data "aws_route53_zone" "cashcade_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.cashcade_zone.zone_id
  name = var.domain_name
  type = "A"
  alias {
    name = aws_s3_bucket.www_bucket.website_domain
    zone_id = aws_s3_bucket.www_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}
