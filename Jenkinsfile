pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = 'azure-service-principal'
        RESOURCE_GROUP = 'rg-jenkins'
        APP_SERVICE_NAME = 'webapiIntegratedBrijesh001'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/brijeshprajapati53/Integrate-Terraform-with-Jenkins-Pipeline.git'
            }
        }

        stage('Run Terraform Script') {
            steps {
                dir('Terraform') {
                    bat 'terraform init'
                    bat 'terraform validate'
                    bat 'terraform plan -out=tfplan'
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Publish .NET 8 Web API') {
            steps {
                dir('WebAppTerraformIntegrated') {
                    bat 'dotnet restore'
                    bat 'dotnet build --configuration Release'
                    bat 'dotnet publish -c Release -o publish'
                }
            }
        }

        stage('Deploy to Azure App Service') {
            steps {
                dir('WebAppTerraformIntegrated') {
                    withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                        bat 'az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant %AZURE_TENANT_ID%'
                        bat 'powershell Compress-Archive -Path ./publish/* -DestinationPath ./publish.zip -Force'
                        bat 'az webapp deploy --resource-group %RESOURCE_GROUP% --name %APP_SERVICE_NAME% --src-path ./publish.zip --type zip'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo ' Deployment Failed! Check logs and troubleshoot.'
        }
    }
}
