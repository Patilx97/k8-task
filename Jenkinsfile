pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "stark303/k8-app"
        LATEST_TAG = "latest"
        BUILD_TAG = "${env.BUILD_NUMBER}"  // Jenkins build number as tag
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE:$BUILD_TAG ."
                sh "docker tag $DOCKER_IMAGE:$BUILD_TAG $DOCKER_IMAGE:$LATEST_TAG"
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh "docker push $DOCKER_IMAGE:$BUILD_TAG"
                    sh "docker push $DOCKER_IMAGE:$LATEST_TAG"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl set image deployment/k8-app k8-app=$DOCKER_IMAGE:$LATEST_TAG --namespace=default"
            }
        }
    }
}
