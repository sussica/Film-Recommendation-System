# Film-Recommendation-System

Run the program in `swipl`. 

To ensure diacritic characters are printed (foreign film titles), enter: 
```
set_prolog_flag(encoding, utf8).
```

When starting for the first time: 
```
?- [recommend].
?- loaddb.
```

Once `loaddb` has been called: 
```
?- start.
```