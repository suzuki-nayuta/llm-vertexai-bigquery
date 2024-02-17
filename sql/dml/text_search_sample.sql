-- 分析結果の解析のため、CTASしておく。
CREATE OR REPLACE TABLE llm_sample.sample_analysis
AS
WITH search_review AS(
  SELECT 
    text_embedding
  FROM ML.GENERATE_TEXT_EMBEDDING(
    MODEL `llm_sample.text_embedding_model`,
    (SELECT 'シェフの料理が美味しかった。' AS content),
    STRUCT(TRUE AS flatten_json_output)
  )
)
SELECT
  ML.DISTANCE(search_review.text_embedding, result_table.embedding, 'COSINE') AS distance,
  result_table.content,
  result_table.sentiment,
  result_table.review_timestamp
FROM
  search_review,
  llm_sample.result_table
ORDER BY 1 ASC