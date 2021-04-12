:- use_module(library(persistency)).
:- persistent(db(id:atom, property:atom, value:atom)).

% generate film knowledge base from provided csv file

initdb :-
    open('movies-test.csv', read, Stream), 
    parseMovies(Stream), 
    close(Stream). 

% do nothing if at the end of stream
parseMovies(Stream) :- 
    at_end_of_stream(Stream),
    writeln("Reached end of stream"). 

parseMovies(Stream) :-
    \+ at_end_of_stream(Stream),
    csv_options(Options, [arity(22)]),
    csv_read_row(Stream, Row, Options), 
    addInfo(Row), 
    % write(Row), nl, 
    parseMovies(Stream). 

% add info contained in Row into knowledge base
addInfo(Row) :-
    % convert terms into lists
    Row =.. [_, ID, _, Name, Year, _, Genre, Runtime, Country, _, 
            _,_,_,_,_, Rating,Votes | R], 
    % writeln(Runtime + Country + Rating + Votes),
    addTitle(ID, Name, Year, Genre, Runtime, Country, Rating, Votes).  

% return true (skip film) if one of the arguments is missing from the csv file
addTitle(_,_,'',_,_,_,_,_). 
addTitle(_,_,_,'',_,_,_,_). 
addTitle(_,_,_,_,'',_,_,_). 
addTitle(_,_,_,_,_,'',_,_). 
addTitle(_,_,_,_,_,_,'',_). 
addTitle(_,_,_,_,_,_,_,''). 
% skip films with < 100000 votes (limit DB size)
addTitle(_,_,_,_,_,_,_,Votes) :- 
    Votes < 50000.  

addTitle(ID, Name, Year, Genre, Runtime, Country, Rating, Votes) :-
    assert( db(ID, name, Name) ), 
    assert( db(ID, runtime, Runtime) ), 
    % assert( db(ID, country, Country) ), 
    assert( db(ID, rating, Rating) ), 
    % convert country into list
    atomic_list_concat(CtryLst, ', ', Country), 
    addList(ID, country, CtryLst), 
    % convert genre into list
    atomic_list_concat(GenreList, ', ', Genre), 
    addList(ID, genre, GenreList), 
    writeln("Added": Name). 


% Add a list of the same property to the database
%   P: property (genre, country, etc)
addList(_, _, []). 
addList(ID, P, [H|T]) :-
    dif(H, P), 
    downcase_atom(H, A), 
    assert( db(ID, P, A) ), 
    addList(ID, P, T). 