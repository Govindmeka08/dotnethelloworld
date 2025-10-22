# Azure DevOps Engineer Assignment

## Scenario

You are tasked with setting up CI/CD in Azure DevOps for a simple .NET 9 Hello World Web API application that lives in this repository. 
You must provision Azure infrastructure and deploy this app to Azure App Service using IaC (Choice of language is yours but not Azure ARM templates).

The goal is to demonstrate your ability to:
- Build a .NET 9 application.
- Use Infrastructure as Code (IaC) to provision cloud resources.
- Deploy the application to Azure App Service using an Azure DevOps pipeline.

---

## Application Repo

This repository contains a simple .NET 9 Web API that returns "Hello World" at the root endpoint. You will use this app for your CI/CD pipeline.
---

## Tasks (What you must deliver)

1) Infrastructure as Code (IaC)
- Author Bicep or Terraform or any other language but not ARM templates to provision:
  - A Resource Group (if not provided).
  - An Azure App Service Plan (Linux; Free F1 or Basic B1).
  - An Azure Web App (Linux) configured for .NET 9.

2) Build Pipeline (CI) — Azure DevOps YAML
- Create azure-pipelines.yml at the repo root that:
  - Triggers on pushes and PRs to main.
  - Restores dependencies.
  - Builds the .NET 9 project in Release.
  - Publishes a deployable build artifact (e.g., zipped folder or publish output).

3) Release Pipeline (CD)
- In the same YAML (multi-stage) or a following stage:
  - Deploy the build artifact to the App Service created by your IaC.
  - Use an Azure Resource Manager service connection (created in Azure DevOps).
  - Use Azure Web App Deploy (zip deploy) or az webapp deploy.

4) Documentation (Update this README)
- Document:
  - How to deploy your IaC (exact commands you used).
  - How your pipeline is structured (stages and key tasks).
  - The URL of your deployed app.

---



## What to Submit

- Repository containing:
  - IaC code (Bicep or Terraform or other).
  - azure-pipelines.yml at the repo root.
  - Working app service URL after deployment.

---

This project demonstrates how to setup a CI/CD pipeline using Azure Devops pipeline to deploy a .NET 9 Web API ('HelloApi')

# Infrastructure as a code using bicep
#provisioned:
- Azure App Service Plan (Linux, B1 tier)
- Azure Web App configured for .Net 9

so the bicep file is located at the root repo provisioning the above resources

## command to deploy
 ''' bash
 az deployment group create \
  --resource-group resource-group-name \
  --template-file main.bicep
  --parameters \ 
    appServicePlanName="helloappserviceplan" \
    webAppName="hello-dotnet9-webapp"

## deployment pipeline
since no azure subscription was not there this deployment won't be executed but if it is created we can execute it.

azure-pipelines.yaml is placed at the root which will run on every push to the main branch

we have multiple stages represnting the pipeline flow
Build stage:
- INSTALL .NET 9 SDK
- Restores NuGet dependencies
- Builds the project in Release mode
- publishes a zipped artifact (drop/)

Deploy stage:
- Deploys the build artifact to Azure App Service
- uses the AzureWebApp@1 task to deploy the .zip 


#service connection is (expected)
azureSubscription: 'AzureSP-Devops'
this can be created in azure
under AzureDevops -> Project Settings -> Service Connections -> Azure ResourceManager

#Expected Application URL
https://hello-dotnet9-webapp.azurewebsites.net
