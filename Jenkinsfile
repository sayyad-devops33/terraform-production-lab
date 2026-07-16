pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Repository checked out successfully.'
            }
        }

        stage('Create Terraform Variables') {
            steps {
                sh '''
cat > terraform.tfvars <<EOF
aws_region         = "ap-south-1"
vpc_cidr           = "10.20.0.0/16"
public_subnet_cidr = "10.20.1.0/24"
availability_zone  = "ap-south-1a"
vpc_name           = "production-vpc"
ami                = "ami-0f58b397bc5c1f2e8"
instance_type      = "t3.micro"
key_name           = "mykeypair"
EOF
'''
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -no-color'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate -no-color'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -no-color -out=tfplan'
            }
        }

        stage('Archive Plan') {
            steps {
                archiveArtifacts artifacts: 'tfplan', fingerprint: true
            }
        }

        stage('Manual Approval') {
            steps {
                input message: 'Do you want to apply this Terraform plan?', ok: 'Apply'
            }
        }

    }
}
