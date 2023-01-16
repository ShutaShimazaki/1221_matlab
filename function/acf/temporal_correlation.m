function [TAU, COR] = temporal_correlation(XT, TIME_SCALE,NUMBER_TAU)
%% �ϐ��錾
TIME_SERIES = size(XT,1); %1000
PIXEL = size(XT,2); %32
%% ���O���蓖��
TAU = zeros(1,NUMBER_TAU);
TAU_BETWEEN = round(logspace(0, 2, NUMBER_TAU)); %�ΐ��I�ɓ��Ԋu��NUMBER_TAU�̓_�𐶐��B
COR = zeros(1,NUMBER_TAU); % �i�т̌��j
%% ACF (multiple tau)
for tau = 1: NUMBER_TAU
    count = 0;
    tmpCOR = 0;
    
    %�^���摜���̃}�X��S�ԗ����AF(x,t) * F(x+KSAI, t+tau)���s��
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
           
%% ���όu�����x�̂Q�� F(x,t)^2�ŋK�i��
average_F2 = mean(XT,'all')^2;
COR = COR./average_F2;

end


