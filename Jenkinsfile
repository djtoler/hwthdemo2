pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Checking out code from your GitHub repository
                git(url: 'https://github.com/djtoler/hwthdemo2.git', branch: 'main')
            }
        }

        stage('Check Background Color') {
            steps {
                script {
                    // Assuming the HTML file is named index.html and located at the root of your repo
                    def htmlFile = readFile 'hwth.html'
                    if (htmlFile.contains('background-color: red') || htmlFile.contains('background: red') ||
                        htmlFile.contains('background-color:#ff0000') || htmlFile.contains('background:#ff0000') ||
                        htmlFile.contains('rgb(255, 0, 0)')) {
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
