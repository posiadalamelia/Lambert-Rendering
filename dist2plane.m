function [d,x1,y1,z1] = dist2plane(A,B,C,D,x,y,z,l,m,n) % parametry plaszczyzny, punktu, wektora kierunkowego
 d = NaN;
 ro = (A*x+B*y+C*z+D) / (A*l+B*m+C*n);
 x1 = x-l*ro;
 y1 = y-m*ro;
 z1 = z-n*ro;
 d = sqrt((x-x1)^2+(y-y1)^2+(z-z1)^2); % odleglosc dwoch punktow
endfunction

