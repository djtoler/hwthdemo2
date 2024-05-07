pipeline {
    agent any

    stages {
        stage('Check Background Color') {
            steps {
                script {
                    if (sh script: 'bash check_background_color.sh', returnStatus: true) != 0 {
                        error("Build failed due to red background color in the HTML.")
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Finished checking the background color.'
        }
        success {
            echo 'Background color is acceptable.'
        }
        failure {
            echo 'Background color check failed.'
        }
    }
}
