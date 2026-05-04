dns_domain = "devopsbymanju.shop."
env = "dev"
alb_subnets = ["subnet-068ce337c8cfe6696","subnet-0131181fd58ec882a"]
vpc_id = "vpc-0808ea39b049a14b8"

apps = {
  frontend = {
    instance_type = "t3.small"
    ports = {
      frontend = 80
    }
    alb = {
      ports = 80
      alb_internal = false
    }
    asg = {
      min_size = 2
      max_size = 5
    }
  }
  auth-service = {
    instance_type = "t3.small"
    ports = {
      auth-service = 8081
    }
    alb = {
      ports = 8081
      alb_internal = true
    }
    asg = {
      min_size = 2
      max_size = 5
    }
  }
  portfolio-service = {
    instance_type = "t3.small"
    ports = {
      portfolio-service = 8080
    }
    alb = {
      ports = 8080
      alb_internal = true
    }
    asg = {
      min_size = 2
      max_size = 5
    }
  }
  analytics-service = {
    instance_type = "t3.small"
    ports = {
      analytics-service = 8000
    }
    alb = {
      ports = 8000
      alb_internal = true
    }
    asg = {
      min_size = 2
      max_size = 5
    }
  }
}

database = {
  postgresql = {
    instance_type = "t3.small"
    ports = {
      ssh        = 22
      postgresql = 5432
    }
  }
}

