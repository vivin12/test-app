pipeline {

  environment {
    registry = "gooner4life/jenkins-test"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }

  agent any
  stages {
      stage('Cloning Git') {
        steps {
            git 'https://github.com/vivin12/test-app'
        }
    }

    stage('Building image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Deploy Image') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }

}
