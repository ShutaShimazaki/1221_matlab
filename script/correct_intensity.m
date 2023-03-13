%% Correct for deplation due to photobleaching
%   Eq.4  
%   doi: 10.1016/j.bpj.2008.12.3888

%% �␳�O�̌u�����x���v���b�g
XT_oneline = ones(TIME_SERIES, 1);
XT_corrected_oneline = ones(TIME_SERIES, 1);
for i = 1:TIME_SERIES %���鎞��i�ɂ�����S�s�N�Z���̌u�����x�𕽋ς���
    XT_oneline(i) = mean(XT(i,:));
end
p = plot(1:TIME_SERIES, XT_oneline) %�����F�X�L������, �c���F�u�����x

%% �u�����x�̕␳�����s
dataframe_bleaching = table((1:TIME_SERIES)',XT_oneline);
%����`��A
beta0_bleaching = [15, 5,10^-5, 10^-2];
modelfun_bleaching = @(b, t) b(1).*exp(-b(3).*t) + b(2).*exp(-b(4).*t); % 2�d�w���֐�  A*exp(-C*t) + B*exp(-D*t)
mdl_bleaching = fitnlm(dataframe_bleaching, modelfun_bleaching, beta0_bleaching)
parms_bleaching = (mdl_bleaching.Coefficients.Estimate)';
decay_multiexp = (modelfun_bleaching(parms_bleaching,1:TIME_SERIES))';

XT_corrected = XT;
for i = 1:TIME_SERIES   
    %doi: 10.1016/j.bpj.2008.12.3888, Eq.4 
    XT_corrected(i,:) = XT(i,:) ./ sqrt(decay_multiexp(i) ./ decay_multiexp(1)) +  decay_multiexp(1).*(1-sqrt(decay_multiexp(i)./decay_multiexp(1)));
end

% ������\���w���֐����v���b�g
figure;
plot(1:TIME_SERIES, XT_oneline)
hold on;
plot(1:TIME_SERIES, decay_multiexp)
legend("���Ƃ̌u�����x", "�w���֐��F�@" + func2str(modelfun_bleaching));
xlabel("�X�L������", 'FontSize',14,'FontWeight','bold');
ylabel("�u�����x", 'FontSize',14,'FontWeight','bold');
title(sprintf("�u�����x�̌��� %s",sample_name));
figurename = erase(filename, ".lsm");
saveas(gcf, sprintf("output/%s/%s/decay_intensity %s.fig",DATE, sample_name,figurename))
saveas(gcf, sprintf("output/%s/%s/decay_intensity %s.png",DATE, sample_name,figurename))

%% �␳��̌u�����x���v���b�g
for i = 1:TIME_SERIES
    XT_corrected_oneline(i) = mean(XT_corrected(i,:));
end
figure;
plot(1:TIME_SERIES, XT_corrected_oneline); %�����F�X�L������, �c���F�u�����x
xlabel("����", 'FontSize',14,'FontWeight','bold');
ylabel("�u�����x", 'FontSize',14,'FontWeight','bold');
title(sprintf("�␳�����u�����x %s",sample_name));
saveas(gcf, sprintf("output/%s/%s/corrected_intensity %s.fig",DATE, sample_name,figurename))
saveas(gcf, sprintf("output/%s/%s/corrected_intensity %s.png",DATE, sample_name,figurename))