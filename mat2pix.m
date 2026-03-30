function [x,y] = mat2pix(m,n,dx,dy,i,j)
 T=[1/dx,0,0.5*m;...
    0,-1/dy,0.5*n;...
    0,0,1];

 vin=[i;j;1];
 vout = T*vin;
 x = round(vout(1)/vout(3));
 y = round(vout(2)/vout(3));
endfunction
