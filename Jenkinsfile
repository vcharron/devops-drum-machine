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

        stage('Archive and Stash'){
            steps{
                stash includes: 'public/**/*.*', name: 'sources'
            }
        }
        stage('Deploy') {
            //1 docker
            //publish over ssh
                steps {
                    unstash 'sources'
                    sshPublisher(publishers: [sshPublisherDesc(configName: 'Local Docker', transfers:
                            [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+',
                                    remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'sources')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                }
        }
        stage('Integration testing') {
            steps {
                sleep 10
                sh 'curl localhost:8082/index.html'
            }
        }
    }
}