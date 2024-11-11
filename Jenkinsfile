pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'simplejavaapp'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/anuragh28/SimpleJavaApp.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Dockerize') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:latest ."
            }
        }

        stage('Run Docker Container') {
            steps {
                // Running the application on host port 8081 to avoid Jenkins conflict on port 8080
                sh "docker run -d --name ${DOCKER_IMAGE} -p 8081:8080 ${DOCKER_IMAGE}:latest"
            }
        }
    }

    post {
        always {
            // Cleanup the container and image after pipeline run
            sh "docker rm -f ${DOCKER_IMAGE} || true"
            sh "docker rmi ${DOCKER_IMAGE}:latest || true"
        }
    }
}
