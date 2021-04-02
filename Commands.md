# Commonly Used Commands

* `terraform show` -- Shows the state
* `terraform output` -- Shows the ouput
* `terraform plan` 
* To recreate a terraform code even if there are no changes in remote and local state; use `terraform taint [name]` which marks the Terraform-managed resource as tainted and forces `terraform plan` to recreate/provision infrastructure
* One can also use untaint `terraform untaint [resource-name]`
* `terraform graph`; use `terraform graph --help` to checkout the docs
* `terraform refresh` -- The terraform refresh command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure. This can be used to detect any drift from the last-known state, and to update the state file. This does not modify infrastructure, but does modify the state file.
* `terraform fmt` -- To format .tf files
* `terraform import` --Terraform is able to import existing infrastructure. This allows you take resources you've created by some other means and bring it under Terraform management. Ex - `terraform import aws_instance.example [instance-id]`
* 