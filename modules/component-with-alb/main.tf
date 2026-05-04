resource "aws_security_group" "instance" {

  name = "${var.component_name}-${var.env}-instance"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
     }

  tags = {
    Name = "${var.component_name}-${var.env}-instance"
  }
}

resource "aws_security_group" "alb" {

  name = "${var.component_name}-${var.env}-alb"

  dynamic "ingress" {
    for_each = var.ports

    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component_name}-${var.env}-alb"
  }
}
resource "aws_launch_template" "main" {
  name = "${var.component_name}-${var.env}"
  image_id = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance.id,aws_security_group.alb.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.component_name}-${var.env}"
    }
  }
}

resource "aws_autoscaling_group" "main" {
  availability_zones = ["us-east-1a","us-east-1b"]
  desired_capacity   = var.asg["min_size"]
  max_size           = var.asg["max_size"]
  min_size           = var.asg["min_size"]

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.component_name}-${var.env}"
  port     = var.alb["ports"]
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb" "main" {
  name               = "${var.component_name}-${var.env}"
  internal           = var.alb["alb_internal"]
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.alb_subnets

  tags = {
    Environment = "${var.component_name}-${env}"
  }
}


resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.component_name}-${var.env}"
  type    = "CNAME"
  ttl     = 30
  records = [aws_lb.main.dns_name]
}

# resource "null_resource" "ansible_code" {
# # depends_on = [aws_route53_record.main]
#
#   triggers = {
#     instance_id_change = aws_instance.main.id
#     #always_run = timestamp()
#   }
#
#   provisioner "remote-exec" {
#
#     connection {
#       type     = "ssh"
#       user     = "ec2-user"
#       #      private_key = file(var.private_key_pem)
#       password = "DevOps321"
#       host     = aws_instance.main.public_ip
#     }
#
#     inline = [
#       "sudo python3.11 -m pip install ansible hvac",
#       "ansible-pull -i localhost, -U https://github.com/Manju9876/wmp-ansible wmp.yaml -e component_name=${var.component_name} -e env=${var.env}"
#     ]
#   }
# }






