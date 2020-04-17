signature QUEUESIG = 
sig
    type 'a queue
    val empty : 'a queue
    val is_empty : 'a queue -> bool
    val enqueue : 'a -> 'a queue -> 'a queue
    val dequeue : 'a queue -> 'a * 'a queue
    exception Empty
end;

structure QUEUE :> QUEUESIG = (*Opaque ascription*)
struct
    type 'a queue = 'a list
    exception Empty
        
    val empty: 'a queue = []

    fun is_empty (q:'a queue) = null q

    fun enqueue x q =
       q @ [x]
        
    fun dequeue [] = raise Empty
      | dequeue (x::q) = (x, q)
end;

val q :'a QUEUE.queue = QUEUE.empty;
val q1 = QUEUE.enqueue 4 q;
val q2 = QUEUE.enqueue 5 q1;

val (v1, q3) = QUEUE.dequeue q2;
val (v2, q4) = QUEUE.dequeue q3;

print("q4 is empty? " ^ (Bool.toString (QUEUE.is_empty q4)) ^ "\n");


(* If we allow Opaque ascription for module QUEUE, the following function could not work: *)
(*fun print_queue (q: int QUEUE.queue) =
    case q of
      [] => (print("\n"); ())
    | x :: [] => print (Int.toString x ^ "\n")
    | x :: tq => (print (Int.toString x ^ ", "); (print_queue tq));
 *)

fun print_queue (q: int QUEUE.queue) =
  if QUEUE.is_empty q then (print("\n"); ())
  else
    let 
      val (v, q') = QUEUE.dequeue q
    in
    print (Int.toString v) ;
    if QUEUE.is_empty q' then (print("\n"); ())
    else (print(", "); (print_queue q'))
    end;

print_queue q2;