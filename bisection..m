f=@(x) x^2+log(x)
Input1='enter intial value of a  : ';
a = input(Input1);
Input2='enter intial value of b: ';
b= input(Input2);
last_num ='no of turns  ';
n= input(last_num);

c = f(a); d = f(b);
if c*d > 0.0
    error('Function has same sign at both endpoints.')
end
disp('           x                  y')
for i = 1:n-1
    x = (a + b)/2;
    y = f(x);
    disp([   x     y])
    if y == 0.0     % solved the equation exactly
        e = 0;
        break      % jumps out of the for loop
    end
    if c*y < 0
        b=x;
    else
        a=x;
    end
end
e = (b-a)/2;