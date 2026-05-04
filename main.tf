module "database" {
  for_each = var.database
  source   = "./modules/component"

  component_name = each.key
  dns_domain     = var.dns_domain
  env            = var.env
  instance_type  = each.value["instance_type"]
  ports          = each.value["ports"]
}

module "apps" {
  depends_on = [module.database]
  source = "./modules/component-with-alb"

  dns_domain  = var.dns_domain
  env         = var.env
  vpc_id      = var.vpc_id
  alb_subnets = var.alb_subnets


  for_each       = var.apps
  component_name = each.key
  instance_type  = each.value["instance_type"]
  ports          = each.value["ports"]
  alb            = each.value["alb"]
  asg            = each.value["asg"]
}
