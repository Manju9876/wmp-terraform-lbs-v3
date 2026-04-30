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
  }
  auth-service = {
    instance_type = "t3.small"
    ports = {
      auth-service = 8081
    }
    alb = {
      ports = 8081
      alb_internal = false
    }
  }
  portfolio-service = {
    instance_type = "t3.small"
    ports = {
      portfolio-service = 8080
    }
    alb = {
      ports = 8080
      alb_internal = false
    }
  }
  analytics-service = {
    instance_type = "t3.small"
    ports = {
      analytics-service = 8000
    }
    alb = {
      ports = 8000
      alb_internal = false
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

dns_domain = "devopsbymanju.shop."
env = "prod"

