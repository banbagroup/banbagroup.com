pipeline {
    agent { node { label 'banba' } } 
    stages {
        stage('CloudBuild') {
            steps {
		script {
                    echo 'CloudBuild'
                    if (env.GIT_BRANCH == 'master' ) {
			withCredentials([[$class: 'FileBinding', credentialsId: 'banba-group-google-json', variable: 'GOOGLE_APPLICATION_CREDENTIALS']]) {
                            sh 'echo "${GOOGLE_APPLICATION_CREDENTIALS}"' // returns ****
                            sh 'gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS'
                            sh 'gcloud auth list'
                            sh 'gcloud config set project banba-group'
			    sh 'export APP=banbagroup.com'
                            sh 'ruby ./bin/check_build.rb'
			}
                    }
		}
            }
	}

        stage('K8 Deploy') {
            steps {
                script{
                    if (env.GIT_BRANCH == 'master') {
                        echo 'Deploying master branch to K8 cluster'
			withCredentials([[$class: 'FileBinding', credentialsId: 'banba-group-google-json', variable: 'GOOGLE_APPLICATION_CREDENTIALS']]) {
                            sh 'echo "${GOOGLE_APPLICATION_CREDENTIALS}"' // returns ****
                            sh 'gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS'
                            sh 'gcloud auth list'
                            sh 'gcloud config set project banba-group'
			    sh 'gcloud container clusters get-credentials production --zone us-central1-a'
                            sh 'kubectl set image deployment banbagroup banbagroup=gcr.io/banba-group/banbagroup.com:${GIT_COMMIT}'
			}
                    }
                }
            }
	}
    }
}
