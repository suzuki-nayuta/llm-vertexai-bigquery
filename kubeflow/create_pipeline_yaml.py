from kfp import compiler
from kfp import dsl

from bqml_utils import *


def main(): 
    @dsl.pipeline
    def bq_llm_pipeline():
        from google_cloud_pipeline_components.v1.bigquery import (
        BigqueryCreateModelJobOp, BigqueryEvaluateModelJobOp,
        BigqueryPredictModelJobOp, BigqueryQueryJobOp)
        
        # エンべディング生成用のSQLをBigQueryで実行する
        bq_embedding_op = BigqueryQueryJobOp(
            query=generate_create_embedding_query(),
            project=get_project(),
            location="asia-northeast1",
        )

        # 感情分析用のSQLをBigQueryで実行する
        bq_sentiment_analysis_op = BigqueryQueryJobOp(
            query=generate_sentiment_analysis_query(),
            project=get_project(),
            location="asia-northeast1",
        ).after(bq_embedding_op)
    
        # これまでの結果をまとめて結果テーブルを作成する
        bq_create_result_table_op = BigqueryQueryJobOp(
            query=generate_create_joined_table_query(),
            project=get_project(),
            location="asia-northeast1",
        ).after(bq_sentiment_analysis_op)

    compiler.Compiler().compile(bq_llm_pipeline, 'pipeline.yaml')


if __name__ == "__main__":
    main()