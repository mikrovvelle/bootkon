## Lab 2: Terraform Basis


<walkthrough-tutorial-duration duration="30"></walkthrough-tutorial-duration>
<walkthrough-tutorial-difficulty difficulty="3"></walkthrough-tutorial-difficulty>
<bootkon-cloud-shell-note/>

Now that the GCP Cloud environment is ready, we will use Terraform to create a few resources.

### Prerequisites

1. **Terraform**: Ensure Terraform is installed (v1.0+).
This step is based on [Terraform's documentation](https://developer.hashicorp.com/terraform/install)
Before deploying the basis for this project, we'll install Terraform on our Cloud Shell instance.

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

2. **Google Cloud SDK**: Ensure `gcloud` is installed and authenticated:

```bash
gcloud config set project $PROJECT_ID
```


In the terraform directory, open the <walkthrough-editor-open-file filePath="content/pr2pr/terraform/README.md">README.md</walkthrough-editor-open-file> file and follow the instructions.


### Terraform initialization and variables

Your gcloud login project needs billing account and service usage api enabled. If not you'll see error during tf apply.
Check the following APIs that they are enabled in the project:

### 1. Initialize Terraform
Navigate to this directory and initialize the provider plugins:

```bash
cd content/pr2pr/terraform/
terraform init
```

### 2. Configure Variables
Create a `terraform.tfvars` file to specify your project details. 

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit the <walkthrough-editor-open-file filePath="content/pr2pr/terraform/terraform.tfvars">terraform.tfvars</walkthrough-editor-open-file> file and set the variables to your project details.

### 3. Review the Plan
Run `terraform plan` to see what resources will be created.
```bash
terraform plan
```
*Review the output to ensure it matches your expectations (Project, AlloyDB Cluster, IAM bindings, Regions, Zones, etc.).*

### 4. Apply the Configuration
Run `terraform apply` to create the infrastructure.
```bash
terraform apply
```
*Type `yes` when prompted to confirm.*


### What gets created?

-   **Network**: A VPC network (`search-demo-vpc`) with Private Service Access for AlloyDB.
-   **Subnet**: A subnet in your region with **Private Google Access** enabled.
-   **Firewall**: `allow-internal` rule to permit internal traffic (required for Bastion -> AlloyDB).
-   **AlloyDB**:
    -   Cluster: `search-cluster`
    -   Instance: `search-primary` (2 vCPU, Private IP only)
    -   Flags: AI & ML integration enabled.
-   **Bastion Host**: `search-demo-bastion` (e2-micro) for SSH tunneling.
-   **Artifact Registry**: Repository `search-app-repo`.
-   **IAM**: Creates a dedicated Service Account `search-backend-sa` and grants necessary roles.

### Next steps

Now it's time to initialize the database schema and extensions.

