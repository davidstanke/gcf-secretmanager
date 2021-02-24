import os

from google.cloud import secretmanager

def get_secret_value(secret_id, version_id="latest"):

    PROJECT_ID = os.environ["GCP_PROJECT"]

    # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()

    # Build the resource name of the secret version.
    name = f"projects/{PROJECT_ID}/secrets/{secret_id}/versions/{version_id}"

    # Access the secret version.
    response = client.access_secret_version(name=name)

    # Return the decoded payload.
    return response.payload.data.decode('UTF-8')

def secretReader(request):

    secret = get_secret_value('MySuperSecretSecret')
    
    return f"The secret word is: {secret}\n"