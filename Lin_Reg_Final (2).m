clear;
clc;

n = str2double(inputdlg('Enter number of points:'));
X = [];
Y = [];
X_2=[];
XY=[];
for i = 1 : n
        x(i) = str2double(inputdlg(['Enter x#' num2str(i) '']));
        y(i) = str2double(inputdlg(['Enter y#' num2str(i) '']));
   end
 model = str2double(inputdlg(sprintf('Enter the desired model :\n1. Linear regression\n2. Exponential model\n3. Power model\n4. Growth rate model')));
 
 switch model
     case 1
            for i = 1 : n
                X_2=[X_2 x(i).^2];
                XY=[XY x(i).*y(i)];
            end
            x_plot = x; 
            y_plot = y;
            X=sum(x)
            Y=sum(y)
            X_2=sum(X_2)
            XY=sum(XY)

            syms a0 a1
            equ1 = n*a0 + X*a1  == Y ;
            equ2 = X*a0 + X_2*a1 == XY ;
            [A,B] = equationsToMatrix([equ1,equ2],[a0,a1]);
            SOLVE = linsolve(A,B);
            a0=SOLVE(1);
            a1=SOLVE(2);
            a = double(a0)
            b = double(a1)
            % a=a0
            % b=a1

            x_axis=x(1):0.01:x(end);
            y=a+b.*x_axis;
            plot(x_plot,y_plot,'o',x_axis,y,'-') 
            legend('data','exponential fit')
     case 2
            for i = 1 : n
                Y=[Y log(y(i))];
                X_2=[X_2 x(i).^2];
                XY=[XY x(i).*log(y(i))];
            end
            x_plot = x; 
            y_plot = y;
            X=sum(x)
            Y=sum(Y)
            X_2=sum(X_2)
            XY=sum(XY)

            syms a0 a1
            equ1 = n*a0 + X*a1  == Y ;
            equ2 = X*a0 + X_2*a1 == XY ;
            [A,B] = equationsToMatrix([equ1,equ2],[a0,a1]);
            SOLVE = linsolve(A,B);
            a0=SOLVE(1);
            a1=SOLVE(2);
            a=exp(double(a0))
            b=double(a1)

            x_axis=x(1):0.01:x(end);
            y=a*exp(x_axis.*b);
            plot(x_plot,y_plot,'o',x_axis,y,'-') 
            legend('data','exponential fit')
            
     case 3 
            for i = 1 : n
                X=[X log(x(i))];
                Y=[Y log(y(i))];
                X_2=[X_2 log(x(i)).^2];
                XY=[XY log(x(i)).*log(y(i))];
            end
            x_plot = x;
            y_plot = y;            
            X=sum(X)
            Y=sum(Y)
            X_2=sum(X_2)
            XY=sum(XY)

            syms a0 a1
            equ1 = n*a0 + X*a1  == Y ;
            equ2 = X*a0 + X_2*a1 == XY ;
            [A,B] = equationsToMatrix([equ1,equ2],[a0,a1]);
            SOLVE = linsolve(A,B);
            a0=SOLVE(1);
            a1=SOLVE(2);
            a=exp(double(a0))
            b=double(a1)

            x_axis=x(1):0.01:x(end);
            y=a*(x_axis.^b);
            plot(x_plot,y_plot,'o',x_axis,y,'-')
            legend('data','power model')
            
     case 4
           for i = 1 : n
                X=[X 1/x(i)];
                Y=[Y 1/y(i)];
                X_2=[X_2 (1/x(i)).^2];
                XY=[XY (1/x(i)).*(1/y(i))];
           end
           x_plot = x;
           y_plot = y;
           X=sum(X)
           Y=sum(Y)
           X_2=sum(X_2)
           XY=sum(XY)

           syms a0 a1
           equ1 = n*a0 + X*a1  == Y ;
           equ2 = X*a0 + X_2*a1 == XY ;
           [A,B] = equationsToMatrix([equ1,equ2],[a0,a1]);
           SOLVE = linsolve(A,B);
           a0=SOLVE(1);
           a1=SOLVE(2);
           a = 1 ./ double(a0)
           b = a.*double(a1)

           x_axis=x(1):0.01:x(end);
           y=(a.*x_axis)./(b+x_axis);
           plot(x_plot,y_plot,'o',x_axis,y,'-')
           legend('data','growth rate model')

 end