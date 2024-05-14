pipeline {
agent any
stages {
stage('Build') {
steps {
sh 'mvn -B -DskipTests clean package'
}
}
stage('pmd') {
steps {
sh 'mvn pmd:pmd'
}
}
}
post {
always {
archiveArtifacts artifacts: '**/target/site/**', fingerprint: true
archiveArtifacts artifacts: '**/target/**/*.jar', fingerprint: true
archiveArtifacts artifacts: '**/target/**/*.war', fingerprint: true
}
}
  stage('Deploy') {
        steps {
            script {
                sshPublisher(
                    publishers: [sshPublisherDesc(
                        configName: "my-ssh-server",
                        transfers: [sshTransfer(
                            sourceFiles: "**/*.war",
                            removePrefix: "target",
                            remoteDirectory: "deployments"
                        )]
                    )]
                )
            }
        }
}

