pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_credentials') // 使用你在 Jenkins 中配置的 Docker Hub 凭据
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/DreamOK2333/Teedy.git' // 替换为你的 GitHub 仓库 URL
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package' // 使用 Maven 构建项目
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("dreamok2333/teedywork:latest")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Run Containers') {
            steps {
                script {
                    sh 'docker run -d -p 8082:8080 dreamok2333/teedywork:latest'
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
