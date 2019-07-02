Jest to projekt programu wsp�bie�nego, stanowi�cy symulator dzia�ania przedsi�biorstwa.


Napisany w 2 wersjach (j�zkach) : Ada i GO


Symuluje ma�� firm� zarz�dzan� jedno-osobowo, z niewielk� liczb� pracownik�w. 


Prezes firmy, w losowych odst�pach czasu,  wymy�la kolejne zadania do wykonania dla pracownik�w i umieszcza je na li�cie zada�.
(Przyjmujemy, �e zadanie ma posta� rekordu o nast�puj�cych polach: pierwszy argument, drugi argument, operator arytmetyczny: dodawanie, odejmowanie albo mno�enie.
Zadanie polega na �wytworzeniu� wyniku operacji arytmetycznej).

Ka�dy pracownik, co pewien czas, pobiera kolejne zadanie z listy zada� i je wykonuje. W wyniku powstaje pewien produkt, kt�ry pracownik umieszcza w magazynie.
Do magazynu, co pewien czas, przychodzi klient i zabiera (kupuje) jakie� produkty.

Wszystkie zadania s� wykonywane na maszynach.
Zadania umieszczane na li�cie zada� s� w postaci cz�ciowo wype�nionych rekord�w o nast�puj�cych polach: argument_1, operator (dodawania albo mno�enia), argument_2, pole_na_wynik.

Pracownik pobiera ca�y rekord z listy zada�, a nast�pnie wykonuje zadanie na maszynie odpowiedniego typu dla danego operatora.
Instrukcja obs�ugi maszyny:
Pracownik umieszcza rekord z zadaniem do wykonania w maszynie,
Maszyna przez pewien czas wykonuje zadan� operacj� i umieszcza wynik w polu pole_na_wynik.
Pracownik mo�e wtedy odebra� rekord z wynikiem i przenie�� go do magazynu.
Ka�dy pracownik przy swoich narodzinach podejmuje losow� decyzj� czy jest �cierpliwy�, czy �niecierpliwy�. Cierpliwi pracownicy czekaj� w kolejce a� maszyna przyjmie ich zadanie do obs�ugi. Niecierpliwi pracownicy kr��� ze swoim zadaniem mi�dzy maszynami,  czekaj�c jedynie przez kr�tki czas przy ka�dej z nich, a� uda im si� uzyska� dost�p do jednej z nich.
Ka�dy pracownik prowadzi statystyki: ile uda�o mu si� wykona� zada�.
Zak�adamy, �e maszyny licz�ce mog� ulega� awariom. 
W przypadku awarii, maszyna b�dzie uszkodzona a� do jej naprawy 
zwracaj�c ka�de zadanie z pustym polem na wynik,
a pracownik, kt�ry dostaje taki  taki zwrot, zg�asza awari� do serwisu i usi�uje wykona� swoje zadanie na innej maszynie tego samego typu.
Serwis, po otrzymaniu zg�oszenia o awarii maszyny,  wysy�a swojego pracownika serwisowego do jej naprawy.  (Serwis i pracownik serwisowy maj� by� osobnymi w�tkami. Liczba pracownik�w serwisowych jest ograniczona, mniejsza ni� liczba maszyn.)
Pracownik serwisowy po dotarciu do maszyny (co zajmuje mu pewien czas) wykonuje napraw� usterki, co polega na wys�aniu do niej specjalnego polecenia przez specjalny kana� "backdoor".
Po wykonaniu naprawy, pracownik serwisowy zg�asza usuni�cie awarii do serwisu.

Symulator dzia�a w dw�ch trybach:
w trybie �gadatliwym� albo
w trybie �spokojnym�.

W trybie �gadatliwym� wypisywane s� na bie��co komunikaty o zdarzeniach kt�re zachodz� w przedsi�biorstwie.
W trybie �spokojnym�, dzia�aj�cy symulator oczekuje na polecenia u�ytkownika. 



