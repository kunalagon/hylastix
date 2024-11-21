Keycloak Test Example that runs on Microsoft Azure

- How to use:
  
1. **Create azure infrastracture**
  - **FIRST** and before all create azure cloud storage for terraform state file:__
     Go to Github Actions, choose workflow **_Terraform Azure Infrastructure_**,__
     **_Run Workflow_**, **_Choose the resources_**: **_./terraform/modules/tfstate_** then,__
     from **_Terraform Action To Perform_**, choose **_Terraform Apply_**. It creates__
     tfstate storage__
   - Create Infrastructure (vm, network...)__
     Go to Github Actions, choose workflow **_Terraform Azure Infrastructure_**,__
     **_Run Workflow_**, **_Choose the resources_**: **_./terraform/modules/infrastructure_** then,__
     from **_Terraform Action To Perform_**, choose **_Terraform Apply_**.__

2. **Deploy Keycloak, nginx and apache(as a client)**__
    - Go to Github Actions, choose workflow, **_Run Workflow_**: **_Deploy Keycloak, Nginx and Apache_**__
      might take a while when keycloak sets up. waiting is not implemented in ansible right now.__

3. **Configure keycloak for client auth**__
   -  Go to Github Actions, choose workflow, **_Run Workflow_**: **_Configure keycloak for client auth_**__

Now you should be able to authenticate via keycloak to get some static page.__
go to link: http://keycloak-hylastix.uksouth.cloudapp.azure.com:180__
after few ssl confirmations you should get keycloack page for login.__
Credentials are: __
_username: hylastix___
_password: hylastix___
Also, you can access keycloak admin page via http://keycloak-hylastix.uksouth.cloudapp.azure.com__
Credentials are here somewhere in this github repository.__

     
  
