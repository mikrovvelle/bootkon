## Lab 3: Database Setup

In this section we will:

- run some scripts for setting up AlloyDB
- run a Python script `bootstrap_images.py` to generate images and embeddings for property listings.

### Insert the data to AlloyDB

Navigate to [AlloyDB in the Cloud Console](https://console.cloud.google.com/alloydb/clusters). You should see a list of resources, with your `search-cluster` listed, and `search-primary` as the primary instance. Click on `search-primary`.

Click the magnifying glass icon on the left-hand activity bar to open AlloyDB Studio. You should be presented with a login dialogue

![](../img/lab3/alloydb-login.png)

`postgres` should be the only available database and user name available. Use your configured database password to log in. You should now see the editor. Tap the "Untitled Query" tab (pictured).

![](../img/lab3/alloydb-query-editor.png)

1. Copy & paste the contents of the <walkthrough-editor-open-file filePath="content/pr2pr/alloydb-artefacts/alloydb_setup.sql">alloydb_setup.sql</walkthrough-editor-open-file> file into the editor and click the "Run" button.
2. Copy & paste the contents of the <walkthrough-editor-open-file filePath="content/pr2pr/alloydb-artefacts/100 _sample records.sql">100 _sample records.sql</walkthrough-editor-open-file> file into the editor and click the "Run" button.
3. Copy & paste the contents of the <walkthrough-editor-open-file filePath="content/pr2pr/alloydb-artefacts/alloydb_ai_nl_setup.sql">alloydb_ai_nl_setup.sql</walkthrough-editor-open-file> file into the editor and click the "Run" button.



### Prerequisites

1. **Environment Variables**:
The script loads environment variables from `../backend/.env`.
Ensure this file exists and is populated. You can generate it using Terraform outputs:

```bash
cd ~/bootkon/content/pr2pr/terraform/
./generate_env.sh
```

Or manually create it based on `../example.env`. The /setup_env.sh script also helps you setting up all required environment variables.

2. **AlloyDB Auth Proxy**:
The script connects to AlloyDB via `127.0.0.1:5432`. You must have the Auth Proxy running.
A helper script is provided to start the proxy via the Bastion host:
```bash
./run_proxy.sh
```
*This will establish an SSH tunnel and start the proxy on the Bastion host.*

3. **Python Environment**:
Ensure you have Python installed and the required dependencies.
It is recommended to use a virtual environment.

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Running the Script

Once the proxy is running and environment is set:

```bash
python bootstrap_images.py
```

### What it does
1.  Connects to AlloyDB via localhost:5432.
2.  Finds listings with `image_gcs_uri IS NULL`.
3.  Generates an image using Vertex AI Imagen.
4.  Uploads the image to the GCS bucket (`property-images-{PROJECT_ID}`).
5.  Generates a multimodal embedding for the image.
6.  Updates the `property_listings` table with the GCS URI and embedding.