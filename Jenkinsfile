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


        stage('Restore') {
            steps {
                dir('WebAppTerraformIntegrated') {
                    bat 'dotnet restore'
                }
            }
        }

        stage('Build') {
            steps {
                dir('WebAppTerraformIntegrated') {
                    bat 'dotnet build --configuration Release'
                }
            }
        }

        stage('Publish') {
            steps {
                dir('WebAppTerraformIntegrated') {
                    bat 'dotnet publish -c Release -o publish'
                }
            }
        }

       

        stage('Deploy') {
            steps {
                dir('WebAppTerraformIntegrated') {
               bat '''
                powershell Compress-Archive -Path WebApiJenkins\\publish\\* -DestinationPath publish.zip -Force
                az webapp deployment source config-zip --resource-group jenkins-palak-rg --name jenkins-palak-app123 --src publish.zip
                '''
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
