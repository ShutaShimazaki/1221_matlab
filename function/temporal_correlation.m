function [TAU, COR] = temporal_correlation(XT, TIME_SCALE, X)
%定点(X)における時間相関を求める
%% 変数宣言
TIME_SERIES = size(XT,1); %1000
PIXEL = size(XT,2); %32
TAU_MAX = 100; %TAUの個数 = PIXEL数へダウンサンプリング
%% 事前割り当て
TAU = zeros(1,TAU_MAX);
TAU_BETWEEN = round(logspace(0, 2, TAU_MAX)); %対数的に等間隔なTAU_MAX個の点を生成。
COR = zeros(1,TAU_MAX); % （τの個数）
%% ACF (multiple tau)
for tau = 1: TAU_MAX
    count = 0;
    tmpCOR = 0;
    %疑似画像中の任意の１列(x = X)について、F(X,t) * F(X, t+tau)を行う
    
    for t = 1:TIME_SERIES %1000
        if (X > PIXEL) || (t+ TAU_BETWEEN(tau) > TIME_SERIES)
            break
        end
        tmpCOR = XT(t,X) * XT(t+TAU_BETWEEN(tau), X) + tmpCOR;
        count = count + 1;
    end
    COR(tau) = tmpCOR /count;
    TAU(tau) = TIME_SCALE * TAU_BETWEEN(tau);
end
           
%% X列目の平均蛍光強度の２乗 F(x,t)^2で規格化
average_F2 = mean(XT(:, X),'all')^2;
COR = COR./average_F2;

end


