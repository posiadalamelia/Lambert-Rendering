function [x,y] = pix2mat(m,n,dx,dy,i,j)

  T=[dx,0,-0.5*m*dx;...
     0,-dy,0.5*n*dy;...
      0,0,1];

  vin=[i;j;1];
  vout=T*vin;
  x=vout(1)/vout(3);
  y=vout(2)/vout(3);
endfunction
