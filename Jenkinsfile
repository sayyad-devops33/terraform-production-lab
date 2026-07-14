pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
		echo 'Terraform CI Pipeline Started'
                echo 'Repository checked out successfully.'
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform init'
                sh 'terraform validate'
            }
        }

    }

}







