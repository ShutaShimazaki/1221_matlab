function [TAU, COR] = temporal_correlation(XT, TIME_SCALE, KSAI)
% 引数のKSAI(定数)に対して、C(KSAI, tau)を計算し適切なプロットを出力する。
%F(x, t) 
    %C(KSAI, tau=1) = F(1,1)*F(1+KSAI, 2) + F(1,2)*F(1+KSAI,
    %3)+//+F(x,t)*F(x+KSAI, t+tau)+//+F(PIXEL, TIME_SERIES)*F(PIXEL+KSAI,
    %TIME_SERIES+tau) ⇒COR(1)
    %C(KSAI, tau=2)
    %C(KSAI, tau=tau_max)

%% 変数宣言
TIME_SERIES = size(XT,1); %1000
PIXEL = size(XT,2); %32
TAU_MAX = PIXEL; %TAUの個数 = PIXEL数へダウンサンプリング
%% 事前割り当て
TAU = zeros(1,TAU_MAX);
TAU_BETWEEN = round(logspace(0, 2, TAU_MAX)); %10^0 ~ 10^2の範囲に対数的に等間隔なPIXEL個の点を生成。
COR = zeros(1,TAU_MAX); % （τの個数）
%% ACF
for tau = 1: TAU_MAX
    count = 0;
    tmpCOR = 0;
    %疑似画像中のマスを全網羅し、F(x,t) * F(x+KSAI, t+tau)を行う
    for x = 1 : PIXEL
        for t = 1:TIME_SERIES %1000
            if (x+KSAI > PIXEL) || (t+ TAU_BETWEEN(tau) > TIME_SERIES)
                break
            end
            tmpCOR = XT(t,x) * XT(t+TAU_BETWEEN(tau), x+KSAI) + tmpCOR;
            count = count + 1;
        end
    end
    COR(tau) = tmpCOR /count;
    TAU(tau) = TIME_SCALE * TAU_BETWEEN(tau);
end
           
%% 平均蛍光強度の２乗 F(x,t)^2で規格化
average_F2 = mean(XT,'all')^2;
COR = COR./average_F2;

end


