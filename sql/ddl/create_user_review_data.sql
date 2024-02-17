-- lls_sampleデータセットはあらかじめ作成しておく。
CREATE OR REPLACE TABLE llm_sample.user_review (
  content STRING,
  review_id INTEGER,
  user_id STRING,
  review_timestamp TIMESTAMP
);

-- DDLではないが分けると紛らわしいのでこちらに合わせて記載する。
-- テキストはVertex AIよりtext-bison@002で作成した。
-- user_idはPythonでUUIDを生成した。
-- review_timestampはPythonで適当な時間を生成したが、一部ユースケースが分かりやすいように調整した。
INSERT INTO llm_sample.user_review (content, review_id, user_id, review_timestamp) VALUES 
('部屋は清潔で広く、快適でした。', 1, '09965d5f-98c9-4b75-bf2f-3163899e10c7', '2023-10-31 00:25:43'),
('スタッフはフレンドリーで、親切でした。', 2, 'c1f15d84-ceb0-4dd9-8bb7-a832cb34f6bf', '2023-08-26 22:26:30'),
('スタッフはとても親切で優しかったです。', 3, 'ef958a1d-236a-409b-add0-1a4dd6b81f3c', '2023-03-01 07:06:26'),
('スタッフの対応がよく、気持ちが良かった。', 4, '4c851702-316f-4fb7-b189-cba6ec57c858', '2023-06-12 07:29:30'),
('スタッフの挨拶が丁寧で気分が良かった。', 5, 'a2c9fc23-2a73-4bc8-a61e-c805f84819de', '2023-11-17 13:09:16'),
('ホテルのスタッフはとても親切で、何か困ったことがあってもすぐに対応してくれました。', 6, 'c8a61891-c855-4100-a73d-c470e9311af2', '2023-10-01 22:52:48'),
('荷物が多かったが、スタッフの方が親切に部屋まで送ってくれたのでとても助かった。', 7, 'd7e8b6a1-e694-4241-be67-2e83d4c7fdf3', '2023-10-03 07:46:26'),
('ホテルの敷地内には、いくつかのレストランやショップがあり、便利でした。', 8, '23a0deb9-035d-4114-87dd-cb89bcef23c0', '2023-07-30 03:07:08'),
('スパは最高で、リラックスできました。', 9, '31cc2e8c-98af-4a0b-9dd5-0c6bb5eb5bb3', '2023-07-10 16:02:54'),
('ホテルからビーチまで、徒歩ですぐでした。', 10, 'd3ee814b-4ca3-408b-9411-51c6fc2d1a1c', '2023-06-11 11:15:29'),
('ホテルの設備は最新のもので、使いやすかったです。', 11, 'c9f453e8-f5b8-4736-8642-8fb22e77cb46', '2023-05-10 21:13:11'),
('Wi-Fiは無料で、速度も速かったです。', 12, '53375dc5-8de3-490f-8252-c5f13a015c9e', '2023-07-19 15:27:22'),
('価格に見合った価値のあるホテルでした。', 13, '40258c26-a0d2-4efe-bb26-ed4ca79ad465', '2023-09-30 23:20:13'),
('部屋は広く清潔で快適でした。', 14, '967d1328-672b-4d38-8dc1-f26b90cb6567', '2023-01-24 19:55:32'),
('全体的にとても良いホテルで、また泊まりたいと思いました。', 15, '28e01a01-4144-4c85-b8cd-0babda7e5131', '2023-06-20 18:30:38'),
('部屋は清潔で快適でした。', 16, '6ce48997-e53f-43be-947d-c2b9eaca1d1b', '2023-04-16 02:33:28'),
('ホテルの設備が充実しており、様々なことができ、充実した時間を過ごすことができました。', 17, '197df225-f11c-4b52-9efd-7a586d4f44bf', '2023-07-08 11:03:41'),
('周囲の環境も静かで、ゆっくりと過ごすことができました。"ホテルのプールが広く、ゆったりと泳ぐことができました。', 18, '91d1b656-f1a3-4eb0-a635-698edd847a2a', '2023-04-03 23:12:32'),
('プールは広く、泳いだり、リラックスしたりするのに最適でした。', 19, 'df70391f-d8e3-4d64-bdfa-83a4f7a96dce', '2023-11-01 19:34:43'),
('ホテルのスパは最高で、リラックスして過ごすことができました。', 20, 'e36a4f79-be39-4636-8fa3-078274517ed1', '2023-10-12 19:50:07'),
('フィットネスルームも充実しており、運動不足が解消されました。', 21, '9124b4e8-c995-40b8-8bbd-a6859d58d6c5', '2023-04-28 01:37:35'),
('スパも充実しており、リラックスできました。', 22, '26944820-f26f-4c4c-9e41-fff828f0ef6e', '2023-12-26 06:22:24'),
('プールがきれいでした。', 23, '813463b5-7254-4d17-ada6-59f235de4a4e', '2023-12-18 07:29:47'),
('ホテルのジムは充実しており、トレーニングに最適でした。', 24, 'e8f4c9f3-e3ca-47e9-b0c3-5a7b415d5769', '2023-07-25 14:44:54'),
('ホテルのキッズクラブは充実しており、子供たちも大喜びでした。', 25, '6aa2cd80-8f77-4f1f-9cbc-27063301003a', '2023-04-03 07:08:09'),
('ホテルのロケーションは最高で、観光にも最適でした。', 26, '2ae61931-9339-4d33-9fea-d38d17980fc8', '2023-06-02 04:43:37'),
('エアコンの温度調整が粗く、暑すぎたり寒すぎたりした。', 27, '15cccc89-675c-4b2c-975c-6f28c3bc91ab', '2023-02-11 14:36:31'),
('楽しみにしていたプールが予想外に人も多くて十分に楽しめなかったのが少し残念だった。', 28, '59d63e0f-5305-4223-b12f-33f66e4b6a29', '2023-08-25 14:19:57'),
('部屋に備え付けられていた枕が、ちょっと固くて首が痛くなった。何種類か選べると嬉しい。', 29, 'dd9d821e-6245-417e-b118-5f0e7c1c10f1', '2023-01-18 16:31:36'),
('館内の案内表示が少なく、地図がないと迷子になりそうだった。', 30, '2a332d9d-d7f4-407e-b440-254f43c949ba', '2023-05-25 23:39:49'),
('料理の味付けが濃いめだったので若干好みに合わなかった。少し薄味のものもあるとよい。', 31, '9c0361c8-65f1-40e1-ae71-cb571cfdd840', '2023-10-26 15:08:17'),
('部屋の冷蔵庫が小さめだったので入らないものがあった。', 32, '436c2184-b80a-4129-9b7f-e9ca593d0288', '2023-05-21 05:03:58'),
('フロントの対応が事務的であまり親切に感じなかった。', 33, 'e98ac4ba-d74e-49e0-a3ff-ac6bdd780bec', '2022-05-03 04:12:03'),
('フロントの方が忙しそうだったのでちょっと話しかけづらかった。', 34, '30daaa88-b67a-4783-9fa5-651aa5e55dc1', '2022-07-25 17:29:00'),
('チェックイン時に予約していた部屋とは異なる部屋に案内された。', 35, '12ee422c-5143-4d7d-b313-991af6e53f10', '2021-10-14 10:50:07'),
('朝食バイキングの看板メニューが人気すぎて品切れになってしまっていた。', 36, '41f52e4c-f81e-438f-a1a3-b94bb8c525f4', '2023-02-09 08:20:41'),
('ホテルのレストランはおいしく、ルームサービスも充実していました。', 37, '7a0e14ef-a665-47b5-a326-054f57ba30ff', '2023-04-16 15:50:11'),
('朝食は美味しく、種類も豊富でした。', 38, 'bd6d80c0-b3a4-4483-93a2-0e17edf24349', '2023-11-01 06:27:03'),
('ホテル内のレストランの食事がおいしかったです。', 39, '7dc24a81-d7ed-4ac7-8049-5be2ab34e92a', '2023-01-08 09:42:22'),
('ホテル周辺にコンビニエンスストアやスーパーマーケットなどがないため、買い物に不便だった。', 40, 'a41bd4c4-4577-4837-8d73-784d7a78dc0e', '2020-12-30 10:29:41'),
('ホテル周辺には観光スポットがたくさんあり、退屈しませんでした。', 41, '34c6133a-016e-4333-823b-d4a083056482', '2023-04-14 11:37:51'),
('夜は静かで、ゆっくりと休むことができました。', 42, '9bdf826f-c2ac-4cb0-bffd-88593bf836e7', '2023-03-31 11:12:44'),
('ビーチもすぐ近くにあり、とても便利でした。', 43, '9f4c7847-9492-485d-8dbd-d6a46c1f6cda', '2023-04-30 21:05:40');
