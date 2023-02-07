resource "aws_eib" "eib" {
  name = "eib-1"
  availability_zones = ["us-east-1a", "us-east-1b"]
  
  listner {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  
  health_check {
    healthy_threshold = 2
    unhealthy_thershold = 2
    timeout = 5
    target = "http:80/"
    interval = 30
  }
  
  instances = ["${aws_instance.one.id}","${aws_instance.two.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  tags = {
    Name = "sinde-eib"
  }
} 
  
