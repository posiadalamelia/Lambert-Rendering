function Im2 = linia1(Im1,yp,xp,yk,xk,C)
  % rysowanie linii w pojedynczym kanale obrazu Im1
  % od punktu (yp,xp) do punktu (yk, xk)
  [Y, X] = size(Im1);
  Im2 = Im1;

  if (abs(yk-yp) > abs(xk-xp)) % stroma linia
    x0 = yp;y0 = xp; x1 = yk;y1 = xk; % zamiana wspolrzednych
    zamiana =1;
  else
    x0 = xp;y0 = yp; x1 = xk;y1 = yk;
    zamiana = 0;
  endif

  if zamiana==1 temp=X; X=Y; Y=temp; endif % zamiana rozmiarow X i Y

  if(x0 >x1) % zamiana poczatku i konca linii
    temp1 = x0; x0 = x1; x1 = temp1;
    temp2 = y0; y0 = y1; y1 = temp2;
  endif

  dx = abs(x1 - x0) ; % odleglosc x
  dy = abs(y1 - y0); % odleglosc y

  sx = sign(x1 - x0); % znak przyrostu w kierunku x(zbedne)
  sy = sign(y1 - y0); % znak przyrostu w kierunku y
  x = x0; y = y0; % inicjalizacja

  if x>0 && x<=X && y>0 && y<=Y
    if (zamiana ==0)
      Im2(y,x) = C; % rysowanie punktu
    else
      Im2(x,y) = C;
    endif
  endif

  error = 2*dy - dx ; % inicjalizacja bledu

  for i = 0:dx-1
    error = error + 2*dy; % modyfikacja bledu
    if (error >0)
      y = y +sy;
      error = error - 2*(dx );
    endif
    x = x + sx; % zwiekszamy x
    if x>0 && x<=X && y>0 && y<=Y
      if (zamiana ==0)
        Im2(y,x) = C; % rysowanie punktu
      else
        Im2(x,y) = C;
      endif
    endif
  endfor
endfunction
