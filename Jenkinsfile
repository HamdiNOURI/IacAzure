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
    - name: jnlp
      image: jenkins/inbound-agent:latest
      args: ['\$(JENKINS_SECRET)', '\$(JENKINS_NAME)']
"""
        }
    }

    environment {
        VAULT_ADDR = 'http://192.168.1.199:32001/'
    }

    stages {
        stage('Terraform Version') {
            steps {
                container('terraform') {
                    sh 'terraform version'
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
