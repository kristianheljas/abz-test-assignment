# ABZ Agency test assignment

This is test assignment project for ABZ Agency DevOps position.

## Prequisites

1. Terraform
1. Python 3
1. AWS CLI
1. Hosted zone in Route53 (see `dns_zone_name` and `dns_name` variables in `terraform/vars.tf`)
1. SSH agent (see `default_ssh_key` variable in `terraform/vars.tf`)

To configure AWS CLI, create IAM user (using AWS CloudShell for example):

```shell
aws iam create-user --user-name terraform
aws iam attach-user-policy --user-name terraform --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam create-access-key --user-name terraform
```

Then, on your local machine, configure AWS CLI with credentials from previous step

```shell
aws configure --profile abz-test-assignment
```

## Provisioning

```shell
# Install dependencies and provision infrastructure
terraform init
terraform apply

# Install ansible & dependencies within venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
ansible-galaxy install -r ansible/requirements.yml

# Configure using ansible
ansible-playbook ansible/playbooks/wordpress.yml
```
