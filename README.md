# Vertex AIとBigQueryでつくる、簡単ベクトル検索システム
## 概要
Vertex AIパイプラインをオーケストレーターとして使い、BigQueryによりテキストの感情分析・埋め込みベクトル生成を行うサンプルになります。
感情分析・埋め込みベクトル生成のエンジンとしてはPaLM2を使います。

## 使い方
### kubeflowパイプライン作成
`requirements.txt`より必要なライブラリをインストールし、`kubeflow/create_pipeline_yaml.py`を実行します。
本実装では、`kubeflow/bqml_utils.py`のはじめにGoogle CloudプロジェクトIDを設定する必要があるため、実行前に置き換えてください。

以下のように実行します。

``` Python
python create_pipeline_yaml.py
```

`pipeline.yaml`が作成されるので、Vertex AIパイプラインで実行します。

### サンプルのSQL
`sql`ディレクトリにサンプルのSQLを格納しています。

`sql/ddl`に格納したSQL文は事前に実行する必要があります。各リソース名は`kubeflow/bqml_utils.py`の上部に変数として記載した値と対応しています。
リソースは`llm_sample`データセットに作成されます。このデータセットは事前に作成しておいてください。

`sql/dml`に格納したSQL文は分析用のサンプルコードとなります。同様のものがVertex AIパイプラインからも実行されます。



