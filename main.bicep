@description('Location for resources')
param location string = resourceGroup().location

@description('App Service Plan name')
param appServicePlanName string = 'helloappserviceplan'

@description('Web App name')
param webAppName string = 'hello-dotnet9-webapp'


// App service 

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
    name: appServicePlanName
    location: location
    sku: {
        name: 'B1'
        tier: 'Basic'
    }
    kind: 'linux'
    properties: {
        reserved: true
    }
}

// web app

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
    name: webAppName
    location: location
    kind: 'app,linux'
    properties: {
        serverFarmId: appServicePlan.id 
        siteConfig: {
            linuxFxVersion: 'DOTNET|9.0'
            alwaysOn: false
        }
        httpsOnly: true
    }
}