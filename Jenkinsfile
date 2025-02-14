pipeline {
    agent any

    environment {
        IMAGE_NAME = "stark303/k8-app"
        TAG = "latest"
        KUBE_DEPLOYMENT = "k8-app"
        NAMESPACE = "default"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Patilx97/k8-task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER .'
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker push $IMAGE_NAME:$BUILD_NUMBER'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl set image deployment/$KUBE_DEPLOYMENT k8-app=$IMAGE_NAME:$BUILD_NUMBER --namespace=$NAMESPACE
                '''
            }
        }
    }
}
