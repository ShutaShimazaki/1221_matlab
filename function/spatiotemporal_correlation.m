function [KSAI, TAU, COR] = spatiotemporal_correlation(XT,TIME_SCALE,X_SCALE)

% C(ksai, tau)を計算し適切なプロットを出力する。
%F(x, t) 
    %C(ksai=1, tau=2) = F(1,1)*F(2,3) + F(1,2)*F(2,
    %4)+//+F(x,t)*F(x+ksai, t+tau)+//+F(PIXEL, TIME_SERIES)*F(PIXEL+ksai,
    %TIME_SERIES+tau) ⇒COR(1,1)
    %C(ksai=1, tau=3) ⇒COR(1,3)
    %C(ksai=ksai_max, tau=tau_max)

%% 変数宣言
TIME_SERIES = size(XT,1); %1000
NUMBER_KSAI = size(XT,2); %KSAI_MAX = PIXEL数
NUMBER_TAU = NUMBER_KSAI; %TAUの個数

MIN_KSAI = -round(NUMBER_KSAI/2);
MAX_KSAI = MIN_KSAI+NUMBER_KSAI-1;
%% 事前割り当て
KSAI = zeros(1,NUMBER_KSAI);
TAU = zeros(1,NUMBER_TAU); %TAUの個数 = PIXEL数へダウンサンプリング
TAU_BETWEEN = round(logspace(0, 2, NUMBER_TAU)); %10^0 ~ 10^2の範囲に対数的に等間隔なPIXEL個の点を生成。
COR = zeros([NUMBER_KSAI, NUMBER_TAU]); % （τの個数）
% ACF
for tau = 1:NUMBER_TAU
    idx_ksai = 1;
    for ksai = MIN_KSAI: MAX_KSAI
        count = 0;
        tmpCOR = 0;
        %疑似画像中のマスを全網羅し、F(x,t) * F(x+KSAI, t+tau)を行う
        for x = 1 : NUMBER_KSAI
            for t = 1:TIME_SERIES %1000
                if (x+ksai > NUMBER_KSAI) || (x + ksai < 1) || (t+ TAU_BETWEEN(tau) > TIME_SERIES)
                    break
                end
                tmpCOR = XT(t,x) * XT(t+TAU_BETWEEN(tau), x+ksai) + tmpCOR;
                count = count + 1;
            end
        end
        KSAI(idx_ksai) = X_SCALE * ksai;
        TAU(tau) = TIME_SCALE * TAU_BETWEEN(tau);
        COR(tau, idx_ksai) = tmpCOR /count;
        idx_ksai = idx_ksai + 1;
    end
end
    
%% 平均蛍光強度の２乗 F(x,t)^2で規格化
average_F2 = mean(XT,'all')^2;
COR = COR./average_F2;

end

