pipeline {
    agent any
    tools {
        nodejs "NodeJS-12-6"
    }
    stages {
        stage('Compile') {
            agent any
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Unit Testing') {
            agent any
            steps {
                sh 'npm test'
            }
        }
        stage('Deploy') {
            parallel {
                stage('Deploy') {
                    steps {
                        sh 'sudo npm start &'
                    }
                }
                stage('Archive Artifacts') {
                    steps {
                        archiveArtifacts '**/public/assets/**'
                    }
                }
            }
        }
        stage('Integration testing') {
            steps {
                sleep 10
                sh 'sudo curl localhost'
            }
        }
    }
}