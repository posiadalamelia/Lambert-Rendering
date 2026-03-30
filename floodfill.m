function Im1 = floodfill(Im, m, n, T, C)
  % wypelnia obszar pojedynczego kanalu obrazu na kolor
  % T kolor tla
  % C kolor wypelninia
  % (m,n) wpsolrzedne y i x punktu startowego
  if Im(m,n) ~= T
    disp('wrong initial pixel');
    Im1 = Im;
    return ;
  endif

  Im1 = Im;
  [Y,X] = size(Im);
  que_init = 1; y(que_init) = m; x(que_init) = n;
  Im(y(que_init), x(que_init)) = C;
  que_end = 1;

  while que_init <= que_end
    if y(que_init)+1<=Y
      if Im1(y(que_init)+1,x(que_init)) == T
        Im1(y(que_init)+1,x(que_init)) = C; que_end = que_end +1;
        y(que_end) = y(que_init)+1;x(que_end) = x(que_init);
      endif
    endif
    if y(que_init)-1>0
      if Im1(y(que_init)-1,x(que_init)) == T
        Im1(y(que_init)-1,x(que_init)) = C; que_end = que_end +1;
        y(que_end) = y(que_init)-1;x(que_end) = x(que_init);
      endif
    endif
    if x(que_init)+1<=X
      if Im1(y(que_init),x(que_init)+1) == T
        Im1(y(que_init),x(que_init)+1) = C; que_end = que_end +1;
        y(que_end) = y(que_init);x(que_end) = x(que_init)+1;
      endif
    endif
    if x(que_init)-1>0
      if Im1(y(que_init),x(que_init)-1) == T
        Im1(y(que_init),x(que_init)-1) = C; que_end = que_end +1;
        y(que_end) = y(que_init);x(que_end) = x(que_init)-1;
      endif
    endif
    que_init = que_init+1;
  endwhile
endfunction
