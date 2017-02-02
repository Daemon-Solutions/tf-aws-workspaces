tf-aws-workspaces
=================

AWS Workspaces - Terraform Module

Resources
---------

This module will create the following resources:

- AWS Workspace via a Cloudformation Stack

Limitations
-----------

- The Directory Service has to be manually registered with Workspaces.  An API does not currently exist for this to be automated.
- Security groups are manually defined within the Directory Service registration. An API does not currently exist for this to be automated.
- Workspace users have to exist within AD before instantiation. An API does not currently exist for this to be automated.
- The KMS key policy is currently the default policy when instantiated
- Workspace Bundle ID has to be declared as a variable
- Only one workspace is created with Cloudformation stack though further work will continue to automate a set number

Usage
-----

```js
module "workspaces" {
  source = "git@gogs.bashton.net:Bashton-Terraform-Modules/tf-aws-workspaces.git"

  customer                    = "${var.customer}"
  envname                     = "${var.envname}"
  envtype                     = "${var.envtype}"

  workspaces_directory_id     = "${data.terraform_remote_state.vpc.ads_id}"
  workspaces_bundle_id        = "${var.workspaces_bundle_id}"
  workspaces_ad_username      = "${var.workspaces_ad_username}"
  workspaces_volume_kms_key   = "${aws_kms_key.workspaces.key_id}"
}
```

Variables
---------

- `customer`             - customer name to identify resources
- `envname`              - environment name
- `envtype`              - environment type
- `aws_region`           - aws region

- `workspace_bundle_id`  - the ID of the chosen workspace bundle
- `workspace_as_username`- the Active Direcory username assigned to the workspace

Outputs
-------

- workspace_id           - the Workspace ID exported from Cloudformation stack
