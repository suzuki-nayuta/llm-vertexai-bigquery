# プロジェクトIDは自分のものに置き換えてください。
PROJECT_ID = "プロジェクトID"

# 以下は適宜置き換えてください。
BQ_DATASET = "llm_sample"
SOURCE_TABLE = "user_review"
EMBEDDED_MODEL_NAME = "text_embedding_model"
TEXT_GENERATE_MODEL_NAME = "user_comment_analysis_model"
SENTIMENT_ANALYSIS_RESULT_TABLE = "sentiment_analysis_result"
EMBEDDED_TABLE = "embedded"
RESULT_TABLE = "result_table"


def get_project():
    """ プロジェクトIDを返す。
    """
    return PROJECT_ID


def get_predict_job_config():
    """ 推定結果を格納するテーブルの情報をジョブ設定として返す。
    """
    job_config = {
        "destinationTable": {
            "projectId": PROJECT_ID,
            "datasetId": BQ_DATASET,
            "tableId": PREDICT_RESULT_TABLE,
        }
    }
    return job_config


def generate_create_embedding_query():
    """ エンべディング付きのテーブルを作成するクエリを返す。
    """
    create_embedding_query = f"""
        CREATE OR REPLACE TABLE `{PROJECT_ID}.{BQ_DATASET}.{EMBEDDED_TABLE}`
        AS SELECT 
            user_id,
            content,
            review_timestamp,
            text_embedding as embedding,
            review_id
        FROM ML.GENERATE_TEXT_EMBEDDING(
          MODEL `{BQ_DATASET}.{EMBEDDED_MODEL_NAME}`,
          TABLE {BQ_DATASET}.{SOURCE_TABLE},
          STRUCT(TRUE AS flatten_json_output)
        );
        """
    return create_embedding_query


def generate_sentiment_analysis_query():
    """ 感情分析するSQLを返す。
        感情分析のプロンプトは以下のブログ記事を参考にしました。
        https://blog.g-gen.co.jp/entry/using-palm2-with-bigquery-ml
    """
    create_bq_model_query = f"""
        CREATE OR REPLACE TABLE `{PROJECT_ID}.{BQ_DATASET}.{SENTIMENT_ANALYSIS_RESULT_TABLE}`
        AS SELECT
          ml_generate_text_llm_result AS sentiment,
          review_id,
          content
        FROM
          ML.GENERATE_TEXT( MODEL {BQ_DATASET}.{TEXT_GENERATE_MODEL_NAME},
            (
            SELECT
              CONCAT( 'Classify the sentiment of this review as Positive or Negative? Review: ', content, ' Sentiment:' ) AS prompt,
              *
            FROM
              `{BQ_DATASET}.{SOURCE_TABLE}`
            ),
            STRUCT( 0.2 AS temperature,
              100 AS max_output_tokens,
              TRUE AS flatten_json_output ))
        """
    return create_bq_model_query


def generate_create_joined_table_query():
    """ 最終的な結果をまとめるSQLを返す。
    """
    create_joined_table_query = f"""
        CREATE OR REPLACE TABLE `{PROJECT_ID}.{BQ_DATASET}.{RESULT_TABLE}`
        AS SELECT
            et.review_id,
            et.user_id AS user_id,
            et.content AS content,
            et.embedding AS embedding,
            et.review_timestamp,
            sart.sentiment AS sentiment
        FROM `{PROJECT_ID}.{BQ_DATASET}.{EMBEDDED_TABLE}` AS et
        LEFT JOIN `{PROJECT_ID}.{BQ_DATASET}.{SENTIMENT_ANALYSIS_RESULT_TABLE}` AS sart
        ON et.review_id = sart.review_id
        """
    return create_joined_table_query