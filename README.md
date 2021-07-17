## Usage

### setup server
1. Fill proper value in `terraform.tfvars` for AWS resources provisioning.
1. Execute command for provisioning EC2 instance `terraform apply`
    - the instace type I use was t4g.small, the cost for running a full month is roughly 12-16 USD
1. Fill proper value in `group_vars/all.yaml` for deploying Minecraft server application.
1. Execute command for deploying Minecraft server `ansible-playbook -i inventory.yaml playbook.yaml`
    - you could add `--tags 'minecraft'` in case you only want to only run that part
1. That's it.

### teardown server
1. Run `terraform destroy` and all related AWS resouces will be deleted.
