%% 選択
%①temporal(ksai=定数) ②spational(tau=定数)　③spatiotemporal
choice = 2;

%% 測定条件
X_SCALE = 0.176; %μm
PIXEL_DWELL = 25.7*10^(-6); %s
PIXEL = 32;
TIME_SCALE = 1.93 * 10^-3; %一方向のline_scanにおいて、元の位置に戻ってくるまでの時間間隔。ZENアプリから確認する。
TIME_SERIES = 1000;

%% インポート
addpath("function");
folderpath = "input/221028/100nm10000_pix180nm_T1.9ms_dwell25micro.lsm";
%folderpath = "input/221017/Retry after explanation/28nm_zoom35 - コピー.lsm";
XT = imread(sprintf("%s", folderpath));
XT = double(XT); 

%% 相関計算
if choice == 1
    KSAI = 3;
    %ACF
    [TAU, COR] = temporal_correlation(XT, TIME_SCALE, KSAI);
    %Fitting
    %Plot
    semilogx(TAU,COR)
    %semilogx(TAU,COR)
    xlabel('τ (s)');
    ylabel('Correlation(τ)');
    
elseif choice == 2
    TAU = 4;
    %ACF
    [KSAI, COR] = spatial_correlation(XT, X_SCALE, TAU);
    %Fitting
    %Plot
    plot(KSAI,COR)
    %semilogx(TAU,COR)
    xlabel('ξ (μm)');
    ylabel('Correlation(ξ)');
elseif choice == 3
end