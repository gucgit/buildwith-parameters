pipeline {
    agent any

    environment {
        TF_VAR_region = "ap-south-1" // Terraform variable example
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
                    credentialsId: 'aws-credentials-id'
                ]]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id'
                ]]) {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials-id'
                ]]) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
