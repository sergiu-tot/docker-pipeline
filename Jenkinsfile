def gitRepo   = "https://github.com/sergiu-tot/docker-pipeline.git"
def gitBranch = "add_jenkins_pipeline"
def pythonImg = "python:3.12"

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

        // build python image with our libraries
        stage('Build python image') {
            steps {
                dir("${WORKSPACE}"){
                    sh """
                    docker build -t python:test .
                    """
                }
            }
        }


    }
}