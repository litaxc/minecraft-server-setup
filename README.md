## Usage

### setup server
1. Fill proper value in `terraform.tfvars` for AWS resources provisioning.
1. Execute command for provisioning EC2 instance `terraform apply --var-file=terraform.tfvars`
    - the instace type I use was t4g.micro, the cost for running a full month is roughly 6-8 USD
1. Fill proper value in `playbook_vars.yaml` for deploying Minecraft server application.
1. Execute command for deploying Minecraft server `ansible-playbook -i inventory.yaml playbook.yaml`
1. That's it.

### teardown server
1. Run `terraform destroy` and most the AWS resouces except for EBS will be deleted.  
 To avoid the world and its backup being deleted as well.
