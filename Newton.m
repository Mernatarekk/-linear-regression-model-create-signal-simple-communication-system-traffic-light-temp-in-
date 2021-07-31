f=@(x) x^3+4*x^2+4*x+3;
df=@(x) 3*x^2+8*x+4;
x0=input('Enter the value of initial guess:\n');
e=input('Enter the value of tolerance:');

if df(x0)==0
    fprintf('not a good initial solution\n');
    return
end
fprintf('i     xi\n');
fprintf('--------\n');
fprintf('0 %f \n',x0);
for i=1:n
    x1=x0-f(x0)/df(x0);
    fprintf('%i %f\n',i,x1);
    if abs(f(x1))<e
        return
    end
    x0=x1;
end    
