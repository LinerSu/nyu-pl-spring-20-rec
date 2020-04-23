/* Define p */
p(a).
p(X) :- q(X), r(X).
p(X) :- u(X).

/* Define q */
q(X) :- s(X).

/* Define r */
r(a). 
r(b). 

/* Define s */
s(a).  
s(b). 
s(c). 

/* Define u */
u(d). 

/* Define isList */
isList([]). /*Fact*/
isList([_|T]):-isList(T). %Rule

/* Define mem */
mem(X,[X|_]).
mem(X,[_|T]):-mem(X, T).

/* Define mem_noback */
mem_noback(X,[X|_]):- !.
mem_noback(X,[_|T]):-mem_noback(X, T).

/* Define reverse */
reverse([],[]).
reverse([X|Xs],Zs) :- reverse(Xs,Ys), append(Ys,[X],Zs).

/* Define append */
append([], L, L):-isList(L).
append([X|L1], L2, [X|L3]):-append(L1, L2, L3).

/* Define palindrome */
palindrome([]).
palindrome([_]):-!.
palindrome([X|T]):- append(T1,[X],T),!, palindrome(T1).

palindrome(L):- reverse(L,L).

/* Define subset */
subset([], _).
subset([X|T], L):- mem_noback(X, L), subset(T, L).
