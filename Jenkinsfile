pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/DreamOK2333/Teedy.git' // 你的 Git 仓库 URL
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("dreamok2333/teedywork:latest") // 你的 Docker Hub 用户名和仓库名
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub_credentials') { // 使用之前创建的凭据 ID
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Run Containers') {
            steps {
                script {
                    sh 'docker run -d -p 8082:8080 dreamok2333/teedywork:latest' // 替换为你的 Docker Hub 用户名和仓库名
                    sh 'docker run -d -p 8083:8080 dreamok2333/teedywork:latest'
                    sh 'docker run -d -p 8084:8080 dreamok2333/teedywork:latest'
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
