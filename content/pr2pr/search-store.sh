# Configuration
PROJECT_ID=$(gcloud config get-value project)
REGION="europe-west1" # AlloyDB Region
DATA_STORE_ID="property-listings-ds"
DISPLAY_NAME="Property Listings"
CLUSTER_ID="search-cluster"
DATABASE_ID="postgres"
TABLE_ID="search.property_listings"

# Get Access Token
ACCESS_TOKEN=$(gcloud auth print-access-token)

# Create Data Store via API
curl -X POST \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "x-goog-user-project: $PROJECT_ID" \
  -H "Content-Type: application/json" \
  "https://discoveryengine.googleapis.com/v1alpha/projects/$PROJECT_ID/locations/global/collections/default_collection/dataStores?dataStoreId=$DATA_STORE_ID" \
  -d '{
    "displayName": "'"$DISPLAY_NAME"'",
    "industryVertical": "GENERIC",
    "solutionTypes": ["SOLUTION_TYPE_SEARCH"],
    "contentConfig": "CONTENT_REQUIRED"
  }'

echo -e "\nWaiting for Data Store creation to propagate..."
sleep 10

# Import Documents from AlloyDB
curl -X POST \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "x-goog-user-project: $PROJECT_ID" \
  -H "Content-Type: application/json" \
  "https://discoveryengine.googleapis.com/v1alpha/projects/$PROJECT_ID/locations/global/collections/default_collection/dataStores/$DATA_STORE_ID/branches/0/documents:import" \
  -d '{
    "alloyDbSource": {
      "projectId": "'"$PROJECT_ID"'",
      "locationId": "'"$REGION"'",
      "clusterId": "'"$CLUSTER_ID"'",
      "databaseId": "'"$DATABASE_ID"'",
      "tableId": "'"$TABLE_ID"'"
    }
  }'