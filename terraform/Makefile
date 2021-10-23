-include .env

init:
	terraform init -backend-config="key=frontend/$(ENVIRONMENT)/state"
apply:
	terraform apply -auto-approve
