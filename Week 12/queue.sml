signature QUEUESIG = 
sig
    type 'a queue
    val empty : 'a queue
    val is_empty : 'a queue -> bool
    val enqueue : 'a -> 'a queue -> 'a queue
    val dequeue : 'a queue -> 'a * 'a queue
    exception Empty
end;

structure QUEUE: QUEUESIG = 
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

fun print_queue (q: int QUEUE.queue) =
    case q of
      [] => ()
    | x :: [] => print (Int.toString x ^ "")
    | x :: tq => (print (Int.toString x ^ ", "); (print_queue tq));
