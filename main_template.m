%%%%%%% mainファイル概要 %%%%%%%
% ACF計算、フィッティング、プロットを自動で行います
% ACFプロット、各変数を保存したワークスペース、重要なパラメータ
%%%%%%%%%%%%%%
%% ワークスペースのクリア
clear; 
%% 要変更！！%%%
DATE = "230112"; %yymmdd
SP = 10.5; %structual parameter (校正サンプルを測定しZENで解析して得た値を入力）
w_radius = 0.199; %観察体積の半径を入力 （formula > calculate_w0.mlxファイルを実行すると計算してくれる）
COMPONENT = 2; %フィットモデル式の拡散成分の数（１か２を選択。詳細は"script>fitting>fitting_temporal.mlx"を参照。）
choice = 1; %計算したいACFの種類を選択
% ①時間相関(デフォルト。各ピクセルの時間相関の平均。) ②時間相関(任意の１ピクセル）③時空間相関　
%% パスを通す
addpath(genpath("function"));
addpath(genpath("script"));
addpath(genpath("output"));
addpath(genpath(sprintf("input/%s", DATE)));
addpath(genpath(sprintf("measurement_conditions/%s", DATE)));

%% 最新のmeasurement_conditionsを反映
    run(sprintf("script_conditions_%s.m", DATE));
%% loop回すべき全ファイルを取得
files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
filename_array = string({files.name});
%% 重要なパラメータ(拡散係数など）を保存する空構造体を生成
if COMPONENT == 1
    important_parameters_struct = struct('sample_name',{}, 'diffusion_coefficient', {},  'diffusion_time', {}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});
elseif COMPONENT == 2
    important_parameters_struct = struct('sample_name',{}, 'fast_diffusion_coefficient', {},  'fast_diffusion_time', {}, 'slow_diffusion_coefficient', {},  'slow_diffusion_time', {},'fast_fraction',{},'slow_fraction',{}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});    
end

%% mkdir (作成されるべきdirectoryが未だ存在しないならば、自動作成してくれる）
for folder_name = [sprintf("output/%s", DATE)  sprintf("workspace/%s", DATE) sprintf("output/%s/%s", DATE, sample_name) sprintf("output/%s/%s", DATE, sample_name)]
    if not(exist(folder_name,'dir'))
        mkdir(folder_name)
    end
end
%% 各測定条件についてloop
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx COMPONENT important_parameters_struct choice　w_radius
    filename = filename_array(idx);
    sprintf("ファイル名は　%s　です", filename_array(idx))
    %測定データをload
    load(sprintf("measurement_conditions/%s/%s", DATE, filename))
   
    %% LSMファイルをインポート
    XT = imread(sprintf("input/%s/lsm/%s",DATE, filename));
    XT = double(XT);
    
    %% 光褪色による蛍光強度の減衰を補正する
    run("correct_intensity.m")
    XT = XT_corrected;
    %% 相関計算
    if choice == 1 %%各ピクセルにおける時間相関の平均を計算する
        NUMBER_TAU = 100; % tauの個数（＝上限）を設定
        %ACF
        [TAU, COR] = temporal_correlation(XT, TIME_SCALE, NUMBER_TAU);
        %Run Fitting
         run("fitting_temporal.mlx")
        %Run Plot
         run("temporal_plots.mlx")
        %Run Calculation for DiffusionCoefficient
         run("calculate_diffusion_coefficient.mlx")
        %Run compare 
         %run("compare_with_zen.mlx")
        %Save workspace
         save(sprintf('workspace/%s/temporal_%s.mat',DATE, filename))
        
      elseif choice == 2 %定点X（＝1ピクセル)を選択。このピクセルだけの時間相関を計算する
        constant_X = 3 ; 
        NUMBER_TAU = 100; % tauの個数（＝上限）を設定
        %ACF
        [TAU, COR] = constantX_temporal_correlation(XT, TIME_SCALE, constant_X, NUMBER_TAU);
        %Run Fitting
         run("fitting_temporal.mlx")
        %Run Plot
         run("temporal_plots.mlx")
        %Run Calculation for DiffusionCoefficient
         run("calculate_diffusion_coefficient.mlx")
        %Run compare 
         %run("compare_with_zen.mlx")
        %Save workspace
         save(sprintf('workspace/%s/X_temporal_%s.mat',DATE, filename))
         
    elseif choice == 3 %時空間相関
        %ACF
        [KSAI, TAU, COR] = spatiotemporal_correlation(XT,TIME_SCALE,X_SCALE);
        COR(isnan(COR)) = 0; %NaNを0に置換する
        %Run fitting
        run("fitting_spatiotemporal.mlx")
        %Run plot
        run("spatiotemporal_plots.mlx")
        %Save workspace
         save(sprintf('workspace/%s/spatiotemporal_%s.mat',DATE, filename))
    end
end

%% 拡散係数などの大事なパラメータを格納した構造体を保存
save(sprintf('workspace/%s/important_parameters.mat',DATE), 'important_parameters_struct');
disp("---- Done! ----")