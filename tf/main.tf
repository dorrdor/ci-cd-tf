# create scale set for the stage/
module "scale_set" {
  source = "./scale_set"
  instances = var.instances_test
}

# # create scale set for the stage/
# module "scale_set" {
#   source = "./scale_set"
#   instances = var.instances_test
# }

# create vm controller/
module "controller" {
  source = "./controller"
  RG = module.scale_set.RG
  VN = module.scale_set.VN

}

# #create a postgres flexible/
# module "postgres" {
# source = "./postgres"
# VN_ID = module.scale_set.VN_ID
# vmssrg  = module.scale_set.vmssrg
# }

