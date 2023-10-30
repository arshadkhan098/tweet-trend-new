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
                sh 'mvn clean deploy'
            }
        }
        
    }
}
