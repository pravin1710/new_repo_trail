# Create Route 53 records for the load balancer endpoints



resource "aws_route53_record" "service_record" {
  zone_id = var.route53_zone_id
  name    = "service-1"
  type    = "A"
  alias {
    name                   = aws_alb.application_load_balancer.dns_name
    zone_id                = aws_alb.application_load_balancer.zone_id
    evaluate_target_health = true
  }
  depends_on = [ aws_alb.application_load_balancer ]
}
