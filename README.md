# Scanning FCS
## 概要
 
## 使い方　(LSMデータを読み込む～Fitting）
注：DATE = yymmddの形にしてください (例：23年１月12日→ 230112)
①LSMデータを加える
・input > DATE > lsm > 全lsmファイル　という階層構造にする
(例：input > 230112 > lsm > G-TDP25_01_line1_0.762ms.lsm, G-TDP25_01_line2_1.53ms.lsm・・)

②測定条件の入力
・measurement_conditions > DATE > script_conditions_DATE.m　という階層構造にする
(例：measurement_conditions > 230112 > script_conditions_230112.m)

・"script_conditions_DATE.m"を実験条件に応じて変更
filename: ①LSMデータを加えるにおいて、input>DATE>lsmフォルダ内に加えたlsmファイルの名前にする。
（例：filename = G-TDP25_01_line1_0.762ms.lsm, filename = G-TDP25_01_line2_1.53ms.lsm)

③mainファイルを動かす

ACFプロット→　"output/DATE//temporal_fitting %s.fig"
計算したいACFを選択（時間相関ならchoice = 1, 空間相関ならchoice = 2, 時空間相関ならchoice = 3)
## デモ

## 注意


## 連絡
mail to: zakishima.39@icloud.com