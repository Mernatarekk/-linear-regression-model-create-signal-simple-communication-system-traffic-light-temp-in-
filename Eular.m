the_function   = 'enter function in x & y ,please enter @(x,y) before the function : ';
f = input(the_function );
stepsize  = 'enter stepsize : ';
h = input(stepsize);
Input1='enter intial value of x  : ';
x = input(Input1);
Input2='enter intial value of y : ';
y= input(Input2);
last_num ='enter last value of x  : ';
M= input(last_num);

for i=x:h:M-h; 
    
  y=y+h*f(x,y)
x=x+h;
end



