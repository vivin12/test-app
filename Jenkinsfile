pipeline {
  environment {
    imageName = 'gooner4life/jenkins-test'
    registryCredentialSet = 'dockerhub'
    registryUri = ''
    dockerInstance = ''
  }

  agent any

  stages {
     stage('Cloning Git') {
        steps {
            git 'https://github.com/vivin12/test-app'
        }
      }

    stage('Build Image') {
      steps {
        echo 'Building container image..'
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }

      }
    }

    stage('Publish Image') {
      steps {
        echo 'Publishing container image to the registry..'
        script {
          docker.withRegistry('', registryCredentialSet) {
          dockerImage.push()
          }
        }

      }
    }

    stage('Cleaning up') {
        steps   {
            sh "docker rmi $registry:$BUILD_NUMBER"
        }
    }

    stage('Deploy') {
      steps {
        echo 'Sending deployment request to Kubernetes..'
      }
    }

  }

}