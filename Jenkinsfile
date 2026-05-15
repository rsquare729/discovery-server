pipeline {
    agent any

    tools {
        maven 'Maven-3'
    }

    environment {
        PATH = "/usr/local/bin:${env.PATH}"
        IMAGE_NAME = "rrdocker729/discovery-server:v1"
    }

    stages {

        stage('Build JAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Docker Login') {
		    steps {
		        withCredentials([usernamePassword(
		            credentialsId: 'dockerhub-creds',
		            usernameVariable: 'DOCKER_USER',
		            passwordVariable: 'DOCKER_PASS'
		        )]) {
		
		            sh """
		            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
		            """
		        }
		    }
		}

        stage('Push Docker Image') {
            steps {
                sh 'docker push $IMAGE_NAME'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f discovery-server-container || true

                docker run -d -p 8761:8761 \
                --name discovery-server-container \
                $IMAGE_NAME
                '''
            }
        }
    }
}