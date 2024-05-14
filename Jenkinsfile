pipeline {
    agent any

    tools {
        maven 'Maven3'  
        jdk 'Java11'   
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm  
            }
        }

        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }

        stage('PMD') {
            steps {
                sh 'mvn pmd:pmd'
            }
        }

        stage('Generate Test Reports') {
            steps {
                sh 'mvn surefire-report:report'
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sshPublisher(
                        publishers: [
                            sshPublisherDesc(
                                configName: "my-ssh-server",
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: "**/*.war",
                                        removePrefix: "target",
                                        remoteDirectory: "deployments"
                                    )
                                ]
                            )
                        ]
                    )
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/target/site/**', fingerprint: true
            archiveArtifacts artifacts: '**/target/**/*.jar', fingerprint: true
            archiveArtifacts artifacts: '**/target/**/*.war', fingerprint: true
            junit 'target/surefire-reports/*.xml'  // 收集 JUnit 测试报告，需要测试执行步骤生成这些文件
        }
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}
