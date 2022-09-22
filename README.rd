
#Steps to Run
1. Install terraform
2. Setup aws credentials in local (~/.aws/credentials
3. terraform init
4. Run terraform plan ( terraform plan-var-file="<tfvars-file")
5. Finally terraform apply( terraform apply -var-file="tfvars-file")

Example:
         terraform apply -var-file="dev.tfvars"

