  pipeline {
    agent any
    environment {
    AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    TERRAFORM_HOME = tool name: 'terraform_1.0.5', type: 'terraform'
    PROVIDER = "aws"
    ENV = "dev"
    APP_MODULE = "cloud_formation"
  }
    stages {
      stage("TF  Version") { 
        steps { 
          sh "${TERRAFORM_HOME}/terraform -v"
        }
      }
      stage('Init & Plan: VPC') {
        environment { 
            MODULE = "vpc"
        }
        steps {
          sh "bash ./scripts/init_and_plan.sh"   
        }      
      }
      stage('Approval: VPC') {
        steps {
          script {
            def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
          }
        }
      }
      stage('Apply: VPC') {
        environment { 
            MODULE = "vpc"
        }
        steps {
          sh "bash ./scripts/apply.sh"   
        }      
      }
      stage('Init & Plan: App') {
        environment { 
            MODULE = "${APP_MODULE}"
        }
        steps {
          sh "bash ./scripts/init_and_plan.sh"   
        }      
      }
      stage('Approval: App') {
        steps {
          script {
            def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
          }
        }
      }
      stage('Apply: App') {
        environment { 
            MODULE = "${APP_MODULE}"
        }
        steps {
          sh "bash ./scripts/apply.sh"   
        }      
      }
  }
  }
