# Create the Network
module "vpc" {
  source = "../modules/vpc"

  region        = var.region
  project       = var.project
  vpc_cidr      = "192.168.0.0/16"
  subnet_a_cidr = "192.168.1.0/24"
  subnet_b_cidr = "192.168.2.0/24"
}

# Create the Security Groups
module "sec-groups" {
  source = "../modules/sgp"

  project = var.project
  # Passed from VPC Module
  vpc_id = module.vpc.vpc_id
}

# Create the Load Balancer
module "load-balancer" {
  source  = "../modules/elb"
  project = var.project

  # Passed from Sec Groups Module
  allow_http_id = module.sec-groups.allow_http_id
  
  # Passed from VPC Module
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id


}

# Create the Autoscaling Group
module "autoscaling-group" {
  source = "../modules/asg"
 
  project        = var.project
  region         = var.region
  startup_script = "install_space_invaders.sh"

  image_id = {
    us-east-1 = "ami-0f88e80871fd81e91",
    us-east-2 = "ami-058a8a5ab36292159"
  }

  instance_type      = "t2.micro"
  instance_count_min = 2
  instance_count_max = 5
  add_public_ip      = true

  # Passed from VPC Module
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id

  # Passed from Sec Groups Module
  allow_http_id = module.sec-groups.allow_http_id
  allow_ssh_id  = module.sec-groups.allow_ssh_id

  # Passed from Load Balancer Module
  load_balancer_id = module.load-balancer.load_balancer_id
}