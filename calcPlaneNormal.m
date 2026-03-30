function [A, B, C, D, n] = calcPlaneNormal(r1, r2, r3)
    [A, B, C, D] = plane(r1, r2, r3);
    n = [A; B; C] / norm([A; B; C]);
    if n(3) > 0
        n = -n;
    endif
endfunction
