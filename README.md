# FailSafe-IT-Databasprojekt-Inlämning

## Mina tankar kring normalisering (3NF)
När jag började med databasen för FailSafe IT så utgick jag från att göra det enkelt att hantera värden på ett organiserat sätt utan att riskera dubbelarbete.  

- **1NF:** Här har jag sett till att fälten har enkla, odelbara värden och att varje tabell har en egen unik nyckel, så att vi slipper röriga listor i samma kolumn. 
- **2NF:** Eftersom 1NF är uppfyllt har jag även sett till att alla kolumner är beroende av primärnyckeln. 
- **3NF:** Här har jag varit noga med att organisera det snyggt; kundens uppgifter ligger i tabellen för kunder och kopplas endast via främmande nycklar. På så sätt slipper vi upprepa e-postadresser och företagsnamn på flera ställen. 

## DevSecOps-reflektioner

1. **Om säkerhet mot SQL Injection (Sec):**
För att stoppa SQL Injection behöver man se till att applikationen använder sig av parameteriserade frågor (prepared statements) och undvika att klistra in användarens text direkt i SQL-koden. Då förstår databasen att det som skrivs i formuläret bara är vanlig text/data och inte nya kommandon som ska köras.

2. **Om prestanda när företaget växer (Ops):**
Om databasen växer och får miljontals rader i framtiden behöver man lägga till index på de kolumner man söker mest på. Det fungerar lite som ett register i en bok och gör att databasen slipper söka igenom varenda rad i hela tabellen för att hitta rätt information.
