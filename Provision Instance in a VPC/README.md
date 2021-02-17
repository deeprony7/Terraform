# Provisioning an EC2 Instance running Apache in a VPC with multiple subnets

For ease of use you can use AWS Cloudshell or create a Cloud9 env

Install Terraform as per instructions on <https://learn.hashicorp.com/tutorials/terraform/install-cli>

Install yum-config-manager to manage your repositories.

```bash
sudo yum install -y yum-utils
```

Use yum-config-manager to add the official HashiCorp Linux repository.

``` bash
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
```

Install.

```bash
sudo yum -y install terraform
```

In main.tf the provider section at the top dictates which Cloud Provider to use


Here we are building most of the stuff from scratch, starting with VPC, Route Table, Subnets, Network Interface, Elastic IP and finally the Instance itself which will host apache.

Since HCL is declarative language the order of statements is not as important but in some cases terraform cannot resolve dependencies so as best practice we will try to keep our statements as much in order as possible.

The general pattern to these statements are:

```HCL
resource "<provider>_<resource_type>" "name" {
  config options...
  key = "value"
  key2 = "another value"
}
```

More info: <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources>

Execute steps below execute the code:

1. Replace _access_key_ and _secret_key_ parameters in provider section
2. Run `terraform init` in the directory you have saved main.tf in
3. Run `terraform plan` to check out the changes Terraform will make
4. Run `terraform apply` to actually have terrafrom well, infrastructure terraform :)

If you have any syntactical errors `terraform plan` will tell you

Run `terraform destroy` to bring down the all the changes `terraform apply` brought in.

To destroy a specific resource `terraform destroy -target RESOURCE_TYPE.NAME -target RESOURCE_TYPE2.NAME`