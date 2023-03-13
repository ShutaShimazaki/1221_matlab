%% Correct for deplation due to photobleaching
%   Eq.4  
%   doi: 10.1016/j.bpj.2008.12.3888

%% 補正前の蛍光強度をプロット
XT_oneline = ones(TIME_SERIES, 1);
XT_corrected_oneline = ones(TIME_SERIES, 1);
for i = 1:TIME_SERIES %ある時間iにおける全ピクセルの蛍光強度を平均する
    XT_oneline(i) = mean(XT(i,:));
end
p = plot(1:TIME_SERIES, XT_oneline) %横軸：スキャン回数, 縦軸：蛍光強度

%% 蛍光強度の補正を実行
dataframe_bleaching = table((1:TIME_SERIES)',XT_oneline);
%非線形回帰
beta0_bleaching = [15, 5,10^-5, 10^-2];
modelfun_bleaching = @(b, t) b(1).*exp(-b(3).*t) + b(2).*exp(-b(4).*t); % 2重指数関数  A*exp(-C*t) + B*exp(-D*t)
mdl_bleaching = fitnlm(dataframe_bleaching, modelfun_bleaching, beta0_bleaching)
parms_bleaching = (mdl_bleaching.Coefficients.Estimate)';
decay_multiexp = (modelfun_bleaching(parms_bleaching,1:TIME_SERIES))';

XT_corrected = XT;
for i = 1:TIME_SERIES   
    %doi: 10.1016/j.bpj.2008.12.3888, Eq.4 
    XT_corrected(i,:) = XT(i,:) ./ sqrt(decay_multiexp(i) ./ decay_multiexp(1)) +  decay_multiexp(1).*(1-sqrt(decay_multiexp(i)./decay_multiexp(1)));
end

% 減衰を表す指数関数をプロット
figure;
plot(1:TIME_SERIES, XT_oneline)
hold on;
plot(1:TIME_SERIES, decay_multiexp)
legend("もとの蛍光強度", "指数関数：　" + func2str(modelfun_bleaching));
xlabel("スキャン回数", 'FontSize',14,'FontWeight','bold');
ylabel("蛍光強度", 'FontSize',14,'FontWeight','bold');
title(sprintf("蛍光強度の減衰 %s",sample_name));
figurename = erase(filename, ".lsm");
saveas(gcf, sprintf("output/%s/%s/decay_intensity %s.fig",DATE, sample_name,figurename))
saveas(gcf, sprintf("output/%s/%s/decay_intensity %s.png",DATE, sample_name,figurename))

%% 補正後の蛍光強度をプロット
for i = 1:TIME_SERIES
    XT_corrected_oneline(i) = mean(XT_corrected(i,:));
end
figure;
plot(1:TIME_SERIES, XT_corrected_oneline); %横軸：スキャン回数, 縦軸：蛍光強度
xlabel("時間", 'FontSize',14,'FontWeight','bold');
ylabel("蛍光強度", 'FontSize',14,'FontWeight','bold');
title(sprintf("補正した蛍光強度 %s",sample_name));
saveas(gcf, sprintf("output/%s/%s/corrected_intensity %s.fig",DATE, sample_name,figurename))
saveas(gcf, sprintf("output/%s/%s/corrected_intensity %s.png",DATE, sample_name,figurename))