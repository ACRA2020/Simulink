%%This script creates a cell structure with 3 positions, each of one with
%%an specific Ventilator pressure and PEEP. 

clc
clear all

Pmax=[28 33.5 28];
PEEP=[8 5 8];

%Repiratory rate
RR=18;

%Inspiratory time
t_ins=1;


period=60/RR;
cycles=7;
for h=1:3
    Tvent{h} =[];
    Pvent{h} = [];
    Pin_num = [];
    t=[];
    P=Pmax(h);
    PEEPv=PEEP(h);
    
    ts=0.1;
    eta=0.75;

    a=1.1;
    c_esp_1=35;
    c_esp_2=t_ins*a;
    
    c=1;
    step=0.001;

    for i=1:period*cycles/step
        t(i)=i*step;
        time=i*step-((c-1)*period);
        if (c*period) < t(i) 
            c=c+1;
        end
        if t(i) - ((c-1)*period) < t_ins *0.9
            Pin_num(i)=PEEPv+(P-PEEPv)*(1-((2.71.^-(eta*time/ts)).*((cos(time/ts*(1-eta^2)^0.5))+(eta/((1-eta^2)^0.5)*sin(time/ts*(1-eta^2)^0.5)))));
        else 
            Pin_num(i)=PEEPv+(P-PEEPv)*(1-(1+2.71.^(-c_esp_1*((time)-c_esp_2))).^-1);
        end
    end
    
    step = 0.01;
    Tvent{h} =(0:step:period*cycles);
    Pvent{h} = (interp1(t,Pin_num,Tvent{h},'spline'));
end

save('Tvent.mat','Tvent');
save('Pvent.mat','Pvent');

figure(1)
plot(Tvent{2},Pvent{2},'LineWidth',1.5)


