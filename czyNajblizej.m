function [ZbufR, FImR] = czyNajblizej(xx, yy, i, j, X, Y, dx, dy, ZbufR, FImR, Ish, A, B, C, D, Im_shadow)
    if Ish(j, i) == 255
        [d, ~, ~, ~] = dist2plane(A, B, C, D, xx, yy, 0, 0, 0, 1);
        if d < ZbufR(j, i)
            ZbufR(j, i) = d;
            FImR(j, i, :) = Im_shadow(j, i, :);
        endif
    endif
endfunction
