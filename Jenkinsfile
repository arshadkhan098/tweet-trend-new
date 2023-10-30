pipeline{
    
    agent{
        node{
            label 'maven'
        }
    }
    
environment {
    PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
}    

    stages{
        stage('build stage'){
            steps{
                sh 'mvn clean deploy -Dmaven.test.skip=true'
            }
        }

        stage{
            steps("test"){
                sh 'mvn surefire-report:report'
            }
        }

        stage('SonarQube analysis') {
        environment {
            scannerHome = tool 'arshad-sonar-scanner'
        }
            steps{
            withSonarQubeEnv('sonarqube-server') { 
                sh "${scannerHome}/bin/sonar-scanner"
    }
    }
        
    }
}
}
