%% インポート
% ワークスペースのクリア
clear; 

% 共通測定条件（要変更！！）
DATE = "230112";
SP = 10.5;

%パスを通す
addpath(genpath("function"));
addpath(genpath("script"));
addpath(genpath("output"));
addpath(genpath(sprintf("input/%s", DATE)));
addpath(genpath(sprintf("measurement_conditions/%s", DATE)));

%% mkdir (作成されるべきdirectoryが未だ存在しないならば、作成する）
    for folder_name = [sprintf("output/%s", DATE)  sprintf("workspace/%s", DATE)]
        if not(exist(folder_name,'dir'))
            mkdir(folder_name)
        end
    end
%% 最新のmeasurement_conditionsを反映
    run(sprintf("script_conditions_%s.m", DATE));
%% loop回すべき全ファイルを取得
files = dir(sprintf('measurement_conditions/%s/*.mat', DATE)); 
filename_array = string({files.name});
%% 重要なパラメータを保存する構造体を生成
COMPONENT = 2; %モデル式の成分の数
if COMPONENT == 1
    important_parameters_struct = struct('sample_name',{}, 'diffusion_coefficient', {},  'diffusion_time', {}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});
elseif COMPONENT == 2
    disp("hello")
    important_parameters_struct = struct('sample_name',{}, 'fast_diffusion_coefficient', {},  'fast_diffusion_time', {}, 'slow_diffusion_coefficient', {},  'slow_diffusion_time', {},'fast_fraction',{},'slow_fraction',{}, 'w_radius', {}, 'dwell_time', {},'time_scale', {},'image_size', {});    
end

%% 各測定条件についてloop
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx COMPONENT important_parameters_struct
    filename = filename_array(idx);
    sprintf("ファイル名は　%s　です", filename_array(idx))
    %測定データをload
    load(sprintf("measurement_conditions/%s/%s", DATE, filename))
   
    %% 蛍光強度の取得
    XT = imread(sprintf("input/%s/lsm/%s",DATE, filename));
    XT = double(XT);
    
    %光褪色に起因する、蛍光強度の減衰を補正
    if isCorrected == "true"
        run("correct_intensity.m")
        XT = XT_corrected;
    end
    %% 選択
    %①temporal(ksai=定数) ②spational(tau=定数)　③spatiotemporal
    choice = 5;
    %% 相関計算
    if choice == 1 %temporal
        NUMBER_TAU = 100; % tauの個数（＝上限）を設定
        %ACF
        [TAU, COR] = temporal_correlation(XT, TIME_SCALE, NUMBER_TAU);
        %Run Fitting
         run("fitting_temporal.mlx")
        %Run Plot
         run("temporal_plots.mlx")
        %Run Calculation for DiffusionCoefficient
         w_radius = 0.199; %[?]　fcsのcalibrationより得る("calculate_w0.mlx")
         run("calculate_diffusion_coefficient.mlx")
        %Run compare 
         %run("compare_with_zen.mlx")
        %Save workspace
         save(sprintf('workspace/%s/temporal_%s.mat',DATE, filename))
        
        

    elseif choice == 2
        constant_T = 2;
        %ACF
        [KSAI, COR] = spatial_correlation(XT, X_SCALE, constant_T);
        %Fitting
        %Plot
        plot(KSAI,COR)
        %semilogx(TAU,COR)
        xlabel('ξ (μm)','FontSize',14,'FontWeight','bold');
        ylabel('Correlation(ξ)','FontSize',14,'FontWeight','bold');

    elseif choice == 3
        %ACF
        [KSAI, TAU, COR] = spatiotemporal_correlation(XT,TIME_SCALE,X_SCALE);
        COR(isnan(COR)) = 0; %NaNを0に置換する
       %% 

        %Run fitting
        SP = 7;
        run("fitting_spatiotemporal.mlx")

        %Run plot
        run("spatiotemporal_plots.mlx")
        
    elseif choice == 4
        constant_X = 3  ;
        %ACF
        [TAU, COR] = xcorr_temporal_correlation(XT, TIME_SCALE, constant_X);
        %Fitting
        run("fitting_temporal.mlx")
        %Plot
        semilogx(TAU,COR)
        xlabel('τ (s)');
        ylabel('Correlation(τ)');
        
    elseif choice == 5
    constant_X = 3 ;
    NUMBER_TAU = 100; % tauの個数（＝上限）を設定
    %ACF
    [TAU, COR] = constantX_temporal_correlation(XT, TIME_SCALE, constant_X, NUMBER_TAU);
    %Run Fitting
     run("fitting_temporal.mlx")
    %Run Plot
     run("temporal_plots.mlx")
    %Run Calculation for DiffusionCoefficient
     w_radius = 0.151; %[?]　fcsのcalibrationより得る("calculate_w0.mlx")
     run("calculate_diffusion_coefficient.mlx")
    %Run compare 
     %run("compare_with_zen.mlx")
    %Save workspace
     save(sprintf('workspace/%s/X_temporal_%s.mat',DATE, filename))


    end
%     %% save result on workspace file
%     save(sprintf('workspace/%s/%s.mat',DATE, filename))
%     clearvars -except filename_array DATE
end

%% 拡散係数などの大事なパラメータを格納した構造体を保存
save(sprintf('workspace/%s/important_parameters.mat',DATE), 'important_parameters_struct');