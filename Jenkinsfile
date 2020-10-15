pipeline {
  agent any
  stages {

    stage('Build') {
      steps {
        echo 'Building container image..'
        script {
          dockerInstance = docker.build(imageName)
        }

      }
    }

    stage('Publish') {
      steps {
        echo 'Publishing container image to the registry..'
        script {
          docker.withRegistry('', registryCredentialSet) {
            dockerInstance.push("${env.BUILD_NUMBER}")
            dockerInstance.push("latest")
          }
        }

      }
    }

    stage('Deploy') {
      steps {
        echo 'Sending deployment request to Kubernetes..'
      }
    }

  }
  environment {
    imageName = 'gooner4life/jenkins-test'
    registryCredentialSet = 'dockerhub'
    registryUri = ''
    dockerInstance = ''
  }
}