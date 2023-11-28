pipeline {
  agent any

  environment {
    EC2_HOST = 'ubuntu@35.154.26.146'
    REMOTE_DIR = '/home/ubuntu'
  }

  stages {
    stage('Cloning the git repo') {
      steps {
        // Cloning the GitHub repository into the Jenkins workspace
        git url: 'https://github.com/mohanvedase/CICD_GitActions.git', branch: 'staging'
      }
    }

    stage('Copying web application to EC2') {
      steps {
        echo 'Deploying into the ec2'
        sh "echo 'workspace directory is ${WORKSPACE}'"
        sh "ls ${WORKSPACE}"
        sh "pwd"

        sshagent(['aws-ec2-cred']) {
          sh "scp ${WORKSPACE}/* -o StrictHostKeyChecking=no ${EC2_HOST}:${REMOTE_DIR}"
        }
      }
    }

    stage('Build') {
      steps {
        // Install dependencies using pip
        sshagent(['aws-ec2-cred']) {
          sh 'sudo apt install -y python3-pip'
          sh 'sudo pip install streamlit'
          sh 'sudo pip install pytest'
          mail bcc: '', body: 'hello build is sucessfull', cc: '', from: '', replyTo: '', subject: 'email form jenkins', to: 'mohankandikuppa119@gmail.com'
        }
      }
    }

    stage('Test') {
      steps {
        sh 'sudo pytest /home/ubuntu/test_app.py'
        mail bcc: '', body: 'hello Testing is sucessfull', cc: '', from: '', replyTo: '', subject: 'email form jenkins', to: 'mohankandikuppa119@gmail.com'
      }
    }

    stage('Deploy') {
      when {
        expression {
          // Check if the previous stage (Test) was successful
          currentBuild.resultIsBetterOrEqualTo('SUCCESS')
        }
      }
      steps {
        sh 'sudo streamlit run /home/ubuntu/app.py'
      }
    }
  }

  post {
    success {
      echo 'cloning successfully completed'
    }
    failure {
      echo 'Cloning failed'
    }
  }
}
