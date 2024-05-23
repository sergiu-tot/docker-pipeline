def gitRepo   = "https://github.com/sergiu-tot/docker-pipeline.git"
def gitBranch = "main"

pipeline {
    agent any

    // pipeline options
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', daysToKeepStr: '30'))
        disableConcurrentBuilds()
        disableResume()
        timeout(time: 10, unit: 'MINUTES')
    }

    // deployment stages
    stages {

        // clean old code
        stage('Clean git workspace') {
            steps {
                deleteDir()
                checkout([$class: 'GitSCM', 
                          branches: [[name: "*/${gitBranch}"]], 
                          userRemoteConfigs: [[url: "${gitRepo}"]]])
                echo "Git cloned"
            }
        }

        // check that docker is running correctly
        stage('Check docker') {
            steps {
                sh """
                  docker run hello-world
                """
            }
        }


    }
}