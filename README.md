Keycloak Test Example

- How to use:
1. Create azure infrastracture
  - FIRST and before all create azure cloud storage for terraform state file:
     Go to Github Actions, choose workflow Terraform Azure Infrastructure,
     Run Workflow, Choose the resources: ./terraform/modules/tfstate then,
     from Terraform Action To Perform, choose Terraform Apply. It creates
     tfstate storage
   - Create Infrastructure (vm, network...)
     Go to Github Actions, choose workflow Terraform Azure Infrastructure,
     Run Workflow, Choose the resources: ./terraform/modules/infrastructure then,
     from Terraform Action To Perform, choose Terraform Apply.

2. Deploy Keycloak, nginx and apache(as a client)
    - Go to Github Actions, choose workflow, Run Workflow: Deploy Keycloak, Nginx and Apache
      might take a while when keycloak sets up. waiting is not implemented in ansible right now.

3. Configure keycloak for client auth
   -  Go to Github Actions, choose workflow, Run Workflow: Configure keycloak for client auth

Now you should be able to authenticate via keycloak to get some static page.
go to link: http://keycloak-hylastix.uksouth.cloudapp.azure.com:180
after few ssl confirmations you should get keycloack page for login.
Credentials are: 
username: hylastix
password: hylastix
Also, you can access keycloak admin page via http://keycloak-hylastix.uksouth.cloudapp.azure.com
Credentials are here somewhere in this github repository.

     
  
