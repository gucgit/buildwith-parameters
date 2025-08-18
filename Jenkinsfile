pipeline {
    agent any

    parameters {
        choice(
            name: 'AWS_REGION',
            choices: [
                'ap-south-1',     // Mumbai (default)
                'ap-southeast-1', // Singapore
                'ap-southeast-2', // Sydney
                'ap-northeast-1', // Tokyo
                'ap-northeast-2', // Seoul
                'ap-northeast-3', // Osaka
                'us-east-1',      // N. Virginia
                'us-east-2',      // Ohio
                'us-west-1',      // N. California
                'us-west-2',      // Oregon
                'eu-central-1',   // Frankfurt
                'eu-west-1',      // Ireland
                'eu-west-2',      // London
                'eu-west-3'       // Paris
            ],
            description: 'Select AWS region to deploy infrastructure',
            defaultValue: 'ap-south-1'
        )
    }

    environment {
        TF_VAR_aws_region = "${params.AWS_REGION ?: 'ap-south-1'}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/gucgit/buildwith-parameters.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'awscredentials'
                ]]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'awscredentials'
                ]]) {
                    sh "terraform plan -var aws_region=${TF_VAR_aws_region}"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'awscredentials'
                ]]) {
                    sh "terraform apply -auto-approve -var aws_region=${TF_VAR_aws_region}"
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.AWS_REGION != null }
            }
            steps {
                input message: "Do you want to destroy resources in ${TF_VAR_aws_region}?"
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'awscredentials'
                ]]) {
                    sh "terraform destroy -auto-approve -var aws_region=${TF_VAR_aws_region}"
                }
            }
        }
    }
}

