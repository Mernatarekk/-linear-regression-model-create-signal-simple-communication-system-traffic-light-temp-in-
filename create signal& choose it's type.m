clear;
clc;
fprintf('GENERAL SIGNAL GENERATOR \n');

% USER INPUTS %
Freq = 'Sampling Frequency value: ';
f = input(Freq);
Start = 'Start of time scale value: ';
s = input(Start);
End = 'End of time scale value: ';
e = input(End);
Break_Points = 'Enter Number of break points: ';
b = input(Break_Points);
fprintf('NOTE!! Please select positions between start and end ! \n');
fprintf('NOTE!! If there is no break_points please write only [] ! \n');
Positions = 'Enter Position of break points with [] around them: ';
p = input(Positions);

% CHOOSING THE SIGNALS %
Y_Plot = []; 
T_Plot = [];
points = [s p e] %Array inculdes [start_point  positions_of_breakpoints  end]
regions = length(p) + 1; 
for i=1:regions
    fprintf('Please select signal in region : %d \n',i)
    signal = 'For DC signal Press(0) \nFor RAMP signal Press(1) \nFor EXPONENTIAL signal Press(2) \nFor POLYNOMIAL  signal Press(3) \nFor SIN signal Press(4) \n';
    signal_type = input(signal);
    
    start_point = points(i);
    end_point = points(i+1);
    t=linspace(start_point,end_point,(end_point-start_point)*f);
    
    switch signal_type
        case 0
           fprintf('DC SIGNAL Specifications \n');
           am = 'Amplitude value: ';
           amplitude = input(am);
           y=(amplitude)*ones(1,(end_point-start_point)*f);
   
        case 1
            fprintf('RAMP SIGNAL Specifications \n');
            intersection = 'intersection point : ';
            int = input(intersection);
            s = 'slope value : ';
            slope = input(s);
            y=(slope)*t+int;
     
        case 2
            fprintf('EXPONENTIAL SIGNAL Specifications \n');
            am = 'amplitude value';
            amplitude = input(am);
            e = 'exponent';
            exponent = input (e);
            y=(amplitude)*exp(exponent*t);
          
        
        case 3
            fprintf('POLYNOMIAL SIGNAL Specifications \n');
            power = 'Enter maximum power value : ';
            po = input(power);
            coefficients = 'Enter Position of break points with [] around them: ';
            co = input(coefficients);
            m=0;
            y=0;
            for j=po:-1:0
                z = co(m+1)*(t.^j);
                y = z + y; 
            end 
       
        case 4 
            fprintf('SINUSOIDAL SIGNAL Specifications \n');
            am = 'amplitude value';
            amplitude = input(am);
            ph = 'phase value';
            phase= input(ph);
            F = 'frequency value';
            freq = input(F);
            y= (amplitude)*sin((2*pi*freq*t)+(phase*2*pi)/180); 
        
        otherwise 
            fprintf('ERROR in choosing signal type \n');
       
    end
    Y_Plot = [Y_Plot y];
    T_Plot = [T_Plot t];
end

% PLOTING THE FINAL SIGNAL %
figure
hold on
title('THE MAIN SIGNAL')
plot(T_Plot,Y_Plot)
hold off
refer=0;
while refer==0
    while true
    
% OPERATIONS ON THE MAIN SIGNAL %
fprintf('Please select the operation on signal : \n \n')
    OP = 'For AMPLITUDE SCALING Press(0) \nFor TIME REVERSAL Press(1) \nFor TIME SHIFT  Press(2) \nFor EXPANDING signal Press(3) \nFor COMPRESSING signal Press(4) \nFor NONE Press (5)\n';

    operation = input(OP);
    if operation>= 0&& operation<6
        break;
    end 
    end 

Y2_Plot = Y_Plot;
T2_Plot = T_Plot;

switch operation
        case 0
            fprintf('AMPLITUDE SCALING \n');
            amp = 'amplitude scale value :';
            A_Scale = input(amp);
            Y2_Plot = A_Scale.*Y_Plot;
            refer=0;
            
        case 1
            fprintf('TIME REVERSAL \n');
            T2_Plot = T_Plot.*-1;
            refer=0;
        case 2
            fprintf('TIME SHIFT \n');
            ts = 'shift value :';
            T_Shift = input(ts);
            T2_Plot = T_Shift+T_Plot;
            refer=0;
        case 3
            fprintf('EXPANDING THE SIGNAL \n');
            ex = 'please enter number greater than 0 and less than 1 :';
            expanding = input(ex);
            T2_Plot = expanding.*T_Plot;
           refer=0;
        case 4
            fprintf('COMPRESSING THE SIGNAL \n');
            comp = 'please enter number greater than 1 :';
            compression = input(comp);
            T2_Plot = compression.*T_Plot;
            refer=0;
        case 5
            fprintf('NONE \n');
              refer=1;
            Y2_Plot = Y_Plot;
            T2_Plot = T_Plot; 
            
end
 if refer==0
% PLOTING THE SIGNAL WITH THE DESIRED OPERATION %
figure
hold on
title('SIGNAL AFTER PERFORMING THE OPERATION')
plot(T2_Plot,Y2_Plot)
hold off
 end
end
