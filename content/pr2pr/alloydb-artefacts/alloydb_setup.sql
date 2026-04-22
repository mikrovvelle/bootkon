/*
===================================================================================
ALLOYDB AI: DATABASE & SCHEMA BOOTSTRAP
===================================================================================

This script initializes the foundation for the Semantic Search Demo.
It performs the following critical operations:

1. SCHEMA SETUP: Creates a dedicated "search" schema to keep the workspace clean.
2. EXTENSIONS: Enables Google ML, Vector, ScaNN, and AI Natural Language extensions.
3. TABLE DDL: Creates the `property_listings` table with:
   - Automatic Text Embeddings (using `generative-embedding-001` via database trigger).
   - Placeholder for Image Embeddings (populated later via Python).
4. DATA LOAD: Inserts sample real estate data for Switzerland.
5. INDEXING: Creates high-performance ScaNN indexes.
   * NOTE: Uses MANUAL mode because the dataset is small (<10k rows).

PRE-REQUISITES:
- Ensure the Vertex AI API is enabled in your Google Cloud Project.
- Ensure the AlloyDB Service Account has "Vertex AI User" permissions.
===================================================================================
*/

-- 1. SCHEMA INITIALIZATION
-- ===================================================================================

-- Create a clean slate for the demo
DROP SCHEMA IF EXISTS "search" CASCADE;
CREATE SCHEMA "search";

-- Set the path so we don't have to type "search." constantly
SET search_path TO "search", public;


-- 2. EXTENSION MANAGEMENT
-- ===================================================================================

-- Enable the Google ML Integration (Bridge to Vertex AI)
CREATE EXTENSION IF NOT EXISTS google_ml_integration WITH SCHEMA public CASCADE;

-- Enable pgvector (Base vector data type support)
CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public CASCADE;

-- Enable AlloyDB ScaNN (High-performance vector indexing)
CREATE EXTENSION IF NOT EXISTS alloydb_scann WITH SCHEMA public CASCADE;

-- Enable Parameterized Views (Required for Toolbox)
CREATE EXTENSION IF NOT EXISTS parameterized_views WITH SCHEMA public CASCADE;

-- Enable Natural Language Support (For the NL2SQL features configured later)
CREATE EXTENSION IF NOT EXISTS alloydb_ai_nl WITH SCHEMA public CASCADE;

-- Update extensions to ensure latest versions are active
ALTER EXTENSION alloydb_ai_nl UPDATE;

--Register latest embedding model to AlloyDB
-- Example to register a different embedding model:
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM google_ml.model_info_view WHERE model_id = 'my_gemini_embedding_model') THEN
        CALL google_ml.create_model(
            model_id => 'my_gemini_embedding_model',
            model_provider => 'google',
            model_qualified_name => 'gemini-embedding-001',
            model_type => 'text_embedding',
            model_auth_type => 'alloydb_service_agent_iam'
        );
    END IF;

    IF NOT EXISTS (SELECT 1 FROM google_ml.model_info_view WHERE model_id = 'my_gemini_2_5_flash') THEN
        CALL google_ml.create_model(
            model_id => 'my_gemini_2_5_flash',
            model_provider => 'google',
            model_request_url => 'publishers/google/models/gemini-2.5-flash:generateContent',
            model_type => 'generic',
            model_auth_type => 'alloydb_service_agent_iam'
        );
    END IF;
END
$$;

-- Check registered models
SELECT * FROM google_ml.model_info_view;


-- VERIFICATION: Check integration status
-- Expectation: Should show valid version and model support enabled
SELECT extname, extversion FROM pg_extension WHERE extname = 'google_ml_integration';
SHOW google_ml_integration.enable_model_support;

-- TEST: Sanity check the embedding connection to Gemini
-- If this fails, check your IAM permissions.
SELECT google_ml.embedding(
   model_id => 'gemini-embedding-001',
   content => 'Sanity check for Vertex AI connection'
) AS test_vector;


-- 3. TABLE CREATION
-- ===================================================================================

DROP TABLE IF EXISTS "search".property_listings CASCADE;

CREATE TABLE "search".property_listings (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(12, 2) NOT NULL,
    bedrooms INT,
    city VARCHAR(100),
    image_gcs_uri TEXT,
    -- COLUMN A: Text Embeddings (Managed by Database)
    -- Automatically generates a 3072-dim vector when you insert text into 'description'.
    description_embedding VECTOR(3072) GENERATED ALWAYS AS (
      embedding('gemini-embedding-001', description)
    ) STORED,
    -- COLUMN B: Image Embeddings (Managed by Application)
    -- Populated by 'bootstrap_images.py' using the Multimodal model (3072 dims).
    image_embedding VECTOR(1408) 
);

