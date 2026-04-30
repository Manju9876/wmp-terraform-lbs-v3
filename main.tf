module "apps" {
  for_each   = var.apps
  source     = "./modules/component"


  component_name = each.key
  dns_domain     = var.dns_domain
  env            = var.env
  instance_type  = each.value["instance_type"]
  ports          = each.value["ports"]

}

module "database" {
  depends_on = [module.apps]
  for_each =  var.database
  source = "./modules/component"

  component_name = each.key
  dns_domain     = var.dns_domain
  env            = var.env
  instance_type  = each.value["instance_type"]
  ports          = each.value["ports"]
}