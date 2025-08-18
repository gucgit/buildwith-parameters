pipeline {
    agent any

    parameters {
        choice(
            name: 'AWS_REGION',
            choices: ['ap-south-1', 'us-east-1', 'us-west-2'],
            description: 'Select the AWS region to deploy resources'
        )
        string(
            name: 'ENV',
            defaultValue: 'dev',
            description: 'Environment name (dev/test/prod)'
        )
    }

    environment {
        AWS_DEFAULT_REGION = "${params.AWS_REGION}"
    }

    stages {
        stage('Init') {
            steps {
                script {
                    echo "Selected AWS Region: ${params.AWS_REGION}"
                    echo "Environment: ${params.ENV}"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh """
                terraform init \
                  -backend-config="region=${params.AWS_REGION}" \
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
                  -var="aws_region=${params.AWS_REGION}" \
                  -var="env=${params.ENV}"
                """
            }
        }

        stage('Terraform Apply') {
            steps {
                sh """
                terraform apply -auto-approve \
                  -var="aws_region=${params.AWS_REGION}" \
                  -var="env=${params.ENV}"
                """
            }
        }
    }
}
