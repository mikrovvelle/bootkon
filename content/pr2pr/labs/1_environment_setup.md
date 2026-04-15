## Lab 1: Environment Setup

<walkthrough-tutorial-duration duration="30"></walkthrough-tutorial-duration>
<walkthrough-tutorial-difficulty difficulty="1"></walkthrough-tutorial-difficulty>
<bootkon-cloud-shell-note/>


In this lab we will set up your environment, download the data set for this Bootkon, put it to Cloud Storage,
and do a few other things.

### Enable services

First, we need to enable some Google Cloud Platform (GCP) services. Enabling GCP services is necessary to access and use the resources and capabilities associated with those services. Each GCP service provides a specific set of features for managing cloud infrastructure, data, AI models, and more. Enabling them takes a few minutes.

<walkthrough-enable-apis apis=
  "storage-component.googleapis.com,
  serviceusage.googleapis.com,
  cloudresourcemanager.googleapis.com,
  compute.googleapis.com,
  bigquery.googleapis.com,
  dataplex.googleapis.com,
  dataform.googleapis.com,
  bigqueryconnection.googleapis.com,
  aiplatform.googleapis.com,
  cloudbuild.googleapis.com,
  cloudaicompanion.googleapis.com,
  artifactregistry.googleapis.com">
</walkthrough-enable-apis>

### Assign permissions

Execute the following script:
```bash
content/pr2pr/bk-bootstrap
```

### Success

🎉 Congratulations{% if MY_NAME %}, {{ MY_NAME }}{% endif %}! You've officially leveled up from "cloud-curious" to "GCP aware"! 🌩️🚀
