function [Ish, A, B, C, D, n] = tr_Lambert1(r1, r2, r3, X, Y, dx, dy)
  Ish = uint8(zeros(Y, X));

  [i1, j1] = mat2pix(X, Y, dx, dy, r1(1), r1(2));
  [i2, j2] = mat2pix(X, Y, dx, dy, r2(1), r2(2));
  [i3, j3] = mat2pix(X, Y, dx, dy, r3(1), r3(2));

  Ish = linia1(Ish, j1, i1, j2, i2, 255);
  Ish = linia1(Ish, j2, i2, j3, i3, 255);
  Ish = linia1(Ish, j3, i3, j1, i1, 255);
  Ish = floodfill(Ish, round((j1+j2+j3)/3), round((i1+i2+i3)/3), 0, 255);
  [A, B, C, D, n] = calcPlaneNormal(r1, r2, r3);
endfunction
