str = input('Give an equation in x: ','s')  ;
a='intial value:';
i=input(a);

b='final value:';
f=input(b);

n='number of segmants:';
num=input(n);


h=(f-i)/num ;

x_a=[];
y_a=[];
for x=i:h:f
    
   z = inline(str,'x') ;
   y = feval(z,x) ;
   disp(['"' str '", for x = ' num2str(x) ', equals ' num2str(y)]) ;
  x_a=[x_a x];
  y_a=[y_a y];
end

  x_a
  y_a
  
  s=y_a(1)+y_a(num+1);
  
  for k=2:2:num
      s=s+4*y_a(k);
  end 
  
  for k=3:2:num-1
      s=s+2*y_a(k);
  end
  s=(h/3)*s