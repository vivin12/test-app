pipeline {

  environment {
    registry = "gooner4life/jenkins-test"   //replace with OCP image stream name
    registryCredential = 'dockerhub'       //replace with OCP credential you have added in jenkins
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
          docker.withRegistry( '', registryCredential ) {   //update the first field with registry url if you are not pushing to dockerhub
            dockerImage.push()
          }
        }
      }
    }

    stage('Remove Unused docker image') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }

}
