Jest to projekt programu współbieżnego, stanowiący symulator działania przedsiębiorstwa. Został napisany w 2 wersjach (jęzkach) : Ada i GO.


Zasady działania przedsiębiorstwa :


Jest to mała firma zarządzaną jedno-osobowo, z niewielką liczbą pracowników. Prezes firmy, w losowych odstępach czasu, wymyśla kolejne zadania do wykonania dla pracowników i umieszcza je na liście zadań. (Przyjmujemy, że zadanie ma postać rekordu o następujących polach: pierwszy argument, drugi argument, operator arytmetyczny: dodawanie, odejmowanie albo mnożenie. Zadanie polega na “wytworzeniu” wyniku operacji arytmetycznej).

Każdy pracownik, co pewien czas, pobiera kolejne zadanie z listy zadań i je wykonuje. W wyniku powstaje pewien produkt, który pracownik umieszcza w magazynie. Do magazynu, co pewien czas, przychodzi klient i zabiera (kupuje) jakieś produkty.

Wszystkie zadania są wykonywane na maszynach. Zadania umieszczane na liście zadań są w postaci częściowo wypełnionych rekordów o następujących polach: argument_1, operator (dodawania albo mnożenia), argument_2, pole_na_wynik.

Pracownik pobiera cały rekord z listy zadań, a następnie wykonuje zadanie na maszynie odpowiedniego typu dla danego operatora.
Instrukcja obsługi maszyny: Pracownik umieszcza rekord z zadaniem do wykonania w maszynie, Maszyna przez pewien czas wykonuje zadaną operację i umieszcza wynik w polu pole_na_wynik. Pracownik może wtedy odebrać rekord z wynikiem i przenieść go do magazynu. Każdy pracownik przy swoich narodzinach podejmuje losową decyzję czy jest “cierpliwy”, czy “niecierpliwy”. Cierpliwi pracownicy czekają w kolejce aż maszyna przyjmie ich zadanie do obsługi. Niecierpliwi pracownicy krążą ze swoim zadaniem między maszynami,  czekając jedynie przez krótki czas przy każdej z nich, aż uda im się uzyskać dostęp do jednej z nich.
Każdy pracownik prowadzi statystyki: ile udało mu się wykonać zadań. Zakładamy, że maszyny liczące mogą ulegać awariom. 
W przypadku awarii, maszyna będzie uszkodzona aż do jej naprawy zwracając każde zadanie z pustym polem na wynik,
a pracownik, który dostaje taki  taki zwrot, zgłasza awarię do serwisu i usiłuje wykonać swoje zadanie na innej maszynie tego samego typu. Serwis, po otrzymaniu zgłoszenia o awarii maszyny,  wysyła swojego pracownika serwisowego do jej naprawy.  (Serwis i pracownik serwisowy mają być osobnymi wątkami. Liczba pracowników serwisowych jest ograniczona, mniejsza niż liczba maszyn.)
Pracownik serwisowy po dotarciu do maszyny (co zajmuje mu pewien czas) wykonuje naprawę usterki, co polega na wysłaniu do niej specjalnego polecenia przez specjalny kanał "backdoor". Po wykonaniu naprawy, pracownik serwisowy zgłasza usunięcie awarii do serwisu.

Symulator działa w dwóch trybach: w trybie “gadatliwym” albo w trybie “spokojnym”.

W trybie “gadatliwym” wypisywane są na bieżąco komunikaty o zdarzeniach które zachodzą w przedsiębiorstwie.
W trybie “spokojnym”, działający symulator oczekuje na polecenia użytkownika. 



