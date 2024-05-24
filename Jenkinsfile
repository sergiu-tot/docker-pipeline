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
        stage('Run parallel tests') {
            steps {
                parallel(
                    pytest: {
                        sh returnStatus: true, script: """
                            docker run --rm --user=113:121 \
                            -v ./flask-tutorial:/code python:test \
                            /bin/sh -c "coverage run -m pytest /code --junit-xml=report.xml"
                            """
                    },
                    bandit: {
                        sh returnStatus: true, script: """
                            docker run --rm --user=113:121 \
                            -v ./flask-tutorial:/code python:test \
                            /bin/sh -c "bandit /code"
                            """
                    },
                    pylint: {
                        sh returnStatus: true, script: """
                            docker run --rm --user=113:121 \
                            -v ./flask-tutorial:/code python:test \
                            /bin/sh -c "pylint /code/flaskr"
                            """
                    }
                )
            }
        }

        stage('Save pytest report') {
            steps {
                junit "flask-tutorial/report.xml"
            }
        }

    }
}