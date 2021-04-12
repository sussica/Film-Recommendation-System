% First time starting: starti
% Try: start
% Note: each answer needs to end in '.'
:- [testkb]. 
:- [gendb]. 

starti :- 
    writeln('Loading movie database... '), 
    initdb,
    nl,nl, 
    start. 

start :-
    write('   Hello!  '),
    write('Welcome to the movie recommendation system. Please answer questions below!'),nl,
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
    % print the first 20 matched films
    write('we recommend following movies:'), nl,
    forall(limit(20, distinct(recommend(Ans1, Ans2, Ans3, Ans4, Ans5, F))), writeln(F)).

 
ask1 :- 
    write("Do you prefer old movies? "),nl,
    write("1. Yes"),nl,
    write("2. No"),nl,
    write("0. No preference"). 

ask2 :-
    write("What types of movies are you in the mood for? "), nl,
    write("1. Emotional"),nl, 
    write("2. Historical"),nl, 
    write("3. Cerebral"),nl, 
    write("4. Adventurous"),nl, 
    write("5. Funny"), nl,
    write("0. No preference"). 

ask3 :-
    write("Do you have time for longer movies? "), nl,
    write("1. Yes"),nl, 
    write("2. No"),nl, 
    write("0. No preference"),nl.

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
    write("Do you prefer high-scoring movies? "), nl,
    write("1. Yes"),nl, 
    write("0. Doesn't matter"),nl.

% q1(_, _) is always true since no preference
q1(_, _).
% q1(1, N) is true if film N is  released before 2000
q1(1, ID) :-
    db(ID, year, Y), 
    Y < 2000. 
% q1(2, N) is true if film N is released after 2000 
q1(2, ID) :-  
    db(ID, year, Y), 
    Y > 1999. 


q2(_, _).
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


q3(_, _).
% q3(1, ID) is true if the runtime is larger than 115.
q3(1, ID) :-
    db(ID, runtime, R),
    R > 115.
% q3(2, ID) is true if the runtime is smaller than 120.
q3(2, ID) :-
    db(ID, runtime, R),
    R < 120.

q4(_, _).
q4(1, ID) :-
    db(ID, country, 'usa').
q4(2, ID) :-
    db(ID, country, 'uk').
q4(3, ID) :-
    db(ID, country, 'canada').
q4(4, ID) :-
    db(ID, country, 'japan').
q4(5, ID) :-
    db(ID, country, 'korea').
q4(6, ID) :-
    db(ID, country, 'china').

% q5(1, ID) is true if the rating is larger than 7.5.
q5(1, ID) :-
    db(ID, rating, S),
    S > 7.5.
q5(_, _).

% Try: recommend(2, 1, F). -- returns all matches to modern emotional films
% TODO: to add more questions, simply add another parameter and define all possible qn()'s for that question
recommend(Ans1, Ans2, Ans3, Ans4, Ans5, Filmname) :-
    db(ID, name, Filmname), 
    q1(Ans1, ID),
    q2(Ans2, ID),
    q3(Ans3, ID),
    q4(Ans4, ID),
    q5(Ans5, ID).