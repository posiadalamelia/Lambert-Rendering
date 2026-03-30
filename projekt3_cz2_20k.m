%% Parametry
X = 640; Y = 480;
dx = 0.1; dy = 0.1;
Amb = [100, 100, 100]; % światło tła
Imax = [1000, 1000, 1000]; % źródło światła
p_light = [-5; -5; -28]; % położenia źródła światła

% definicja współrzędnych narożników trójkątów
r1 = [-22; 0; 58];
r2 = [11; 19; 58];
r3 = [0; 0; 26];
r4 = [11; -19; 58];

% Współczynniki koloru RGB dla trójkątów
col_A = [1.0, 0.5, 0.25];
col_B = [0.25, 1.0, 0.5];
col_C = [0.25, 0.5, 1.0];

% zdefiniowanie wektora przesunięcia dla trójkąta C i przesunięcie narożników tego trójkąta
vector = [-8;0;-10];
r2_reshaped = r2 + vector; r4_reshaped = r4 + vector; r3_reshaped = r3 + vector;

% Obliczenie płaszczyzn i wektorów normalnych
[A1, B1, C1, D1, n1] = calcPlaneNormal(r1, r2, r3);
[A2, B2, C2, D2, n2] = calcPlaneNormal(r1, r4, r3);
[A3, B3, C3, D3, n3] = calcPlaneNormal(r2_reshaped, r4_reshaped, r3_reshaped);

%% część 2

numFrames = 20;
video = VideoWriter('animacja_20.avi');
open(video);

[Ish1, A1, B1, C1, D1, n1] = tr_Lambert1(r1, r2, r3, X, Y, dx, dy);
[Ish2, A2, B2, C2, D2, n2] = tr_Lambert1(r1, r4, r3, X, Y, dx, dy);
[Ish3, A3, B3, C3, D3, n3] = tr_Lambert1(r2_reshaped, r4_reshaped, r3_reshaped, X, Y, dx, dy);

for k = 1:numFrames
  % Obliczenie wartości t
  t = 0.0315 * k;
  % położenie źródła światła
  p_light = [-5*cos(t); -5 + 5*sin(t); -28];
  % utworzenie pustego obrazka
  Im = uint8(zeros(Y, X));
  % narysowanie kazdego trójkąta z modelem oświetlenia Lamberta na oddzielnych obrazkach
  [Im1] = tr_Lambert2(Im, Ish1, A1, B1, C1, D1, n1, Amb, p_light, Imax, X, Y, dx, dy, col_A);
  [Im2] = tr_Lambert2(Im, Ish2, A2, B2, C2, D2, n2, Amb, p_light, Imax, X, Y, dx, dy, col_B);
  [Im3] = tr_Lambert2(Im, Ish3, A3, B3, C3, D3, n3, Amb, p_light, Imax, X, Y, dx, dy, col_C);
  % Nakładanie cieni na trójkąty
  Im_shadow1 = rzucanieCienia(Im1, Ish1, A1, B1, C1, D1, Ish3, A3, B3, C3, D3, p_light, X, Y, dx, dy, Amb, col_A); % czy niebieski (3) rzuca cień na czerwony (1)
  Im_shadow2 = rzucanieCienia(Im2, Ish2, A2, B2, C2, D2, Ish3, A3, B3, C3, D3, p_light, X, Y, dx, dy, Amb, col_B); % czy niebieski (3) rzuca cień na zielony (2)
  Im_shadow3 = rzucanieCienia(Im3, Ish3, A3, B3, C3, D3, Ish1, A1, B1, C1, D1, p_light, X, Y, dx, dy, Amb, col_C); % czy czerwony (1) na niebieski (3)
  Im_shadow4 = rzucanieCienia(Im3, Ish3, A3, B3, C3, D3, Ish2, A2, B2, C2, D2, p_light, X, Y, dx, dy, Amb, col_C); % czy zielony (2) na niebieski (3)
  Im_shadowCombined = uint8(min(double(Im_shadow3), double(Im_shadow4)));
  % alorytm z-buforowania
  FImR = uint8(zeros(Y, X, 3));
  ZbufR = 1e6 * ones(Y, X);
  for i = 1:X
    for j = 1:Y
        % Przeliczamy położenie piksela na współrzędne rzeczywiste
        [xx, yy] = pix2mat(X, Y, dx, dy, i, j);
        [ZbufR, FImR] = czyNajblizej(xx, yy, i, j, X, Y, dx, dy, ZbufR, FImR, Ish1, A1, B1, C1, D1, Im_shadow1);
        [ZbufR, FImR] = czyNajblizej(xx, yy, i, j, X, Y, dx, dy, ZbufR, FImR, Ish2, A2, B2, C2, D2, Im_shadow2);
        [ZbufR, FImR] = czyNajblizej(xx, yy, i, j, X, Y, dx, dy, ZbufR, FImR, Ish3, A3, B3, C3, D3, Im_shadowCombined);
    endfor
  endfor
  % Wyświetlenie informacji w konsoli
  fprintf('Klatka %d, t = %.3f rad\n', k, t);
  % Zapis klatki do wideo
  writeVideo(video, FImR);
endfor

close(video);
