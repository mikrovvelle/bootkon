## Lab 5: Add Vertex AI Search

**Optional:** *these steps wire a third natural-language search option to the app. If you'd like to try something else, skip the end to see how to get started with open-ended hacking...*

Our frontend includes three ways to search. Two of them use AlloyDB AI NL, The third one uses Vertex AI Search. Vector AI search will use data from AlloyDB as its own data store.

### Setup Vertex AI Data Store

One note: some of the pages in Vertex AI's data store management pages load without the tutorial pane. If that happens, run `bk-start` from the terminal and it should re-open.

1. Navigate to [Vertex AI Data Stores](https://console.cloud.google.com/gen-app-builder/data-stores), 
2. click "Create data store" and follow the instructions to create a new data store.
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
  - Data store name: "property-listings-ds", 
  - **Important**: under the data store name field there is a link to "Edit" the data store ID. Click on it and set the data store ID to "property-listings-ds".

7. Click "Continue", leave the pricing model as "General pricing" and click "Create".

### Creat an 'app'

To trigger the indexing of the data store, we need to create an 'app' that uses the data store.

1. Navigate to [Vertex AI's Apps page](https://console.cloud.google.com/gen-app-builder/engines), 
2. click "Create app" and select "Custom search (general)" as the app type you want to build.
3. You need to chose a name and comapny name for the app. Simply 'app' and 'company' are fine for the purposes of this lab. Fill the fields out and click 'continue'.
4. The net step should present your 'property-listings-ds' data store. Check the box so it's selected, and click 'continue'.

Now if you check the [data store list of documents](https://console.cloud.google.com/gen-app-builder/locations/global/collections/default_collection/data-stores/property-listings-ds/data/documents), you should see that documents are becoming indexed, or already indexed.

Now the 'Vertex AI Search' tab in the frontend should work.

### More...

This is where the the hacking starts.

Now we're ready to build more. To take advantage of Gemini 3.1 Pro Preview, we need to use the `gemini` CLI:

```bash
gemini --model gemini-3.1-pro-preview
```

From here, you can use natural language prompts to ask questions about the codebase, fix issues, or add features.

