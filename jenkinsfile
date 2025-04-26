pipeline {
    agent any

    environment {
        VAULT_ADDR = 'http://192.168.1.199:32001/' // Vault URL (adjust if needed)
    }

    stages {
        stage('Clone Repo') {
            agent {
                kubernetes {
                    label 'git-clone-agent'
                    defaultContainer 'git'
                    yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: git
    image: alpine/git
    command: ["cat"]
    tty: true
"""
                }
            }
            steps {
                container('git') {
                    git branch: 'main', url: 'https://github.com/HamdiNOURI/IacAzure.git'
                }
            }
        }

        stage('Terraform Init & Plan') {
            agent {
                kubernetes {
                    label 'terraform-agent'
                    defaultContainer 'terraform'
                    yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: terraform
    image: hashicorp/terraform:1.6.6
    command: ["cat"]
    tty: true
  - name: azure-cli
    image: mcr.microsoft.com/azure-cli
    command: ["cat"]
    tty: true
"""
                }
            }
            steps {
                withVault([vaultSecrets: [[
                    path: 'secret/data/azure/creds',
                    engineVersion: 2,
                    secretValues: [
                        [envVar: 'ARM_CLIENT_ID',       vaultKey: 'client_id'],
                        [envVar: 'ARM_CLIENT_SECRET',   vaultKey: 'client_secret'],
                        [envVar: 'ARM_SUBSCRIPTION_ID', vaultKey: 'subscription_id'],
                        [envVar: 'ARM_TENANT_ID',       vaultKey: 'tenant_id']
                    ]
                ]]]) {
                    container('terraform') {
                        sh '''
                            terraform init
                            terraform validate
                            terraform plan -out=tfplan
                        '''
                    }
                }
            }
        }

        // Optional: Terraform apply stage (can uncomment later)
        /*
        stage('Terraform Apply') {
            agent {
                kubernetes {
                    label 'terraform-agent'
                    defaultContainer 'terraform'
                    yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: terraform
    image: hashicorp/terraform:1.6.6
    command: ["cat"]
    tty: true
  - name: azure-cli
    image: mcr.microsoft.com/azure-cli
    command: ["cat"]
    tty: true
"""
                }
            }
            steps {
                withVault([vaultSecrets: [[
                    path: 'secret/data/azure/creds',
                    engineVersion: 2,
                    secretValues: [
                        [envVar: 'ARM_CLIENT_ID',       vaultKey: 'client_id'],
                        [envVar: 'ARM_CLIENT_SECRET',   vaultKey: 'client_secret'],
                        [envVar: 'ARM_SUBSCRIPTION_ID', vaultKey: 'subscription_id'],
                        [envVar: 'ARM_TENANT_ID',       vaultKey: 'tenant_id']
                    ]
                ]]]) {
                    container('terraform') {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
        */
    }

    post {
        always {
            echo "✅ Pipeline complete."
        }
    }
}
