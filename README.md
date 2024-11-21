Keycloak Test Example that runs on Microsoft Azure

- How to use:
1. ##Create azure infrastracture
  - **FIRST** and before all create azure cloud storage for terraform state file:
     Go to Github Actions, choose workflow **_Terraform Azure Infrastructure_**,
     **_Run Workflow_**, **_Choose the resources_**: **_./terraform/modules/tfstate_** then,
     from **_Terraform Action To Perform_**, choose **_Terraform Apply_**. It creates
     tfstate storage
   - Create Infrastructure (vm, network...)
     Go to Github Actions, choose workflow **_Terraform Azure Infrastructure_**,
     **_Run Workflow_**, **_Choose the resources_**: **_./terraform/modules/infrastructure_** then,
     from **_Terraform Action To Perform_**, choose **_Terraform Apply_**.

2. ##Deploy Keycloak, nginx and apache(as a client)
    - Go to Github Actions, choose workflow, **_Run Workflow_**: **_Deploy Keycloak, Nginx and Apache_**
      might take a while when keycloak sets up. waiting is not implemented in ansible right now.

3. ##Configure keycloak for client auth
   -  Go to Github Actions, choose workflow, **_Run Workflow_**: **_Configure keycloak for client auth_**

Now you should be able to authenticate via keycloak to get some static page.
go to link: http://keycloak-hylastix.uksouth.cloudapp.azure.com:180
after few ssl confirmations you should get keycloack page for login.
Credentials are: 
_username: hylastix_
_password: hylastix_
Also, you can access keycloak admin page via http://keycloak-hylastix.uksouth.cloudapp.azure.com
Credentials are here somewhere in this github repository.

     
  
