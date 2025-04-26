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
"""
        }
    }

    environment {
        VAULT_ADDR = 'http://192.168.1.199:32001/' // HashiCorp Vault address
    }

    stages {
        stage('Terraform Version') {
            steps {
                container('terraform') {
                    sh '''
                        terraform version
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
