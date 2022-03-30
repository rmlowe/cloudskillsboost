gcloud dataproc clusters create my-cluster --region=$REGION
# Run this manually on master: hdfs dfs -cp gs://cloud-training/gsp323/data.txt /data.txt
gcloud dataproc jobs submit spark \
    --class=org.apache.spark.examples.SparkPageRank --cluster=my-cluster \
    --jars=file:///usr/lib/spark/examples/jars/spark-examples.jar \
    --max-failures-per-hour=1 --region=$REGION -- /data.txt
