# Create Setup in Confluent Cloud ti enable Monitoring for Confluent Cloud in Grafana Labs
We need to create a Service account with API Key and Secret and need to bind a role MetricViewer
First set your Cloud KEY and Secret in env.sh and source it. Then execute terraform

```bash
source env.sh
terraform init
terraform plan
terraform apply
```

Output of Service Account including key and secret
```bash
terraform output resource-ids
```
Switch to Grafana Labs and setup the Monitoring for Confluent cloud. Please follow documentation [here](https://grafana.com/docs/grafana-cloud/data-configuration/integrations/integration-reference/integration-confluent-cloud/) or use any other monitoring system
