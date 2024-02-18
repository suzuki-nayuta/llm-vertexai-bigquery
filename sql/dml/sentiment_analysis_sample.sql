SELECT
  -- 空白発生時の除去のために入れておく。
  TRIM(ml_generate_text_llm_result) AS sentiment,
  CAST(JSON_EXTRACT_SCALAR(ml_generate_text_rai_result, '$.blocked') AS BOOL) AS is_safety_filter_blocked,
  * EXCEPT (ml_generate_text_llm_result,
    ml_generate_text_rai_result)
FROM
  ML.GENERATE_TEXT( MODEL llm_sample.user_comment_analysis_model,
    (
    SELECT
      -- プロンプトは以下のブログ記事を参考にしました。
      -- https://blog.g-gen.co.jp/entry/using-palm2-with-bigquery-ml
      CONCAT( 'Classify the sentiment of this review as Positive or Negative? \n Review: ', content, '\n Sentiment:' ) AS prompt,
      *
    FROM
      `llm_sample.user_comment_analysis`
    -- 動作例なので5レコードに限定して適用する。
    LIMIT
      5),
    STRUCT( 0.2 AS temperature,
      100 AS max_output_tokens,
      TRUE AS flatten_json_output ))