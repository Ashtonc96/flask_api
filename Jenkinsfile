pipeline {
    agent {
        label 'master'
    }

    environment {
        PRODUCT = 'flask_api'
        registry = 'ashtonc96/flask_api'
        registryCredential = 'docker-creds'
    }

    stages {
        // Checkout the right branch
        stage("Env Build Number"){
            steps{
                echo "The build number is ${env.BUILD_NUMBER}"
            }
        }

        stage('Checkout') {
            steps {
                script {
                    git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/Ashtonc96/flask_api'
                }
            }
        }
        // Build a container with the code source of the application
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":${env.BUILD_NUMBER}"
                }
            }
        }
        //Deploy the Docker image to DockerHub
        stage('Deploy image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                    echo "docker rmi ${env.registry}:${env.BUILD_NUMBER}"
                }
            }
        }
        stage('Remove unused docker image') {
            steps{
                script{
                    sh "docker rmi ${env.registry}:${env.BUILD_NUMBER}"
                }
            }
        }
    }
}