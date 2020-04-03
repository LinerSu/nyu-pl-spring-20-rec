(* Standard ML exercise *)

(* 1. Split a list into two parts; the length of the first part is given *)
(* val split = fn : 'a list -> int -> 'a list * 'a list *)
fun split ls n =
    ???;

split [1,2,3,4,5,6] 4;
(* val it = ([1,2,3,4],[5,6]) : int list * int list *)

(* 2. Map a list into a new list; the function map applies a function f to the input list *)
(* val map = fn : ('a -> 'b) -> 'a list -> 'b list *)
(*
Note. foldl, foldr functions in SML both have this signature:
('a * 'b -> 'b) -> 'b -> 'a list -> 'b
*)
fun map f ls = ???;

map (fn x => x + 1) [1,2,3];
List.map (fn x => x + 1) [1,2,3];
(* val it = [2,3,4] : int list *)

(* 3. Suppose we want to define a datatype for abstract syntax tree of an expression *)
datatype expr =
    Id of string | Int of int
  | Plus of expr * expr | Minus of expr * expr;

val a = Minus (Int 5, Plus (Int 3, Int 7));
(* 5 - (3 + 7) *)
val c = (Plus (Minus (Int 15, Plus (Int 3, Int 7)), Id "x"));
(* x + (15 - (3 + 7)) *)

(* Define a function that simplify the expression
Note. the expression could be simplified iff the inner expressions could simplify
E.g. Plus (Int 6, (Plus (Int 5,Id "x")) will not be simplified.
*)
(* E.g. simplify val a will be (Int -5) *)
fun simplify (Plus (a, b)) =
    ???;

simplify a;
(* val it = Int ~5 : expr *)
simplify c;
(* val it = Plus (Int 5,Id "x") : expr *)
