def gitRepo   = "https://github.com/sergiu-tot/docker-pipeline.git"
def gitBranch = "add_jenkins_pipeline"
def pythonImg = "python:3.10"

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
                sh """
                docker build -t python:test ${WORKSPACE}
                """
            }
        }

        // run pytest
        stage('Run pytest inside docker') {
            steps {
                sh """
                docker run --rm --user=113:121 \
                  -v ./flask-tutorial:/code python:test \
                  /bin/sh -c "/usr/local/bin/coverage run -m pytest --cov-report=html:reports/html_dir --cov-report=xml:reports/coverage.xml /code "
                """
            }
        }


    }
}