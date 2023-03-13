# Scanning FCS
## できること
+ 蛍光強度減衰の補正<br>
+ 補正した蛍光強度に基づく相関関数の計算<br>
→時間相関（各ピクセルの平均）/時間相関（任意の１ピクセル）/ 時空間相関　から選択可
+ 相関関数のフィッティング<br>
→１成分拡散/２成分拡散モデルを選択可
+ 相関関数のプロット<br>
+ 拡散時間、拡散係数の導出
 
## 使い方
注：DATE = yymmddの形にしてください (例：23年１月12日→ 230112)

### ①LSMデータを加える<br>
+ input > DATE > lsm > 全lsmファイル　という階層構造にする<br>
(例：input > 230112 > lsm > G-TDP25_01_line1_0.762ms.lsm, G-TDP25_01_line2_1.53ms.lsm・・)

### ②測定条件の入力<br>
+ measurement_conditions > DATE > script_conditions_DATE.m　という階層構造にする<br>
(例：measurement_conditions > 230112 > script_conditions_230112.m)

+ "script_conditions_DATE.m"を実験条件に応じて変更<br>
filename: 上記①においてinput>DATE>lsmフォルダ内に加えたlsmファイルの名前にする。<br>
（例：filename = G-TDP25_01_line1_0.762ms.lsm, filename = G-TDP25_01_line2_1.53ms.lsm)

### ③mainファイルを動かす<br>
1. スクリプト上部の『要変更！！』セクションを適宜する<br>
2. 実行（緑の?を押す）

**実行して得られるものと保存場所**<br>
★プロットはpng形式, fig形式(matlabで開ける)の両方で保存されます★<br>
+ 補正前と補正後の蛍光強度プロット→"output/DATE/sample_name"フォルダ内<br>
+ ACFプロット→　"output/DATE/sample_name"フォルダ内<br>
+ 拡散係数、拡散時間などのパラメータ→"workspace/DATE/important_parameters.mat"<br>
+ ワークスペース（プログラム実行時の変数)→"workspace/DATE/ACFの種類_filename.mat"<br>

## デモ

## 注意
エラー原因
①fittingの初期値
初期値を変えるとうまくいく

②

## 連絡
mail to: zakishima.39@icloud.com

## Todo
τの間隔設定
τの個数上限
全choiceの挙動を確認