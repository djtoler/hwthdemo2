pipeline {
    agent any

    stages {
        stage('Check Background Color') {
            steps {
                script {
                    // Execute the bash script and capture the return status
                    def result = sh(script: 'test.sh', returnStatus: true)
                    
                    // Check the result and handle the condition
                    if (result != 0) {
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

