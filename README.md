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
 "script_conditions_DATE.m"（＝テンプレートファイル）を複製する<br>
+measurement_conditions > DATE(←新規作成する) > script_conditions_DATE.m　という階層構造にする<br>
(例：measurement_conditions > 230112 > script_conditions_230112.m)

+ "script_conditions_DATE.m"に変更と追記をする<br>
★このスクリプトに記述した全条件が解析対象になります★<br>
解析したいファイルの数だけスクリプト項目を増減させる<br>
**注**　filename: 上記①においてinput>DATE>lsmフォルダ内に加えたlsmファイルの名前にする。<br>
（例：filename = G-TDP25_01_line1_0.762ms.lsm, filename = G-TDP25_01_line2_1.53ms.lsm)

### ③mainファイルを動かす<br>
1. "main_template.m"を複製して、別のmainファイルをつくり、mainフォルダへ移動させる
2. スクリプト上部の『要変更！！』セクションを適宜する<br>
3. 実行（緑の三角ボタンを押す）

**実行して得られるものと保存場所**<br>
★プロットはpng形式, fig形式(matlabで開ける)の両方で保存されます★<br>
+ 補正前と補正後の蛍光強度プロット<br>→"output/DATE/sample_name"フォルダ内<br>
+ ACFプロット<br>→"output/DATE/sample_name"フォルダ内<br>
+ 拡散係数、拡散時間などのパラメータ<br>→"workspace/DATE/important_parameters.mat"<br>
+ ワークスペース（プログラム実行時の変数)<br>→"workspace/DATE/ACFの種類_filename.mat"<br>

## main.m挙動
最初に入力したmeasurement_conditions > DATE > script_conditions_DATE.m
**line1～63: 準備** <br>
measurement
**line64～109: メイン** <br>

## デモ

## 注意
### エラーメッセージと解決策<br>
①fittingでのエラー<br>
初期値を変えるとうまくいく

②ファイルやフォルダが存在しないというエラーメッセージ<br>
・script_conditionsファイルに入力した"filename"が間違っている可能性があります。<br>
→inputフォルダに加えたlsmファイル名と一致させるようにしてください。そして誤まった名前をもつファイルがmeasurement_conditionsフォルダに存在している可能性がありますので削除してください。

③Githubと連携したい場合は、scanning_fcs.prjをクリック。連携したいファイルやフォルダをプロジェクトに追加し、ソース管理からGithubコマンドを行う

### 場合に応じて変更
+ τの間隔設定："temporal_correlation.m" のTAU_BETWEENという変数で定義<br>
+ τの個数上限："main.m"のNUMBER_TAUという変数で定義<br>
**デフォルト：τ= TAU_BETWEEN *TIME_SCALE **<br>
・TAU_BETWEEN = 10^0～10^3の範囲で対数的に等間隔な100個の点=[1,2,3,・・, 870,933,1000]<br>
・TIME_SCALE＝スキャンで元のピクセルに戻ってくるまでの時間

## 連絡
mail to: zakishima.39@icloud.com

## その他　使っていたもの ![](images_onREADME/)
### 拡散係数のプロット
+ **完成例**<br>
![ex](images_onREADME/ビーズ径と拡散係数.png)<br>
+ **方法**
1. workspaceファイルのimportant_parametersという変数の中身をみる<br>
![important_parameters](images_onREADME/important_parameters.png)<br>
2. 以下のファイルへ貼り付ける<br>
banana > shimazaki > 解析 > "拡散係数プロットテンプレート"

### 複数の相関関数プロット<br>
+ **完成例**<br>
![ex2](images_onREADME/200nm_etc.png)<br>

+ **方法**<br>
 script > plot > overlay_diffusionCoefficient.mを使用<br>
１つ１つの相関関数を縦軸1～２に規格化し、重ねることができます
挙動確認後、デモ動画撮影
