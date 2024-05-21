pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/DreamOK2333/Teedy.git' 
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("your-dockerhub-username/your-repo-name:latest")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Run Containers') {
            steps {
                script {
                    sh 'docker run -d -p 8082:8080 your-dockerhub-username/your-repo-name:latest'
                    sh 'docker run -d -p 8083:8080 your-dockerhub-username/your-repo-name:latest'
                    sh 'docker run -d -p 8084:8080 your-dockerhub-username/your-repo-name:latest'
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            sh 'docker system prune -f'
        }
    }
}
