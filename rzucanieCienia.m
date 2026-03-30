function Im = rzucanieCienia(Im, Ish1, A1, B1, C1, D1, Ish2, A2, B2, C2, D2, lamp, X, Y, dx, dy, Amb, col_target)
  for i = 1:X
      for j = 1:Y
          if Ish1(j, i) == 255
              [xx, yy] = pix2mat(X, Y, dx, dy, i, j);
              [~, x, y, z] = dist2plane(A1, B1, C1, D1, xx, yy, 0, 0, 0, 1);
              l1 = lamp - [x; y; z];
              dist1 = norm(l1);
              [d2, x2, y2, z2] = dist2plane(A2, B2, C2, D2, x, y, z, l1(1), l1(2), l1(3));
              if norm([x2; y2; z2] - lamp) < dist1 && abs(d2) < dist1
                  [i2, j2] = mat2pix(X, Y, dx, dy, x2, y2);
                  if i2 > 0 && j2 > 0 && i2 <= X && j2 <= Y && Ish2(j2, i2) == 255
                      Im(j, i, 1) = uint8(255 * col_target(1) * 0.4);
                      Im(j, i, 2) = uint8(255 * col_target(2) * 0.4);
                      Im(j, i, 3) = uint8(255 * col_target(3) * 0.4);
                  endif
              endif
          endif
      endfor
  endfor
endfunction
