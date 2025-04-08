
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.test.arn # Reference your ALB
  port              = 80
  protocol          = "HTTP"

  # Default action (e.g., return 404 for unmatched paths)
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
    }
  }
}


# Rule for /worker*
resource "aws_lb_listener_rule" "worker" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100 # Lower number = higher priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.node.arn
  }

  condition {
    path_pattern {
      values = ["/*"] # Matches /worker, /worker/, /worker/any-path
    }
  }
}




