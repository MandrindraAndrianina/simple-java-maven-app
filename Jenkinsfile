pipeline {
    agent any
    tools {
        maven 'Maven-3' 
    }
    stages {
        stage('git checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'git-credentials',
                    url: 'https://github.com/MandrindraAndrianina/simple-java-maven-app.git'
            }
        }
        
        stage('Build the application') {
            steps {
                sh 'mvn clean install'
            }
        }
        
        stage('Unit Test Execution') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mandrindra/my-app:1.0.0 .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'dockerHubToken')]) {
                    sh 'docker login -u mandrindra -p $dockerHubToken'
                    sh 'docker push mandrindra/my-app:1.0.0'
                }
            }
        }
    }

    post {
        failure {
            emailext(
                subject: " Build #${BUILD_NUMBER} a échoué !",
                body: """
                    Bonjour,

                    Le build Jenkins #${BUILD_NUMBER} a échoué.

                    Projet   : ${JOB_NAME}
                    Build    : #${BUILD_NUMBER}
                    Statut   : FAILURE 
                    Lien     : ${BUILD_URL}

                    Merci de vérifier les logs.
                """,
                to: 'adrianina59@gmail.com',
                recipientProviders: [requestor()]
            )
        }
        success {
            emailext(
                subject: " Build #${BUILD_NUMBER} réussi !",
                body: """
                    Bonjour,

                    Le build Jenkins #${BUILD_NUMBER} a réussi.

                    Projet   : ${JOB_NAME}
                    Build    : #${BUILD_NUMBER}
                    Statut   : SUCCESS 
                    Lien     : ${BUILD_URL}
                """,
                to: 'adrianina59@gmail.com',
                recipientProviders: [requestor()]
            )
        }
    }
}
