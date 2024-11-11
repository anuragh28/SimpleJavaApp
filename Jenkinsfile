pipeline {
    agent any

    environment {
        // Define environment variables, e.g., Docker Hub repository
        DOCKER_IMAGE = "anurag3028/simplejavaapp"
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull the code from the GitHub repository
                git url: 'https://github.com/anuragh28/SimpleJavaApp.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                // Run Maven to build the Java application
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run Maven tests
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build a Docker image using Dockerfile
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker_hub_credentials_id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    }
                    // Push Docker image to Docker Hub
                    sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                }
            }
        }

        stage('Cleanup') {
            steps {
                // Clean up Docker images after the build and push
                sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER}"
            }
        }
    }

    post {
        success {
            echo 'Build, Test, and Dockerize stages completed successfully!'
        }
        failure {
            echo 'Build, Test, or Dockerize stages failed.'
        }
    }
}
