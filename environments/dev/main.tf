
/*
+--------------------------------
| Credentials
+--------------------------------
*/
provider "aws" {
  shared_credentials_file = "${var.location_aws_credentials}"
  region="${var.region}"
}


/*
+--------------------------------
| Network
+--------------------------------
*/

module "newtwork" {
  source = "./../../modules/network"
  project = "${var.project}"
  environment="${var.environment}"
  region="${var.region}"
}



/*
+--------------------------------
| Instances
+--------------------------------
*/

/*
module "instances" {
  source = "./../../modules/instances"
  project = "${var.project}"
  environment="${var.environment}"
  region="${var.region}"

  public_subnet_ids= "${module.newtwork.public_subnet_ids}"
  availability_zones= "${module.newtwork.availability_zones}"
}

*/