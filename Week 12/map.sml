signature ORDTYPE =
   sig
     type t
     val compare: t -> t -> int
     type element
   end;

(*
In the functor signature, we refer to the 
  Ord.element type when we specify the data with type 'a.
In the functor body, we refer to the
  Ord.element and Ord.t when we implement the type for key and value.
  Using Ord.compare when we compare the key value.
*)

functor MAKEMAP(Ord: ORDTYPE) :
  sig
    type key
    type 'a t

    exception Not_Found

    val empty: Ord.element t
    val add:   key -> Ord.element -> Ord.element t -> Ord.element t
    val find:  key -> Ord.element t -> Ord.element
  end
= struct
    type key = Ord.t
    exception Not_Found

    datatype 'a t = Empty
    | Node of Ord.element t * key * Ord.element * Ord.element t
      (* left subtree * key * value * right subtree *)

    val empty = Empty

    fun add x v t = 
        case t of
          Empty => Node (Empty, x, v, Empty)
        | Node (l, k, v', r) =>
    if Ord.compare x k = 0 then Node (l, x, v, r)
    else if Ord.compare x k < 0 then Node(add x v l, k, v', r)
    else Node(l, k, v', add x v r)

    fun find x t = 
      case t of
        Empty => raise Not_Found
      | Node (l, k, v, r) =>
    if Ord.compare x k = 0 then v
    else if Ord.compare x k < 0 then find x l
    else find x r
end;

structure intOrd: ORDTYPE = 
struct 
    type t = int
    fun compare x y = 
      if x < y then ~1 else if x > y then 1 else 0
    type element = int
end;

structure intMap = MAKEMAP(intOrd);

val m = intMap.empty;
val m1 = intMap.add 1 0 m;
val m2 = intMap.add 3 2 m1;
val m3 = intMap.add 0 5 m2;
val found = intMap.find 0 m3;
val noutFound = (intMap.find 4 m3) handle Not_Found => ~1;