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

        stage("test"){
            steps{
                sh 'mvn surefire-report:report'
            }
        }

        stage('SonarQube analysis') {
        environment {
            scannerHome = tool 'sonar-scanner'
        }
        steps{
        withSonarQubeEnv('sonarqube-server') { 
                sh "${scannerHome}/bin/sonar-scanner"
    }
    }
        
    }
        stage("Quality Gate"){
    steps {
        script {
        timeout(time: 1, unit: 'HOURS') {
    def qg = waitForQualityGate() 
    if (qg.status != 'OK') {
      error "Pipeline aborted due to quality gate failure: ${qg.status}"
    }
  }
}
    }
  }


}
}
