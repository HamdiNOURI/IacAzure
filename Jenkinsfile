podTemplate(
  agentInjection: true,
  containers: [
    containerTemplate(
      name: 'terraform',
      image: 'hashicorp/terraform:1.10.0',
      command: 'cat',
      ttyEnabled: true
    ),
      containerTemplate(
      name: 'git',
      image: 'alpine/git',
      command: 'cat',
      ttyEnabled: true
    )
  ]
) {
  node(POD_LABEL) {
    // Set environment variable at the node level (Groovy style)
    env.VAULT_ADDR = 'http://192.168.1.199:32001/'
    stage('Git Version') {
      container('git') {
        git branch: 'master', url: 'https://github.com/HamdiNOURI/IacAzure.git'
        sh 'ls -l'
      }
    }
    stage('Terraform Version') {
      container('terraform') {
        sh 'terraform version'
        //sh 'hostname'
        echo "Vault address is: ${env.VAULT_ADDR}"
      }
    }
   
    stage('Plan') {
      container('terraform') {
        withVault([
          vaultSecrets: [[
            path: 'secret/esxi',
            engineVersion: 2,
            secretValues: [
              [envVar: 'ARM_USER',       vaultKey: 'user'],
              [envVar: 'ARM_PASSWORD',   vaultKey: 'password']
            ]
          ]]
        ]) {
            sh'''
              cd VmOnPerm\
              terraform init
              terraform plan
          '''
        }
      }
    }
    post {
        always {
            echo "✅ Pipeline complete."
        }
    }
  }
}