Keycloak Test Example that runs on Microsoft Azure

- How to use:
  
1. **Create azure infrastracture**
  - **FIRST** and before all create azure cloud storage for terraform state file:<br />
     Go to Github Actions, choose workflow **_Terraform Azure Infrastructure_**,<br />
     **_Run Workflow_**, **_Choose the resources_**: **_./terraform/modules/tfstate_** then,<br />
     from **_Terraform Action To Perform_**, choose **_Terraform Apply_**. It creates<br />
     tfstate storage<br />
   - Create Infrastructure (vm, network...)<br />
     Go to Github Actions, choose workflow **_Terraform Azure Infrastructure_**,<br />
     **_Run Workflow_**, **_Choose the resources_**: **_./terraform/modules/infrastructure_** then,<br />
     from **_Terraform Action To Perform_**, choose **_Terraform Apply_**.<br />

2. **Deploy Keycloak, nginx and apache(as a client)**<br />
    - Go to Github Actions, choose workflow, **_Run Workflow_**: **_Deploy Keycloak, Nginx and Apache_**<br />
      might take a while when keycloak sets up. waiting is not implemented in ansible right now.<br />

3. **Configure keycloak for client auth**<br />
   -  Go to Github Actions, choose workflow, **_Run Workflow_**: **_Configure keycloak for client auth_**<br />

Now you should be able to authenticate via keycloak to get some static page.<br />
go to link: http://keycloak-hylastix.uksouth.cloudapp.azure.com:180<br />
after few ssl confirmations you should get keycloack page for login.<br />
Credentials are: <br />
_username: hylastix_<br />
_password: hylastix_<br />
Also, you can access keycloak admin page via http://keycloak-hylastix.uksouth.cloudapp.azure.com<br />
Credentials are here somewhere in this github repository.<br />

     
  
