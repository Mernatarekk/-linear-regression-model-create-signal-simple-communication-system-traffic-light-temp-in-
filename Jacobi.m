clear;
clc;

a = [0 0 0; 0 0 0; 0 0 0]; % COEFFICIENTS MATRIX
b = [0 0 0]; % FREE TERMS VECTOR
x = [0 0 0]; % INITIAL VALUES VECTOR

for i=1:9
    a(i) = str2double(inputdlg(['To fill coefficients matrix, #' num2str(i) ':']));
end

for i=1:3
    b(i) = str2double(inputdlg(['To fill free terms vector, #' num2str(i) ':']));
end

for i=1:3
    x(i) = str2double(inputdlg(['To fill initial values: #' num2str(i) ':']));
end

numberOfIterations = str2double(inputdlg(['Number of iterations:']));

% a = [9 -2 6; 3 6 -2; 6 -1 8];
% b = [9 15 4.5];
% x = [0 0 0];
% numberOfIterations = 3;
    
for i=1:numberOfIterations % PERFORMING JACOBI'S METHOD I TIMES
    x1 = (b(1) - a(1,2) * x(2) - a(1,3) * x(3)) ./ a(1,1);
    x2 = (b(2) - a(2,1) * x(1) - a(2,3) * x(3)) ./ a(2,2);
    x3 = (b(3) - a(3,1) * x(1) - a(3,2) * x(2)) ./ a(3,3);
    
    x = [x1 x2 x3] % UPDATING THE INTIIAL VALUES MATRIX AND RE-USING IT INSIDE THE LOOP
    % THE FINAL OUTPUT WILL BE SHOWN IN COMMAND WINDOW
end