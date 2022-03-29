export PROJECT_ID=$(gcloud config get project)
bq mk $BIGQUERY_DATASET_NAME
gsutil mb gs://$CLOUD_STORAGE_BUCKET_NAME
gcloud dataflow jobs run simple-job \
    --gcs-location gs://dataflow-templates-us-central1/latest/GCS_Text_to_BigQuery \
    --region us-central1 \
    --staging-location gs://$CLOUD_STORAGE_BUCKET_NAME/temp \
    --parameters javascriptTextTransformGcsPath=gs://cloud-training/gsp323/lab.js,JSONPath=gs://cloud-training/gsp323/lab.schema,javascriptTextTransformFunctionName=transform,outputTable=$PROJECT_ID:$BIGQUERY_DATASET_NAME.customers_871,inputFilePattern=gs://cloud-training/gsp323/lab.csv,bigQueryLoadingTemporaryDirectory=gs://$CLOUD_STORAGE_BUCKET_NAME/bigquery_temp
