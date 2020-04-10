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
fun fold_left f z lst =
    case lst of 
     [] => z
    | hd :: tl => fold_left f (f (hd, z)) tl;

val sub = fold_left (fn (elem, z) => elem * z + elem) 0 [1,2,3];
(* val sub = 15 : int *)


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
fun fold_right f z lst =
    case lst of
     [] => z
    | hd :: tl => f (hd,(fold_right f z tl));

val sub = fold_right (fn (elem, z) => elem * z + elem) 0 [1,2,3];
(* val sub = 9 : int *)

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
(* val filt = fn : (('a -> bool) -> ('a list -> 'a list)) *)
fun filt p lst = 
    case lst of
    [] => []
   | hd :: tl => if p hd then hd :: (filt p tl) else filt p tl;

(* Use foldr to design split function *)
fun filt p lst = foldr (fn (elem, z) => if p elem then elem :: z else z) [] lst;

val gt5lst = filt (fn elem => elem > 5) [1,5,6,2,3,4,7,8];
(* val gt5lst = [6,7,8] : int list *)


(* 2. Split a list into two parts; the length of the first part is given *)
(* val split = fn : 'a list -> int -> 'a list * 'a list *)
fun split lst n =
    let fun aux i acc [] = ((List.rev acc), [])
      | aux i acc (l as (h :: t)) = if i <= 0 then ((List.rev acc), l)
                       else aux (i - 1) (h :: acc) t
    in
    aux n [] lst
    end;
(* Use foldr to design split function *)
fun split lst n = 
    let
      val (_, l, r) = foldr (
        fn (elem, (i, lst1, lst2)) => if i <= 0 then (i, elem :: lst1, lst2)
        else (i - 1, lst1, elem :: lst2)) ((List.length lst) - n, [], []) lst;
    in
      (l, r)
    end;
(* Use foldl to design split function *)
fun split lst n = 
    let val (_, l, r) = foldl (
      fn (elem, (i, lst1, lst2)) => if i <= 0 then (i, lst1, elem :: lst2)
      else (i - 1, elem :: lst1, lst2)) (n, [], []) lst;
    in
      (List.rev l, List.rev r)
    end;

split [1,2,3,4,5,6] 4;  (* val it = ([1,2,3,4],[5,6]) : int list * int list *)
split [1,2,3,4,5,6] ~4; (* val it = ([],[1,2,3,4,5,6]) : int list * int list *)
split [1,2,3,4,5,6] 10; (* val it = ([1,2,3,4,5,6],[]) : int list * int list *)


(* 3. Map a list into a new list; the function map applies a function f to the input list *)
(*
Given an external function f and a list [a, b, c, d, ...], map will return a equal-length list as:
  [f a, f b, f c, f d, ...]
*)
(* val map = fn : ('a -> 'b) -> 'a list -> 'b list *)
fun map f lst =
    case lst of 
    []       => []
  | hd :: tl => (f hd) :: map f tl;
(* Use foldr to design map function *)
fun map f lst = foldr (fn (x, acc) => (f x) :: acc) [] lst;
map (fn x => x + 1) [1,2,3]; (* val it = [2,3,4] : int list *)
List.map (fn x => x + 1) [1,2,3]; (* val it = [2,3,4] : int list *)


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
        (case (simplify a, simplify b) of
            (Int ra, Int rb) => (Int (ra + rb))
            | (a, b) =>  (Plus (a, b)))
  | simplify (Minus (a, b)) =
        (case (simplify a, simplify b) of
            (Int ra, Int rb) => (Int (ra - rb))
            | (a, b) =>  (Minus (a, b)))
  | simplify a = a;

simplify a; (* val it = Int ~5 : expr *)
simplify c; (* val it = Plus (Int 5, Id "x") : expr *)


(* 4. Suppose we have a datatype for representing the natural numbers*)
datatype nat = Zero | Succ of nat;

val nat_0 = Zero;
val nat_3 = Succ(Succ(Succ(Zero)));
val nat_2 = Succ(Succ(Zero));

(* a. Define a function that translate a nat number into an integer. *)
(* val toInt = fn : nat -> int *)
fun toInt n =
   case n of
    Zero => 0
   | (Succ n') => (toInt n') + 1;

toInt nat_0; (* val it = 0 : int *)
toInt nat_3; (* val it = 3 : int *)
toInt nat_2; (* val it = 2 : int *)

(* b. Define an addition operator over nat numbers. *)
(* val plusNat = fn : nat -> nat -> nat *)
fun plusNat x y =
   case x of
    Zero => y
   | (Succ x') => Succ (plusNat x' y);

toInt (plusNat nat_2 nat_3); (* val it = 5 : int *)

(* c. Define a multiplication operator over nat numbers. *)
(* val multNat = fn : nat -> nat -> nat *)
fun multNat x y =
   case x of
   Zero => Zero
   | (Succ x') => plusNat y (multNat x' y);

toInt (multNat nat_2 nat_3); (* val it = 6 : int *)