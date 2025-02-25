function [TAU, COR] = temporal_correlation(XT, TIME_SCALE,NUMBER_TAU)
%% ΟιΎ
TIME_SERIES = size(XT,1); %1000
PIXEL = size(XT,2); %32
%% OθΔ
TAU = zeros(1,NUMBER_TAU);
TAU_BETWEEN = round(logspace(0, 3, NUMBER_TAU)); %ΡΜΤuπέθFΞIΙΤuΘNUMBER_TAUΒΜ_πΆ¬B
COR = zeros(1,NUMBER_TAU); % iΡΜΒj
%% ACF (multiple tau)
for tau = 1: NUMBER_TAU
    count = 0;
    tmpCOR = 0;
    
    %^ζΜ}XπSΤ΅AF(x,t) * F(x+KSAI, t+tau)πs€
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
           
%% ½Οuυ­xΜQζ F(x,t)^2ΕKi»
average_F2 = mean(XT,'all')^2;
COR = COR./average_F2;

end