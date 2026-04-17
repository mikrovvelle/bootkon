-- Index 1: Text Description Index
-- Uses Cosine Distance for semantic similarity.
CREATE INDEX idx_scann_property_desc ON "search".property_listings
USING scann (description_embedding)
WITH (
    -- 'auto' mode requires ~10k rows. For this demo, we force MANUAL mode.
    mode = 'MANUAL',
    num_leaves = 1,     -- 1 partition is optimal for < 1000 rows.
    quantizer = 'SQ8'   -- Standard quantization for balance of speed/accuracy.
);

-- Index 2: Visual Search Index
-- Indexes the Multi-modal embedding column.
CREATE INDEX idx_scann_image_search ON "search".property_listings
USING scann (image_embedding)
WITH (
    mode = 'MANUAL',
    num_leaves = 1,     -- Kept at 1 to ensure stability with small demo dataset.
    quantizer = 'SQ8'
);


-- 6. VALIDATION QUERIES
-- ===================================================================================

-- Test A: Simple Semantic Search
-- Finds "Student" vibes even without the word "Student" (looking for "Quiet", "Study").
SELECT title, description, price, city
FROM "search".property_listings
ORDER BY description_embedding <=> embedding('gemini-embedding-001', 'a quiet place to study near by University')::vector
LIMIT 3;

-- Test B: Hybrid Search (Semantic + Filters)
-- Finds modern apartments, specifically in Zurich, specifically under 15k.
SELECT id, title, price, city
FROM "search".property_listings
WHERE price < 15000.00
  AND city = 'Zurich'
ORDER BY description_embedding <=> embedding('gemini-embedding-001', 'a modern apartment for a professional working in the city')::vector
LIMIT 3;

-- Test C: Concept/Vibe Search
-- "Live near water" -> matches descriptions mentioning lakes or rivers.
SELECT
    title,
    price,
    city,
    -- Show the actual distance score (0 is perfect match, 1 is no match)
    description_embedding <=> embedding('gemini-embedding-001', 'I want to live near the water')::vector AS cosine_distance
FROM "search".property_listings
ORDER BY cosine_distance ASC
LIMIT 3;