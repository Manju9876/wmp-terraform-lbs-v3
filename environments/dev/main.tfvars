dns_domain = "devopsbymanju.shop."
env = "dev"

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
      alb_internal = true
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

