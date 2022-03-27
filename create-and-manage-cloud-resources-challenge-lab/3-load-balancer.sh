gcloud compute instance-templates create nucleus-template-1 \
    --metadata-from-file=startup-script=startup.sh
gcloud compute target-pools create nucleus-pool-1 --region=us-east1
gcloud compute instance-groups managed create nucleus-group-1 --size=2 \
    --template=nucleus-template-1 --zone=us-east1-b
gcloud compute firewall-rules create $FIREWALL_RULE --allow=tcp:80
gcloud compute health-checks create http nucleus-check-1
gcloud compute backend-services create nucleus-service-1 \
    --health-checks=nucleus-check-1 --global
gcloud compute instance-groups set-named-ports nucleus-group-1 \
    --named-ports=http:80 --zone=us-east1-b
gcloud compute backend-services add-backend nucleus-service-1 \
    --instance-group=nucleus-group-1 --instance-group-zone=us-east1-b --global
gcloud compute url-maps create nucleus-map-1 --default-service=nucleus-service-1
gcloud compute target-http-proxies create nucleus-proxy-1 \
    --url-map=nucleus-map-1
gcloud compute forwarding-rules create nucleus-rule-1 \
    --target-http-proxy=nucleus-proxy-1 --global --ports=80
