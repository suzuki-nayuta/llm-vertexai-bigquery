-- lls_sampleデータセットはあらかじめ作成しておく。
CREATE OR REPLACE MODEL llm_sample.text_embedding_model
  REMOTE WITH CONNECTION `asia-northeast1.llm_connection`
  OPTIONS (
    remote_service_type = 'CLOUD_AI_LARGE_LANGUAGE_MODEL_V1',
    ENDPOINT = 'textembedding-gecko-multilingual@latest'
  );