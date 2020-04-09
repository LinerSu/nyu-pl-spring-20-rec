(* Standard ML exercise *)

(* 1. Redefine foldl, foldr and filter functions as predefined functions in SML.*)


(* a. Define a fold_left function that works as foldl *)
(*
foldl f z [a, b, c, d] will actually work as:
   lst               z
a :: [b, c, d] => f (a, z)
b :: [c, d]    => f (b, f (a, z))
c :: [d]       => f (c, f (b, f (a, z)))
d :: []        => f (d, f (c, f (b, f (a, z))))
[]             => return z
*)
(* val fold_left = fn : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
fun fold_left  ... =
    ???;


(* b. Define a fold_right function that works as foldr *)
(*
foldr f z [a, b, c, d] will actually work as:
   lst                z
   []            => z
  d :: []        => f (d, z)
  c :: [d]       => f (c, f (d, z))
  b :: [c, d]    => f (b, f (c, f (d, z)))
  a :: [b, c, d] => return f (a, f (b, f (c, f (d, z))))
*)
(* val fold_right = fn : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
fun fold_right ... =
    ???;

(*
Note. foldl, foldr functions in SML both have this signature:
('a * 'b -> 'b) -> 'b -> 'a list -> 'b
*)


(* c. Define a filt function that works as filter *)
(*
filter p [a, b, c, d] will actually work as:
[a, b, c, d] => 
  let rest_lst = filter p [b, c, d]
  if p a then return a :: rest_lst else return rest_lst
*)
(* val filt = fn : ('a -> bool) -> 'a list -> 'a list *)
fun filt p lst = 
    ???;


(* 2. Split a list into two parts; the length of the first part is given *)
(* val split = fn : 'a list -> int -> 'a list * 'a list *)
fun split lst n =
    ???;

split [1,2,3,4,5,6] 4;
(* val it = ([1,2,3,4],[5,6]) : int list * int list *)


(* 3. Map a list into a new list; the function map applies a function f to the input list *)
(*
Given an external function f and a list [a, b, c, d, ...], map will return a equal-length list as:
  [f a, f b, f c, f d, ...]
*)
(* val map = fn : ('a -> 'b) -> 'a list -> 'b list *)
fun map f lst = 
    ???;

map (fn x => x + 1) [1,2,3];
List.map (fn x => x + 1) [1,2,3];
(* val it = [2,3,4] : int list *)


(* 3. Suppose we want to define a datatype for abstract syntax tree of an arithmetic arexpression *)
datatype expr =
    Id of string | Int of int
  | Plus of expr * expr | Minus of expr * expr;

val a = Minus (Int 5, Plus (Int 3, Int 7));
(* 5 - (3 + 7) *)
val c = Plus (Minus (Int 15, Plus (Int 3, Int 7)), Id "x");
(* x + (15 - (3 + 7)) *)

(* Define a function that simplify the expression
Note. the expression could be simplified iff the inner expressions could be simplified.
    E.g. Plus  (Int 6, (Plus (Int 5, Id "x"))  will not be simplified.
         Minus (Id "z", (Plus (Int 1, Int 2))) will be simplified as:
            Minus(Id "z", Int 3)
*)
(* val simplify = fn : expr -> expr *)
fun simplify (Plus (a, b)) =
    ???;

simplify a;
(* val it = Int ~5 : expr *)
simplify c;
(* val it = Plus (Int 5, Id "x") : expr *)


(* 4. Suppose we have a datatype for representing the natural numbers*)
datatype nat = Zero | Succ of nat;

val nat_0 = Zero;
val nat_3 = Succ(Succ(Succ(Zero)));
val nat_2 = Succ(Succ(Zero));

(* a. Define a function that translate a nat number into an integer. *)
(* val toInt = fn : nat -> int *)
fun toInt n =
    ???;

toInt nat_0;
(* val it = 0 : int *)
toInt nat_3;
(* val it = 3 : int *)
toInt nat_2;
(* val it = 2 : int *)

(* b. Define an addition operator over nat numbers. *)
(* val plusNat = fn : nat -> nat -> nat *)
fun plusNat x y =
    ???;

toInt (plusNat nat_2 nat_3);
(* val it = 5 : int *)

(* c. Define a multiplication operator over nat numbers. *)
(* val multNat = fn : nat -> nat -> nat *)
fun multNat x y =
    ???;

toInt (multNat nat_2 nat_3);
(* val it = 6 : int *)