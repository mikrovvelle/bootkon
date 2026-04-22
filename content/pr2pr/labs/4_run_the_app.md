## Lab 4: Run the App


### Vertex AI Data Store

As one last setup step, let's deploy a VectorAI Search store which will be linked to AlloyDB.

1. Navigate to [Vertex AI Data Stores](https://console.cloud.google.com/gen-app-builder/data-stores?project={{ PROJECT_ID }}), 
2. click <walkthrough-spotlight-pointer locator="semantic({button 'Create data store'})">Create data store</walkthrough-spotlight-pointer> and follow the instructions to create a new data store.
3. In the "Select a data source" field, type "AlloyDB". AlloyDB should show up as an option in the list of first-party data sources. Click on "add data source"
4. Fill out the fields to define the source:

  - Project ID: "{{ PROJECT_ID }}"
  - Location ID: your region (should be "europe-west1")
  - Cluster ID: "search-cluster"
  - Database ID: "postgres"
  - Table ID: "search.property_listings"

5. Click "Continue" to go to the configuration page.
6. Fill out the last two configuration fields:

  - Multi-region: leave as "global"
  - Data store name: "property-listings-ds"

7. Click "Continue", leave the pricing model as "General pricing" and click "Create".

### Debug

With everything else in place, we will attempt to run the backend and frontend services.

To start, run the debug script:

```bash
./debug_local.sh
```

This mimics the Cloud Run environment locally using Docker and a Bastion host tunnel. 

### Deploy

If the previous step looks ok, go ahead and cancel it with `ctrl-c`, deploy the app using the deploy script:

```bash
./deploy.sh
```

The script should share a link to the frontend service. Click on it and play around with the app. It's likely that no everything works. This is where the the hacking starts.

Now we're ready to build more. To take advantage of Gemini 3.1 Pro Preview, we need to use the `gemini` CLI:

```bash
gemini --model gemini-3.1-pro-preview
```

From here, you can use natural language prompts to ask questions about the codebase, fix issues, or add features.

