function [Im1] = tr_Lambert2(Im, Ish, A, B, C, D, n, Amb, lamp, Int, X, Y, dx, dy, eps)
  Im1 = Im;

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
