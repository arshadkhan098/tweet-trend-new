pipeline{
    agent{
        node{
            label 'maven'
        }
    }    
    stages{
        stage ('trigerd pipeline'){
            steps{
                git branch: 'main', url: 'https://github.com/arshadkhan098/tweet-trend-new.git'
            }
        }
    }
}
