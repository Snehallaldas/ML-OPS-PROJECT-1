pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
        GCP_PROJECT = 'mlops-new-464503'
        GCLOUD_PATH = '/var/jenkins_home/google-cloud-sdk/bin'
    }

    stages {
        stage('Cloning Github repo to Jenkins') {
            steps {
                echo 'Cloning Github repo to Jenkins...........'
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'github-token',
                        url: 'https://github.com/Snehallaldas/ML-OPS-PROJECT-1.git'
                    ]]
                )
            }
        }

        stage('Setting up our Virtual Environment and Installing dependencies') {
            steps {
                echo 'Setting up our Virtual Environment and Installing dependencies'
                sh '''
                    python -m venv $VENV_DIR
                    . $VENV_DIR/bin/activate
                    pip install --upgrade pip
                    pip install -e .
                '''
            }
        }

        stage('Building and Pushing Docker Image to GCR') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    script {
                        echo 'Building and Pushing Docker Image to GCR........'
                        sh '''
                            export PATH=$PATH:${GCLOUD_PATH}
                            gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                            gcloud config set project $GCP_PROJECT
                            gcloud auth configure-docker --quiet
                            IMAGE_NAME=gcr.io/$GCP_PROJECT/ml-project:latest
                            docker build -t $IMAGE_NAME .
                            docker push $IMAGE_NAME
                        '''
                    }
                }
            }
        }
    }
}
