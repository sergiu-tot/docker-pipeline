def gitRepo   = "git@github.com:sergiu-tot/docker-pipeline.git"
def gitBranch = "add_jenkins_pipeline"

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

        // clean old code
        stage('Check docker') {
            steps {
                sh """
                  docker run hello-world
                """
            }
        }

    }
}