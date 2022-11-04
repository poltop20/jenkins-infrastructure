def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]


pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'cloning codebase...'
                git branch: 'main', url: 'https://github.com/poltop20/jenkins-infrastructure.git'
                sh 'ls'
            }
        }
        
        stage('verify terraform version') {
            steps {
                echo 'verifying terraform version....'
                sh 'terraform --version'
            }
        }
       
        stage('initializing terraform') {
            steps {
                echo 'initaializing'
                sh 'terraform init'
            }
        }
        
        stage('terraform validate') {
            steps {
                echo 'validating codebase'
                sh 'terraform validate'
            }
        }
        
        stage('terraform plan') {
            steps {
                echo 'planning dryrun'
                sh 'terraform plan'
            }
        }
        
        stage('checkov scan') {
            steps {
                
                sh """
                sudo pip3 install checkov
                checkov -d . --skip-check CKV_AWS_79
                """
                
            }
        }
        
        
        stage('manual approval') {
            steps {
                echo 'approving dryrun'
                input 'Approval required for deployment'
                
            }
        }
        stage('terraform apply') {
            steps {
                echo 'applying dryrun'
                sh 'sudo terraform apply --auto-approve'
            }
        }
        
    }
     
     
     post { 
        always { 
            echo 'God dey!'
            slackSend channel: '#glorious-w-f-devops-alerts',color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"

        }
    }
}
