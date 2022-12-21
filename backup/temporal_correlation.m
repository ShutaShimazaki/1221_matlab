function [TAU, COR] = temporal_correlation(XT, TIME_SCALE, KSAI)
% ������KSAI(�萔)�ɑ΂��āAC(KSAI, tau)���v�Z���K�؂ȃv���b�g���o�͂���B
%F(x, t) 
    %C(KSAI, tau=1) = F(1,1)*F(1+KSAI, 2) + F(1,2)*F(1+KSAI,
    %3)+//+F(x,t)*F(x+KSAI, t+tau)+//+F(PIXEL, TIME_SERIES)*F(PIXEL+KSAI,
    %TIME_SERIES+tau) ��COR(1)
    %C(KSAI, tau=2)
    %C(KSAI, tau=tau_max)

%% �ϐ��錾
TIME_SERIES = size(XT,1); %1000
PIXEL = size(XT,2); %32
TAU_MAX = PIXEL; %TAU�̌� = PIXEL���փ_�E���T���v�����O
%% ���O���蓖��
TAU = zeros(1,TAU_MAX);
TAU_BETWEEN = round(logspace(0, 2, TAU_MAX)); %10^0 ~ 10^2�͈̔͂ɑΐ��I�ɓ��Ԋu��PIXEL�̓_�𐶐��B
COR = zeros(1,TAU_MAX); % �i�т̌��j
%% ACF
for tau = 1: TAU_MAX
    count = 0;
    tmpCOR = 0;
    %�^���摜���̃}�X��S�ԗ����AF(x,t) * F(x+KSAI, t+tau)���s��
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
           
%% ���όu�����x�̂Q�� F(x,t)^2�ŋK�i��
average_F2 = mean(XT,'all')^2;
COR = COR./average_F2;

end


