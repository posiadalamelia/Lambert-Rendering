# Grafika komputerowa (Matlab)

## Część 1
Zwizualizowano trzy trójkąty za pomocą modelu oświetlenia Lamberta i dwóch konfiguracji położeń. Każdy z nich w inny sposób odbija oświetlenie kolorami bazowymi RGB. Podane zostały parametry rozdzielczości obrazu, rozmiar piksela, natężenie światła tła, punktowe źródło światła, położenie światła, wzór na spadek natężenia oświetlenia w zależności od odległości. Uwzględniono przecinanie się i wzajemne rzucanie cieni przez trójkąty, które występują w drugiej z konfiguracji.

### Opis rozwiązania: 
1.  Parametryzacja i przygotowanie węzłów B-sklejanych (4000 punktów) . 
2.  Obliczenie bazowych funkcji b-sklejanych (bspline0,  bspline1,  bspline2). 
3.  Zdefiniowanie punktów kontrolnych litery U. 
4.  Wygenerowanie współrzędnych krzywej za pomocą funkcji  plotBspline2Dmod.Funkcję tą zmdyfikowano tak aby:  
- zwracała współrzędne krzywej, czyli xx i yy; 
- w plot zmieniono zakres rysowania dla xx i yy do Tint(3):Tint(M-1), aby nie  pokazywana była początkowa i końcowa linia która aproksymuje punkt 0,0; 
- jako argument wejściowy wczytywała również t, aby funkcja działała uniwersalnie dla rozmiarów t, podobnie zrobiono w bspline0, bspline1.  bspline2. 
5.  Definiowanie rozmiarów obrazu i krzywej.  
6.  Obliczenie skalowania i skalowanie współrzędnych. 
7.  Przesunięcie współrzędnych litery do środka obrazu za pomocą funkcji centerXY. 
8.  Wygenerowanie obrazu binarnego krzywej za pomocą wbudowanej funkcji  poly2mask z pakietu image.

### Wynik Części 1

#### Konfiguracja 1
<image src="./Wyniki/konfiguracja1.png" controls title="Konfiguracja 1" width="80%"></image>
#### Konfiguracja 2
<image src="./Wyniki/konfiguracja2.png" controls title="Konfiguracja 2" width="80%"></image>
---

## Część 2
Wygenerowano krótką animację przedstawiającą drugą konfigurację trójkątów oświetloną 
ruchomym źródłem światła używając tych samych parametrów oświetlenia jak w części pierwszej i modelu oświetlenia Lamberta.  
 
Rozwiązanie: 
1.  Zdefiniowanie liczby klatek, stworzenie video; 
2.  Rysowanie trójkątów bez cieni na oddzielnych obrazkach za pomocą funkcji tr_Lambert1, która powstała poprzez podzielenie funkcji tr_Lambert na dwie części, tak, aby niepotrzebnie nie powtarzać operacji rysowania trójkątów dla każdej klatki, ponieważ trójkąty nie zmieniają swojego położenia.  
3.  W pętli 
- Obliczenie wartości t 
- Obliczenie nowego położenia światła zależnego od klatki k 
- Utworzenie pustego obrazka 
- Narysowanie natężenia światła każdego trójkąta tr_Lambert2, która powstała poprzez  podzielenie funkcji tr_Lambert na dwie części, tak, aby niepotrzebnie nie powtarzać operacji, które mogą być wykonywane rzadziej, a natężenie jest zależne od położenia światła, więc musi być obliczane dla każdej klatki.  
- Nałożenie cieni na każdy trójkąt za pomocą funkcji rzucanieCienia 
- Zastosowanie algorytmu z-buforowania na obrazkach z cieniami, aby połączyć je w jeden. Wewnątrz pętli wywołana została dla każdego trójkąta funkcja czyNajbliżej, która sprawdza, czy dany pixel obrazka z cieniem powinien być wyświetlony na końcowym obrazku.  
- wyświetlenie informacji w konsoli aby kontrolować postęp. 
- Zapis klatki do video 
4.  Zamknięcie video. 

### Wynik Części 2
[![Trójkąty z oświetleniem](./Wyniki/animacja.gif)](./Wyniki/animacja.mp4)

## Instrukcja uruchomienia

Aby uruchomić projekt, proszę:

1. Otworzyć plik `projekt3.m` w programie Octave  
2. W oknie poleceń wpisać:
   ```octave
   pkg install -forge video
   pkg load video
   ```
3. Uruchomić kod



