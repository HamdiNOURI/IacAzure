pipeline {
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
      command: [ "cat" ]
      tty: true
    - name: git
      image: alpine/git
      command: [ "cat" ]
      tty: true
    - name: azure-cli
      image: mcr.microsoft.com/azure-cli
      command: [ "cat" ]
      tty: true
"""
        }
    }

    environment {
        VAULT_ADDR = 'http://192.168.1.199:32001/' // HashiCorp Vault address
    }

    stages {
        stage('Clone Repo') {
            steps {
                container('git') {
                    git branch: 'master', url: 'https://github.com/HamdiNOURI/IacAzure.git'
                }
            }
        }

        stage('Terraform Version') {
            steps {
                container('terraform') {
                    sh '''
                        terraform version
                        # terraform init
                        # terraform validate
                        # terraform plan -out=tfplan
                    '''
                }
            }
        }
    }

    post {
        always {
            echo "✅ Pipeline complete."
        }
    }
}
