#!/bin/bash

BILLING_ACCOUNT=$(gcloud beta billing projects describe "$(gcloud config get-value project)" --format="value(billingAccountName)" || sed -e 's/.*\///g')

project_id='stanke-20210224i'
gcloud projects create ${project_id}
gcloud config set project ${project_id}
gcloud beta billing projects link ${project_id} --billing-account=${BILLING_ACCOUNT}

gcloud services enable cloudfunctions.googleapis.com secretmanager.googleapis.com cloudbuild.googleapis.com

echo "Strawberry" | gcloud secrets create MySuperSecretSecret --data-file=-

gcloud secrets add-iam-policy-binding MySuperSecretSecret \
    --role roles/secretmanager.secretAccessor \
    --member serviceAccount:${project_id}@appspot.gserviceaccount.com

gcloud functions deploy secretReader --region=us-central1 \
    --allow-unauthenticated --source=function-source --runtime=python38 \
    --set-env-vars=GCP_PROJECT=$(gcloud config get-value project) \
    --trigger-http