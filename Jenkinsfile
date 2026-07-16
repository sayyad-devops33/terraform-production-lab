pipeline {

    agent any
	parameters {
    choice(
        name: 'ENVIRONMENT',
        choices: ['dev', 'test', 'prod'],
        description: 'Select the environment to deploy'
    )
  }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Repository checked out successfully.'
            }
        }


        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Init') {
            steps {
                sh "terraform init -no-color -reconfigure -backend-config=backend/${params.ENVIRONMENT}.hcl"
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate -no-color'
            }
        }

        stage('Terraform Plan') {
            steps {
		sh "terraform plan -no-color -var-file=terraform/${params.ENVIRONMENT}.tfvars -out=tfplan"
            }
        }

        stage('Archive Plan') {
            steps {
                archiveArtifacts artifacts: 'tfplan', fingerprint: true
            }
        }

	stage('Manual Approval') {
         when {
        expression {
            params.ENVIRONMENT == 'prod'
        }
    }
    steps {
        input message: 'Do you want to apply this Terraform plan?', ok: 'Apply'
    }
}
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -no-color tfplan'
            }
        }

    }
}
