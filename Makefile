dev-apply:
	git pull
	rm -f .terraform/terraform.tfstate
	terraform init -backend-config=environments/dev/state.tfvars
	terraform apply -auto-approve -var-file=environments/dev/main.tfvars
	## User name and password should not be hardcoded, Here we just hardcorded because to avoid the passing of input. this need to be passed as input in the real time.

dev-destroy:
	git pull
	rm -f .terraform/terraform.tfstate
	terraform init -backend-config=environments/dev/state.tfvars
	terraform destroy -auto-approve -var-file=environments/dev/main.tfvars
	## User name and password should not be hardcoded, Here we just hardcorded because to avoid the passing of input. this need to be passed as input in the real time.

