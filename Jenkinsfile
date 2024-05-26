def gitRepo   = "https://github.com/sergiu-tot/docker-pipeline.git"
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

        // build python image with our libraries
        stage('Build python image') {
            steps {
                sh """
                    docker build -t my-python:latest -f ${WORKSPACE}/Dockerfile.app .
                """
            }
        }

        // run the application
        stage('Run the application') {
            steps {
                sh """
                    docker run                            \
                    --rm                                  \
                    --name=flaskr-init                    \
                    --user=\$(id -u):\$(id -g)            \
                    --volume=\$(pwd)/flask-tutorial:/code \
                    --entrypoint="/bin/sh"                \
                    my-python:latest                      \
                    -c "flask --app flaskr init-db"
                """

                sh """
                    docker run                            \
                    --rm                                  \
                    --detach                              \
                    --name=flaskr                         \
                    --user=\$(id -u):\$(id -g)            \
                    --volume=\$(pwd)/flask-tutorial:/code \
                    --publish=5000:5000                   \
                    my-python:latest
                """
            }
        }

        // run tests
        stage('Run parallel tests') {
            steps {
                parallel(
                    pytest: {
                        sh returnStatus: true, script: """
                                docker run                                \
                                    --rm                                  \
                                    --name=flaskr-pytest                  \
                                    --user=\$(id -u):\$(id -g)            \
                                    --entrypoint="/bin/sh"                \
                                    --volume=\$(pwd)/flask-tutorial:/code \
                                    my-python:latest                      \
                                    -c "coverage run -m pytest --junit-xml=report.xml"
                            """
                    },
                    bandit: {
                        sh returnStatus: true, script: """
                                docker run                                \
                                    --rm                                  \
                                    --name=flaskr-bandit                  \
                                    --user=\$(id -u):\$(id -g)            \
                                    --entrypoint="/bin/sh"                \
                                    --volume=\$(pwd)/flask-tutorial:/code \
                                    my-python:latest                      \
                                    -c "bandit -r /code/flaskr | tee bandit.txt"
                            """
                    },
                    pylint: {
                        sh returnStatus: true, script: """
                                docker run                                \
                                    --rm                                  \
                                    --name=flaskr-pylint                  \
                                    --user=\$(id -u):\$(id -g)            \
                                    --entrypoint="/bin/sh"                \
                                    --volume=\$(pwd)/flask-tutorial:/code \
                                    my-python:latest                      \
                                    -c "pylint /code/flaskr | tee pylint.txt"
                            """
                    },
                    curl: {
                        sh returnStatus: true, script: """
                                docker run                                \
                                    --rm                                  \
                                    --name=flaskr-curl                    \
                                    alpine/curl:8.7.1                     \
                                    http://172.17.0.1:5000
                            """
                    }
                )
            }
        }

        // stop the application
        stage('Stop the application') {
            steps {
                sh """
                    docker stop flaskr
                """
            }
        }

    }

    // record junit reports
    post {
        always {
            archiveArtifacts artifacts: 'flask-tutorial/*.(txt|xml)', fingerprint: true
            junit testResults: "flask-tutorial/report.xml", skipPublishingChecks: true
        }
    }

}
