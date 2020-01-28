function KonwekcjaDyfuzja (c,n)
  
% obliczamy odleglosc pomiedzy kolejnymi punktami
h=1/n;

% obliczamy wartosci odpowiednio znajdujace sie
P1 = (c/(2*h))-(1/(h^2));
P3 = (-c/(2*h))-(1/(h^2));

% tworzymy rzadka tablice o rozmiarze (n-1)x(n-1)
macierz = sparse(n-1,n-1);
% tworzymy wektor funkcji o rozmiarze (n-1)
wektor_pr = zeros(n-1,1);
% wypelnianie macierzy 
macierz(1,1) = P2;
macierz(1,2) = P1;
for k = 2:n-2
    macierz(k,k-1) = P3;
    macierz(k,k) = P2;
    macierz(k,k+1) = P1;
end
macierz(n-1,n-2) = P3;
macierz(n-1,n-1) = P2;
% wypelniamy wektor prawej strony 
for k = 1:n-1
    wektor_pr(k,1) = 2 + 10*(k/n);
end
% eliminacja gausa dla macierzy (n-1)x(n-1)
% i wektora prawej strony
% uzywamy optymalnego solwera dla macierzy rzadkich - operator \
wynik = macierz\wektor_pr;

% tworzymy wektor punktow 
punkty = [0:1/n:1];
% oraz wartosci u(xn)
wartosci = zeros(1,n+1);
for k = 2:n
    wartosci(k)=wynik(k-1);
end
p = 3;
x=punkty;
y=wartosci;
% x, y - wektory wspolrzednych
% p = stopien wielomianu 
A(1:p+1,1:p+1)=0;
b(1:p+1)=0;
% petla po punktach
for k=1:n
% petla po wierszach
    for i=1:p+1
% petla po kolumnach   
         for j=1:p+1
            A(i,j)=A(i,j)+x(k)^(i+j-2);
        end
        b(i)=b(i)+y(k)*x(k)^(i-1);
    end
end
a=A\b';
% rysowanie wielomianu aproksymujacego
dokl = 10000;
punkt = [0:1/dokl:1];
% petla po punktach dla ktorych rysujemy wartosci wielomianu
for i=1:dokl+1
% petla po wspolczynnikach wielomianu
    wielomian(i)=0;
    for j=1:p+1
        wielomian(i)=wielomian(i)+a(j)*punkt(i)^(j-1);
    end
end

% rysowanie wyniku
plot(punkt,wielomian);
% zachowanie wykresu dla kolejnego rysowania
hold on
plot(x,y,'rx');
% koniec zachowywania wykresow - kolejne rysowanie nadpisze wykres
hold off