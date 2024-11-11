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
                bat 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run Maven tests
                bat 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build a Docker image using Dockerfile
                    bat "docker build -t %DOCKER_IMAGE%:%BUILD_NUMBER% ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker_hub_credentials_id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                    }
                    // Push Docker image to Docker Hub
                    bat "docker push %DOCKER_IMAGE%:%BUILD_NUMBER%"
                }
            }
        }

        stage('Cleanup') {
            steps {
                // Clean up Docker images after the build and push
                bat "docker rmi %DOCKER_IMAGE%:%BUILD_NUMBER%"
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
