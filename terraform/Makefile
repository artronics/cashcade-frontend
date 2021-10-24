-include .env

init:
	terraform init -backend-config="key=frontend/$(ENVIRONMENT)/state"
plan:
	terraform plan
apply:
	terraform apply -auto-approve

deploy: init plan apply
