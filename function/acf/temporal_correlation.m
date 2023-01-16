function [TAU, COR] = temporal_correlation(XT, TIME_SCALE,NUMBER_TAU)
%% 変数宣言
TIME_SERIES = size(XT,1); %1000
PIXEL = size(XT,2); %32
%% 事前割り当て
TAU = zeros(1,NUMBER_TAU);
TAU_BETWEEN = round(logspace(0, 2, NUMBER_TAU)); %対数的に等間隔なNUMBER_TAU個の点を生成。
COR = zeros(1,NUMBER_TAU); % （τの個数）
%% ACF (multiple tau)
for tau = 1: NUMBER_TAU
    count = 0;
    tmpCOR = 0;
    
    %疑似画像中のマスを全網羅し、F(x,t) * F(x+KSAI, t+tau)を行う
    for x = 1 : PIXEL
        for t = 1:TIME_SERIES %1000
            if (t+ TAU_BETWEEN(tau) > TIME_SERIES)
                break
            end
            tmpCOR = XT(t,x) * XT(t+TAU_BETWEEN(tau), x) + tmpCOR;
            count = count + 1;
        end
    end
    COR(tau) = tmpCOR ./ count;
    TAU(tau) = TIME_SCALE * TAU_BETWEEN(tau);
end
           
%% 平均蛍光強度の２乗 F(x,t)^2で規格化
average_F2 = mean(XT,'all')^2;
COR = COR./average_F2;

end


