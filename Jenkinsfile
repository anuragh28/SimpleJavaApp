pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = 'docker_hub_credentials_id'
        DOCKER_IMAGE = '"anurag3028/simplejavaapp"'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/anuragh28/SimpleJavaApp.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                    echo "Docker image built: ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        dockerImage.push()
                        echo "Docker image pushed to Docker Hub: ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    echo "Attempting to remove Docker image: ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    try {
                        sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                        echo "Docker image ${DOCKER_IMAGE}:${BUILD_NUMBER} removed successfully."
                    } catch (Exception e) {
                        echo "Failed to remove Docker image: ${e}"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
