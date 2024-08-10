pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "jefryalvonsius/helloworldapp"
        DOCKER_REGISTRY = "docker.io" // Docker Hub registry
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/jefryalvonsius/helloworldapp.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Dockerize') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                    withCredentials([string(credentialsId: 'dockerhub-pat', variable: 'DOCKER_PAT')]) {
                        sh 'echo $DOCKER_PAT | docker login -u jefryalvonsius --password-stdin'
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
