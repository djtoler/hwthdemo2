pipeline {
    agent any

    stages {
        stage('Check Background Color') {
            steps {
                script {
                    // Execute the grep command inside the Docker container and capture the return status
                    def result = sh(script: "sudo docker exec 6e7211c632cf grep -qiE 'background(-color)?:\\s*(red|#f00|#ff0000|rgb\\(255,\\s*0,\\s*0\\));' /usr/share/nginx/html/index.html", returnStatus: true)
                    
                    // Check the result and handle the condition
                    if (result != 0) {
                        error("Build failed due to red background color in the HTML.")
                    } else {
                        echo "Background color is acceptable."
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Finished checking the background color.'
        }
        failure {
            echo 'Background color check failed.'
        }
    }
}
