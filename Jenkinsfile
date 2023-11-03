def registry = 'https://arshadproject1.jfrog.io'
def imageName = 'arshadproject1.jfrog.io/project1-docker-local/ttrend'
def version   = '2.1.2'
pipeline{
    agent any
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

    stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"257c64f9-c9c6-4340-b9c9-301993a75790"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   


    }

    stage(" Docker Build ") {
      steps {
        script {
           echo '<--------------- Docker Build Started --------------->'
           app = docker.build(imageName+":"+version)
           echo '<--------------- Docker Build Ends --------------->'
        }
      }
    }

            stage (" Docker Publish "){
        steps {
            script {
               echo '<--------------- Docker Publish Started --------------->'  
                docker.withRegistry(registry, '257c64f9-c9c6-4340-b9c9-301993a75790'){
                    app.push()
                }    
               echo '<--------------- Docker Publish Ended --------------->'  
            }
        }
         }
        
        stage(" Deploy ") {
       steps {
         script {
            sh './deploy.sh'
       }
     }  
        
    }
}
