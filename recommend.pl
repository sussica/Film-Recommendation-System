% Try: start.
% Note: each answer needs to end in '.'
start :-
    write('   Hello!  '),
    write('Welcome to the film recommendation system. Please answer questions below!'),nl,
    ask1, nl,
    read(Ans1), nl,
    ask2, nl, 
    read(Ans2), nl,
    ask3, nl, 
    read(Ans3), nl,
    ask4, nl,
    read(Ans4), nl,
    ask5, nl,
    read(Ans5), nl,
    % print the first 100 matched films
    write('we recommend following film:'), nl,
    forall(limit(100, distinct(recommend(Ans1, Ans2, Ans3, Ans4, Ans5, F))), writeln(F)).

 
ask1 :- 
    write("Do you prefer old films? "),nl,
    write("1. Yes"),nl,
    write("2. No"),nl,
    write("0. No preference"). 

ask2 :-
    write("What types of film are you in the mood for? "), nl,
    write("1. Emotional"),nl, 
    write("2. Historical"),nl, 
    write("3. Cerebral"),nl, 
    write("4. Adventurous"),nl, 
    write("5. Funny"), nl,
    write("0. No preference"). 

ask3 :-
    write("Do you have long time for the movie? "), nl,
    write("1. Yes"),nl, 
    write("2. No"),nl. 


ask4 :-
    write("Which country's movie do you prefer to watch? "), nl,
    write("1. US"),nl, 
    write("2. UK"),nl,
    write("3. Canada"),nl,
    write("4. Japan"),nl,
    write("5. Korea"),nl,
    write("6. China"),nl,
    write("0. No preference"),nl.

ask5 :-
    write("Do you want to watch movies that only high score? "), nl,
    write("1. Yes"),nl, 
    write("2. Doesn't matter"),nl.

% q1(0, _) is always true since no preference
q1(0, _). 
% q1(1, N) is true if film N is  released before 2000
q1(1, ID) :-
    db(ID, year, Y), 
    Y < 2000. 
% q1(2, N) is true if film N is released after 2000 
q1(2, ID) :-  
    db(ID, year, Y), 
    Y >= 2000. 


q2(0, _). 
% Emotional films
q2(1, ID) :- 
    % will return that are both romance and drama twice, solved by distinct()
    db(ID, genre, 'romance'); db(ID, genre, 'drama').  
% Historical films
q2(2, ID) :- 
    db(ID, genre, 'biography'); db(ID, genre, 'war'). 
% Cerebral films
q2(3, ID) :- 
    db(ID, genre, 'sci-fi'); db(ID, genre, 'thriller'). 
% Adventurous films
q2(4, ID) :- 
    db(ID, genre, 'adventure'); db(ID, genre, 'action'). 
% Funny films
q2(5, ID) :- 
    db(ID, genre, 'comedy'). 


% q3(1, ID) is true if the runtime is larger than 100.
q3(1, ID) :-
    db(ID, runtime, R),
    R >= 100.
% q3(2, ID) is true if the runtime is smaller than 100.
q3(2, ID) :-
    db(ID, runtime, R),
    R < 100.

q4(0. _).
q4(1, ID) :-
    db(ID, coutry, 'US').
q4(2, ID) :-
    db(ID, coutry, 'UK').
q4(3, ID) :-
    db(ID, coutry, 'Canada').
q4(4, ID) :-
    db(ID, coutry, 'Japan').
q4(5, ID) :-
    db(ID, coutry, 'Korea').
q4(6, ID) :-
    db(ID, coutry, 'China').

% q5(1, ID) is true if the score is larger than 7.5.
q5(1, ID) :-
    db(ID, score, S),
    S >= 7.5.
q5(2, _).

% Try: recommend(2, 1, F). -- returns all matches to modern emotional films
% TODO: to add more questions, simply add another parameter and define all possible qn()'s for that question
recommend(Ans1, Ans2, Ans3, Filmname) :-
    db(ID, name, Filmname), 
    q1(Ans1, ID),
    q2(Ans2, ID),
    q3(Ans3, ID),
    q4(Ans4, ID),
    q5(Ans5, ID).


% Example knowledge base of films: 
% http://www.omdbapi.com/
% TODO: add more fields for each film, such as director, rating, actor... 
db('tt0083658', name, 'Blade Runner'). 
db('tt0083658', year, 1982). 
db('tt0083658', genre, 'thriller'). 
db('tt0083658', genre, 'sci-fi'). 
db('tt0083658', genre, 'action'). 
db('tt0083658', runtime, 117). 

db('tt0076759', name, 'Star Wars'). 
db('tt0076759', year, 1977). 
db('tt0076759', genre, 'action'). 
db('tt0076759', genre, 'adventure'). 
db('tt0076759', genre, 'fantasy'). 
db('tt0076759', genre, 'sci-fi'). 
db('tt0076759', runtime, 121). 

db('tt2194499', name, 'About Time'). 
db('tt2194499', year, 2013). 
db('tt2194499', genre, 'romance'). 
db('tt2194499', genre, 'comedy'). 
db('tt2194499', runtime, 123). 

db('tt1798709', name, 'Her'). 
db('tt1798709', year, 2013). 
db('tt1798709', genre, 'drama'). 
db('tt1798709', genre, 'romance'). 
db('tt1798709', runtime, 126). 

db('tt2084970', name, 'The Imitation Game'). 
db('tt2084970', year, 2014). 
db('tt2084970', genre, 'biography'). 
db('tt2084970', genre, 'drama'). 
db('tt2084970', genre, 'thriller'). 
db('tt2084970', genre, 'war'). 
db('tt2084970', runtime, 114). 