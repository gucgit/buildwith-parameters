pipeline {
    agent any

    parameters {
        choice(
            name: 'AWS_REGION',
            choices: [
                'Mumbai (ap-south-1)', 
                'N. Virginia (us-east-1)', 
                'Oregon (us-west-2)', 
                'Frankfurt (eu-central-1)', 
                'Tokyo (ap-northeast-1)',
                'Singapore (ap-southeast-1)',
                'Sydney (ap-southeast-2)',
                'Ireland (eu-west-1)',
                'Canada (ca-central-1)',
                'São Paulo (sa-east-1)'
            ],
            description: 'Select the AWS region (city + code)'
        )
    }

    environment {
        // Extract only the region code (inside parentheses)
        AWS_DEFAULT_REGION = "${params.AWS_REGION.split('\\(')[1].replace(')', '')}"
    }

    stages {
        stage('Init') {
            steps {
                script {
                    echo "Selected AWS Region: ${params.AWS_REGION}"
                    echo "Region code extracted: ${AWS_DEFAULT_REGION}"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh """
                terraform init \
                  -backend-config="region=${AWS_DEFAULT_REGION}" \
                  -backend-config="bucket=guc-vpc" \
                  -backend-config="dynamodb_table=terraform-locks" \
                  -backend-config="key=terraform/state.tfstate"
                """
            }
        }

        stage('Terraform Plan') {
            steps {
                sh """
                terraform plan \
                  -var="aws_region=${AWS_DEFAULT_REGION}"
                """
            }
        }

        stage('Terraform Apply') {
            steps {
                sh """
                terraform apply -auto-approve \
                  -var="aws_region=${AWS_DEFAULT_REGION}"
                """
            }
        }
    }
}
