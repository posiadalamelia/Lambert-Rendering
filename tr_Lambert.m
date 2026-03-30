function [Im1,Ish] = tr_Lambert(Im, r1, r2, r3, Amb, lamp, Int, X, Y, dx, dy, eps)
  Im1 = Im;
  Ish = uint8(zeros(Y, X));

  [i1, j1] = mat2pix(X, Y, dx, dy, r1(1), r1(2));
  [i2, j2] = mat2pix(X, Y, dx, dy, r2(1), r2(2));
  [i3, j3] = mat2pix(X, Y, dx, dy, r3(1), r3(2));

  Ish = linia1(Ish, j1, i1, j2, i2, 255);
  Ish = linia1(Ish, j2, i2, j3, i3, 255);
  Ish = linia1(Ish, j3, i3, j1, i1, 255);
  Ish = floodfill(Ish, round((j1+j2+j3)/3), round((i1+i2+i3)/3), 0, 255);

  [A, B, C, D, n] = calcPlaneNormal(r1, r2, r3);

  for i = 1:X
    for j = 1:Y
      if Ish(j, i) == 255
        [xx, yy] = pix2mat(X, Y, dx, dy, i, j);
        [~, x, y, z] = dist2plane(A, B, C, D, xx, yy, 0, 0, 0, 1);
        l = lamp - [x; y; z];
        dist = norm(l);
        l = l / dist;
        cs = n' * l;
        if cs < 0, cs = 0; endif
        % Obliczenie natężenia dla każdego kanału
        tempR = Amb(1) + Int(1) * cs / (1 + 0.001 * dist^2);
        tempG = Amb(2) + Int(2) * cs / (1 + 0.001 * dist^2);
        tempB = Amb(3) + Int(3) * cs / (1 + 0.001 * dist^2);

        newR = min(255, tempR * eps(1));
        newG = min(255, tempG * eps(2));
        newB = min(255, tempB * eps(3));

        Im1(j, i, 1) = newR;
        Im1(j, i, 2) = newG;
        Im1(j, i, 3) = newB;
      endif
    endfor
  endfor
endfunction
