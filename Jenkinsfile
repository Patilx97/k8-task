pipeline {
    agent any

    environment {
        IMAGE_NAME = "stark303/k8-app"
        BUILD_TAG = "${BUILD_NUMBER}"  // Jenkins build number as tag
        LATEST_TAG = "latest"
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
                sh """
                echo "Building Docker image..."
                docker build -t $IMAGE_NAME:$BUILD_TAG .
                docker tag $IMAGE_NAME:$BUILD_TAG $IMAGE_NAME:$LATEST_TAG
                """
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh """
                    echo "Pushing Docker image..."
                    docker push $IMAGE_NAME:$BUILD_TAG
                    docker push $IMAGE_NAME:$LATEST_TAG
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                echo "Deploying to Kubernetes..."
                kubectl set image deployment/$KUBE_DEPLOYMENT k8-app=$IMAGE_NAME:$LATEST_TAG --namespace=$NAMESPACE
                """
            }
        }
    }
}
