module "network" {

  source = "./modules/network"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  vpc_name           = var.vpc_name
}

module "ec2" {

  source = "./modules/ec2"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet_id

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
}
