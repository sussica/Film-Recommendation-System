% Try: 
% satisfy(1, N). 
% satisfy(2, N). 
% otherwise(1, N). 
% otherwise(2, N). 


% Q1: is the film made before 2000? 
ask(1) :- 
    write("is the movie made before 2000? "). 

satisfy(1, N) :-
    mov(ID, name, N), 
    mov(ID, year, Y), 
    Y < 2000. 

% Simple not(satisfy(1, N)) does not work because negation as failure 
otherwise(1, N) :-  
    mov(ID, name, N), 
    mov(ID, year, Y), 
    Y >= 2000. 


% Q2: is the movie a cyberpunk film?
ask(2) :-
    write("is the movie a cyberpunk film? "). 

satisfy(2, N) :-
    mov(ID, name, N), 
    mov(ID, genre, 'cyberpunk'). 

otherwise(2, N) :- 
    mov(ID, name, N), 
    not(mov(ID, genre, 'cyberpunk')). 


% Example knowledge base of movies: 
mov('tt0083658', name, 'Blade Runner'). 
mov('tt0083658', year, 1982). 
mov('tt0083658', genre, 'action film'). 
mov('tt0083658', genre, 'cyberpunk'). 
mov('tt0076759', name, 'Star Wars'). 
mov('tt0076759', year, 1977). 
mov('tt0076759', genre, 'action film'). 
mov('tt0076758', name, 'About Time'). 
mov('tt0076758', year, 2013). 
mov('tt0076758', genre, 'romance film'). 