# pawcho6
PAwCHO 

Link do package pawcho6
```
https://github.com/users/Valentine0604/packages/container/package/pawcho6
```


Aby utworzyć sekret należy użyć polecenia
```
docker secret create ssh_key "ścieżka_do_sekretu"
```

![image](https://github.com/Valentine0604/pawcho6/assets/106283972/4525af21-13b7-4933-8dde-593a4674edd5)


Aby zbudować obraz należy użyć polecenia 

```
 docker build --secret id=nazwa_sekretu,src=ścieżka_do_sekretu -t nazwa_obrazu.
```

![image](https://github.com/Valentine0604/pawcho6/assets/106283972/df625940-53de-4b94-b038-de39fd61ba75)


Aby uruchomić kontener należy użyć polecenia

```
docker run -p numer_portu --name=nazwa_kontenera nazwa_obrazu
```

![image](https://github.com/Valentine0604/pawcho6/assets/106283972/41e535b2-e5fb-4dc5-9255-3b79295ad76c)


Efekt działania aplikacji

![image](https://github.com/Valentine0604/pawcho6/assets/106283972/3e0bc1c5-f76b-444e-b435-5bc423def006)

Dodanie obrazu do repo
```
docker push nazwa_obrazu
```

![image](https://github.com/Valentine0604/pawcho6/assets/106283972/53260fd8-9ecc-4290-83fa-a29f9ae1d190)
