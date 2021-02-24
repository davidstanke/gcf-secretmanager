# gcf-secretmanager

A lil' script to create a Google Cloud Function that accesses a secret stored in Secret Manager.

### To use:
1. clone this repo
2. (optional) create a new GCP project and activate it in gcloud
3. run `./setup.sh`
4. Browse the UIs to see how each of the parts is configured:
  * [Cloud Functions](https://console.cloud.google.com/functions/list)
  * [Secret Manager](https://console.cloud.google.com/security/secret-manager)
  * [IAM](https://console.cloud.google.com/iam-admin/iam)

### Cleanup:
* if you made a GCP project for this purpose:
  * delete the project
* else:
  1. delete the GCF function "secretReader"
  2. delete the Secret Manager secret "MySuperSecretSecret"
