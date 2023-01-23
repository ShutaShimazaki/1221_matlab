%% Correct for deplation due to photobleaching
%   Eq.4  
%   doi: 10.1016/j.bpj.2008.12.3888
%% �e��(�ʒu)�ɑ΂���loop
XT_corrected  
for i = 1:PIXEL
 
end

%% �u�����x�̌�����\�����d�w���֐�:multiexp �̐���
i =3;
intensity_x = XT(:,i); %��i�̌u�����xF(x=i ,t)
dataframe_bleaching = table([1:TIME_SERIES]',intensity_x);

beta0_bleaching = [20, 10,10^-5, 10^-2];
modelfun_bleaching = @(b, t) b(1).*exp(-b(3).*t) + b(2).*exp(-b(4).*t); % 2�d�w���֐�  A*exp(-t) + B*exp(-t)
mdl_bleaching = fitnlm(dataframe_bleaching, modelfun_bleaching, beta0_bleaching)
parms_bleaching = (mdl_bleaching.Coefficients.Estimate)'
decay_multiexp = (modelfun_bleaching(parms_bleaching,[1:TIME_SERIES]))';

figure;
plot(1:TIME_SERIES, intensity_x)
hold on;
plot(1:TIME_SERIES, decay_multiexp)
hold off;

% legend("���Ƃ̌u�����x", "�w���֐��F�@" + func2str(modelfun_bleaching));
% xlabel("�X�L������", 'FontSize',14,'FontWeight','bold');
% ylabel("�u�����x", 'FontSize',14,'FontWeight','bold');
% title("�␳�����u�����x");
%% �u�����x��␳
% Eq.4
intensity_corrected = intensity_x ./ sqrt(decay_multiexp ./ decay_multiexp(1)) +  decay_multiexp(1).*(1-sqrt(decay_multiexp./decay_multiexp(1)));
figure;
plot(1:TIME_SERIES, intensity_corrected);
% xlabel("����", 'FontSize',14,'FontWeight','bold');
% ylabel("�u�����x", 'FontSize',14,'FontWeight','bold');
% title("�␳�����u�����x");