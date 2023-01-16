%% インポート
% ワークスペースのクリア
clear; 

% 共通測定条件（要変更！！）
DATE = "221209";
SP = 7;

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
%% 各測定条件についてloop
for idx=1:length(filename_array)
    clearvars -except filename_array DATE idx
    filename = filename_array(idx);
    sprintf("ファイル名は　%s　です", filename_array(idx))
    %測定データをload
    load(sprintf("measurement_conditions/%s/%s", DATE, filename))
   
    %%
    XT = imread(sprintf("input/%s/lsm/%s",DATE, filename));
    XT = double(XT);
   
    %% 選択
    %①temporal(ksai=定数) ②spational(tau=定数)　③spatiotemporal
    choice = 1;
    %% 相関計算
    if choice == 1 %temporal
        NUMBER_TAU = 100; % tauの個数（＝上限）を設定
        %ACF
        [TAU, COR] = temporal_correlation(XT, TIME_SCALE, NUMBER_TAU);
        %Run Fitting
         run("fitting_temporal.mlx")
        %Run Plot
         run("temporal_plots.mlx")
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


    end
%     %% save result on workspace file
%     save(sprintf('workspace/%s/%s.mat',DATE, filename))
%     clearvars -except filename_array DATE
end