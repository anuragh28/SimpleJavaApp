pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "anurag3028/simplejavaapp" // Replace with your Docker Hub repository
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git branch: 'main', url: 'https://github.com/anuragh28/SimpleJavaApp.git'
            }
        }

        stage('Build') {
            steps {
                // Use Maven to build the application
                sh 'mvn clean package'
            }
        }

        stage('Dockerize') {
            steps {
                // Build Docker image with the packaged application JAR
                sh "docker build -t ${DOCKER_IMAGE}:latest ."
            }
        }

        stage('Push Docker Image') {
            when {
                branch 'main' // Push only when on the main branch
            }
            steps {
                // Log in to Docker Hub and push the image
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run the Docker container
                sh "docker run -d --name simplejavaapp -p 8081:8080 ${DOCKER_IMAGE}:latest"
            }
        }
    }

    post {
        always {
            // Clean up Docker container and image after the pipeline execution
            sh 'docker rm -f simplejavaapp || true'
            sh "docker rmi ${DOCKER_IMAGE}:latest || true"
            cleanWs()
        }
    }
}
