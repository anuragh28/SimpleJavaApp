pipeline {
    agent any

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
                sh 'docker build -t simplejavaapp:latest .'
            }
        }

        stage('Run') {
            steps {
                sh 'docker run -d --name simplejavaapp simplejavaapp:latest'
            }
        }
    }

    post {
        always {
            sh 'docker rm -f simplejavaapp || true'
            sh 'docker rmi simplejavaapp:latest || true'
        }
    }
}
