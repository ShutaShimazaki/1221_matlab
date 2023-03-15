%%% LSM測定条件を入力するためのテンプレートファイルです %%%

%このファイルは入力した測定条件値を格納したワークスペースファイルを生成します。
%実際の測定条件に応じて値を変更してください
%全サンプル・全測定条件を入力してください。（今はSAMPLE1, 2のみですが、コピペしていってください）
 %★★大切：filenameはinput>DATE>lsmフォルダ内に加えたlsmファイルの名前にする。★★
 
%%%
%% G-TDP25
%測定条件入力
sample_name = "GFP-TDP25 0.763ms"; %sample_name: 任意 (作成されるプロット図のtitleになります）
filename = "G-TDP25_01_line1_0.762ms.lsm"; %input>DATE>lsmフォルダ内に加えたlsmファイルの名前にする。
isCorrected = "false"; %光褪色を補正する必要があるかないか。（falseかtrueで指定。デフォルトはfalse=なし）

X_SCALE = 0.022; %μm　
PIXEL_DWELL = 1.27 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 0.763 * 10^-3; %s　元の位置にもどってくるまでの時間              
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63; %μm

%ワークスペースファイルの生成
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));

%% G-TDP25
%測定条件入力
sample_name = "GFP-TDP25 1.53ms";
filename = "G-TDP25_01_line2_1.53ms.lsm";
isCorrected = "false";

X_SCALE = 0.022; %μm
PIXEL_DWELL = 2.55 *10^(-6); %s
PIXEL = 256;
TIME_SCALE = 1.53 * 10^-3; %s      
TIME_SERIES = 50000;
IMAGE_SIZE = 5.63; %μm

%ワークスペースファイルの生成
save(sprintf('measurement_conditions/%s/%s.mat',DATE, filename));
