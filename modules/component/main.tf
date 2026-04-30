resource "aws_security_group" "main" {

  name = "${var.component_name}-${var.env}"

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
    Name = "${var.component_name}-${var.env}"
  }
}

resource "aws_instance" "main" {
  depends_on = [aws_security_group.main]

  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "${var.component_name}-${var.env}"
  }
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.component_name}-${var.env}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.main.private_ip]
}

resource "null_resource" "ansible_code" {
# depends_on = [aws_route53_record.main]

  triggers = {
    instance_id_change = aws_instance.main.id
    #always_run = timestamp()
  }

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "ec2-user"
      #      private_key = file(var.private_key_pem)
      password = "DevOps321"
      host     = aws_instance.main.public_ip
    }

    inline = [
      "sudo python3.11 -m pip install ansible hvac",
      "ansible-pull -i localhost, -U https://github.com/Manju9876/wmp-ansible wmp.yaml -e component_name=${var.component_name} -e env=${var.env}"
    ]
  }
}
