Jest to projekt programu wspó³bie¿nego, stanowi¹cy symulator dzia³ania przedsiêbiorstwa.


Napisany w 2 wersjach (jêzkach) : Ada i GO


Symuluje ma³¹ firmê zarz¹dzan¹ jedno-osobowo, z niewielk¹ liczb¹ pracowników. 


Prezes firmy, w losowych odstêpach czasu,  wymyœla kolejne zadania do wykonania dla pracowników i umieszcza je na liœcie zadañ.
(Przyjmujemy, ¿e zadanie ma postaæ rekordu o nastêpuj¹cych polach: pierwszy argument, drugi argument, operator arytmetyczny: dodawanie, odejmowanie albo mno¿enie.
Zadanie polega na “wytworzeniu” wyniku operacji arytmetycznej).

Ka¿dy pracownik, co pewien czas, pobiera kolejne zadanie z listy zadañ i je wykonuje. W wyniku powstaje pewien produkt, który pracownik umieszcza w magazynie.
Do magazynu, co pewien czas, przychodzi klient i zabiera (kupuje) jakieœ produkty.

Wszystkie zadania s¹ wykonywane na maszynach.
Zadania umieszczane na liœcie zadañ s¹ w postaci czêœciowo wype³nionych rekordów o nastêpuj¹cych polach: argument_1, operator (dodawania albo mno¿enia), argument_2, pole_na_wynik.

Pracownik pobiera ca³y rekord z listy zadañ, a nastêpnie wykonuje zadanie na maszynie odpowiedniego typu dla danego operatora.
Instrukcja obs³ugi maszyny:
Pracownik umieszcza rekord z zadaniem do wykonania w maszynie,
Maszyna przez pewien czas wykonuje zadan¹ operacjê i umieszcza wynik w polu pole_na_wynik.
Pracownik mo¿e wtedy odebraæ rekord z wynikiem i przenieœæ go do magazynu.
Ka¿dy pracownik przy swoich narodzinach podejmuje losow¹ decyzjê czy jest “cierpliwy”, czy “niecierpliwy”. Cierpliwi pracownicy czekaj¹ w kolejce a¿ maszyna przyjmie ich zadanie do obs³ugi. Niecierpliwi pracownicy kr¹¿¹ ze swoim zadaniem miêdzy maszynami,  czekaj¹c jedynie przez krótki czas przy ka¿dej z nich, a¿ uda im siê uzyskaæ dostêp do jednej z nich.
Ka¿dy pracownik prowadzi statystyki: ile uda³o mu siê wykonaæ zadañ.
Zak³adamy, ¿e maszyny licz¹ce mog¹ ulegaæ awariom. 
W przypadku awarii, maszyna bêdzie uszkodzona a¿ do jej naprawy 
zwracaj¹c ka¿de zadanie z pustym polem na wynik,
a pracownik, który dostaje taki  taki zwrot, zg³asza awariê do serwisu i usi³uje wykonaæ swoje zadanie na innej maszynie tego samego typu.
Serwis, po otrzymaniu zg³oszenia o awarii maszyny,  wysy³a swojego pracownika serwisowego do jej naprawy.  (Serwis i pracownik serwisowy maj¹ byæ osobnymi w¹tkami. Liczba pracowników serwisowych jest ograniczona, mniejsza ni¿ liczba maszyn.)
Pracownik serwisowy po dotarciu do maszyny (co zajmuje mu pewien czas) wykonuje naprawê usterki, co polega na wys³aniu do niej specjalnego polecenia przez specjalny kana³ "backdoor".
Po wykonaniu naprawy, pracownik serwisowy zg³asza usuniêcie awarii do serwisu.

Symulator dzia³a w dwóch trybach:
w trybie “gadatliwym” albo
w trybie “spokojnym”.

W trybie “gadatliwym” wypisywane s¹ na bie¿¹co komunikaty o zdarzeniach które zachodz¹ w przedsiêbiorstwie.
W trybie “spokojnym”, dzia³aj¹cy symulator oczekuje na polecenia u¿ytkownika. 



