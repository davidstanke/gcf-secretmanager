#!/bin/bash

project_id=$(gcloud config get-value project)

gcloud services enable cloudfunctions.googleapis.com secretmanager.googleapis.com cloudbuild.googleapis.com

echo "Strawberry" | gcloud secrets create MySuperSecretSecret --data-file=-

gcloud secrets add-iam-policy-binding MySuperSecretSecret \
    --role roles/secretmanager.secretAccessor \
    --member serviceAccount:${project_id}@appspot.gserviceaccount.com

gcloud functions deploy secretReader --region=us-central1 \
    --allow-unauthenticated --source=function-source --runtime=python38 \
    --set-env-vars=GCP_PROJECT=$(gcloud config get-value project) \
    --trigger-http