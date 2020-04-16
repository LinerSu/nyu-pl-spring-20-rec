# Module & Functor

## Module
- Def. a module is a construct that enables decomposition, information hiding, and (often) separate compilation.
- Why we need module?
	- Reduce large program into small, independent and reusable components (a.k.a. [decomposition](https://en.wikipedia.org/wiki/Decomposition_(computer_science))).
	- Hiding information about data structure to protect  the data.
	- Hiding detailed information about the implementation for the remainder of the program.
	- Reduce risk of name conflicts (e.g. `namespace` in `C++`, `package` in `Java`)
- In programming paradigm, the module exists with two major reasons:
	- **Seperate reasoning**: designing a software requires conceptual modeling, which is finally achieved by modularizing.
	- Seperate compilation: compiling each unit indepdently avoids recompiling the entire program, even if the cost of compiling individual module + linking is more expensive than a single file compilation.
- The scale of "module" varies significantly between languages: 
	- `Ada`: packages
	- `C`: header files (`.h` files)
	- `C++`: header files, classes, namespaces
	- `Java`: interfaces, classes, and packages
	- `Python`: classes, packages
	- `SML`: modules and functors
	- `Javascript`: objects, classes, and packages
	- Some langauges treat a single program file as a module.
- Information hiding (principle of encapsulation)
	- Def. it is ability to stop certain aspects of a class or software component from being accessible to its clients (people who use your class)
	- The implementation could use either programming language features (e.g `private` variables, inheritence, and [abstract data type](https://en.wikipedia.org/wiki/Abstract_data_type#Examples_2)) or "an explicit agreement".

## SML's Module System
- Standard ML supports the module system as `signature`, `structure`, and `functor`.
- Each module consists of a module signature and a module implementation.

### Module Signature
- Def. it is an public interface of a module. It represents a type of a module.
- The signature is composed of a sequence of declarations introducing module members, including values, types, or nested modules.
- Syntax
	- The signature of a module is defined inside a `sig` expression; `sig` expressions must be bound to a name using a `signature` declaration:
	```sml
	signature <NAME> = 
	sig
	    type [TYPE_VARIABLE] <NAME> [= <TYPE>]
	    val <NAME>: <TYPE>
	    exception <NAME> [of <TYPE>]
	end;
	```
- For instance, here is one example to declare a queue container:
	```sml
	signature QUEUESIG = 
	sig
	    type 'a queue
	    val empty : 'a queue
	    val is_empty : 'a queue -> bool
	    val enqueue : 'a -> 'a queue -> 'a queue
	    val dequeue : 'a queue -> 'a * 'a queue
	    exception Empty
	end;
	```

### Module Structure
- Def. it is how the actual implementation of a module
- Syntax
	- The implementation of a module is defined inside a `struct` expression; `struct` expressions must be bound to a name using a `structure` declaration:
	```sml
	signature <NAME> = 
	sig
	    type [TYPE_VARIABLE] <NAME> = <TYPE>
	    exception <NAME> [of <TYPE>]
	    (* value binding *)
	    val <NAME>[: <TYPE>] = <value>
	    (* function binding *)
	    fun <NAME> <PARAMETER_LIST> = <FUNC_BODY>
	end;
	```
- Order does not matter: the structure contains an "arbitrary" sequence of definitions. This means the order of definitions does not rely on the declarations.
- A module structure can include more definitions than those declared in a module signature; even so, it must at least provide definitions for all the members declared in the signature.
	- Thus, the types of required definitions must be consistent with the types provided in the signature. 
	- For example, suppose we want to implement the queue container that we declared before:
	```sml
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
	```
- The structure could be "labled" with a signature. However, if a structure does not specify to any predefined signature, the compiler will automatically generates a signature for the structure --- the one that mirrors all its bindings and types. 
	- For example:
	```sml
	structure QUEUE = 
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
	```
	- Now, the `QUEUE` module has a signature as:
	```sml
	structure QUEUE :
	  sig
	    type 'a queue = 'a list
	    exception Empty
	    val empty : 'a queue
	    val is_empty : 'a queue -> bool
	    val enqueue : 'a -> 'a list -> 'a list
	    val dequeue : 'a list -> 'a * 'a list
	  end
	```
- Open a module: you may need to use a module lots of time, but it is inconvenient to refer that module members by the full structure path. ML supports an `open` declaration, which imports all members of a module into the current scope.
	- For example, let's define several queue base on some operations:
		```sml
		val q :'a QUEUE.queue = QUEUE.empty;
		val q1 = QUEUE.enqueue 4 q;
		val q2 = QUEUE.enqueue 5 q1;
		
		val (v1, q3) = QUEUE.dequeue q2;
		val (v2, q4) = QUEUE.dequeue q3;
		
		print("q4 is empty? " ^ (Bool.toString (QUEUE.is_empty q4)) ^ "\n");
		```
	- To simplify the code, we could `open QUEUE` at the top:
	```sml
	open QUEUE;
	val q :'a queue = empty;
	val q1 = enqueue 4 q;
	val q2 = enqueue 5 q1;
		
	val (v1, q3) = dequeue q2;
	val (v2, q4) = dequeue q3;
		
	print("q4 is empty? " ^ (Bool.toString (is_empty q4)) ^ "\n");
	```
- Information hiding in SML: I would rather say SML is not a good expert on information hiding. Consider the following example of the client code:
	```sml
	fun print_queue (q: int QUEUE.queue) =
		case q of
		  [] => ()
		| x :: [] => print (Int.toString x ^ "")
		| x :: tq => (print (Int.toString x ^ ", "); (print_queue tq));
	```
	- Ideally, the implementation of the type `'a queue` is not specified in the signature. The client should not get the information that `'a queue = 'a list`. However, the client code could match the input queue with list patterns. This means that the details of the implemeation for type in module are not fully hidden. In other languages ML family, this problem is solved.

### Functors - functions over modules
- Def. it is a module that takes one or more modules as parameters for implementation.
- You could imagine a functor might be a "function" with a signature `<module> -> ... -> <module>`.
- In SML, it has the form of a functor as:
	```sml
	functor <NAME>(<PARAMS>): <SIG> = <STRUCT>
	(* or *)
	functor <NAME>(<PARAMS>) = <STRUCT>
	```
	- `<PARAMS>` are the formal functor parameters, and they are modules. Note that, for each structure parameter, it must contain a signature. That is, `<MODULE_NAME>:<MODULE_SIG>`.
	- `<SIG>` represents the signature of the functor. Still, it is provided optionally.

## Exercise
- Let's think about a real example. Suppose we want to build a `Map` structure. 
- `Map` structure is a dictionary structure that organizes data as key/value pairs. However, the real programming requires efficiency and easy-to-manipulate. We just ignore them in here.
- In some programming languages, `Map` is internally represented as either (balanced) binary search trees or red-black trees. 
- Back to our question, how could we implement it via module and functor?
- Signature: suppose we want our `Map` structure contains at least these functionalities: `find`, `empty`, `add`.
	- Our declarations could be:
	 ```sml
	 signature MAPTYPE =
	  sig
	    type key
	    type 'a t
	
	    val empty: 'a t
	    val add:   key -> 'a -> 'a t -> 'a t
	    val find:  key -> 'a t -> 'a
	  end;
	 ```
- Structure: 
	- To simplify our implementation, let's use binary search tree to construct the `Map` structure. 
	- Moreover, assume the key for a `Map` is an integer.
	- Thus, the structure of our `Map` should be:
	```sml
	structure MAP: MAPTYPE = 
	struct
	    type key = int
	    exception Not_Found
	
	    datatype 'a t = Empty
	        | Node of 'a t * key * 'a * 'a t
	      (* left subtree * key * value * right subtree *)
	
	    val empty = Empty
	    
	    fun add x v t = 
	        case t of
	        Empty => Node (Empty, x, v, Empty)
	      | Node (l, k, v', r) =>
	        if x = k then Node (l, x, v, r)
	        else if x < k then Node(add x v l, k, v', r)
	        else Node(l, k, v', add x v r)
	        
	    fun find x t = 
	        case t of
	        Empty => raise Not_Found
	      | Node (l, k, v, r) =>
	            if x = k then v
	            else if x < k then find x l
	            else find x r
	end;
	```
- Functor: Now, what if we want to generalize the type for our key? How to do that?
	- The idea is trying to change our `Map` module to a functor, which takes a module to order our `key` (usually we call `OrderedType`):
	```sml
	signature ORDTYPE =
	  sig
	    type t
	    val compare: t -> t -> int
	  end;

	functor MAKEMAP(Ord: ORDTYPE) :
	  sig
	    type key
	    type 'a t

	    exception Not_Found

	    val empty: 'a t
	    val add:   key -> 'a -> 'a t -> 'a t
	    val find:  key -> 'a t -> 'a
	  end
	= struct
	    type key = Ord.t
	    exception Not_Found

	    datatype 'a t = Empty
		| Node of 'a t * key * 'a * 'a t
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
	```
	- If we have the above functor, we could create a `Map` that generalize the type for key and value. For example:
	```sml
	structure intOrd: ORDTYPE = 
	struct 
	    type t = int
	    fun compare x y = 
		if x < y then ~1 else if x > y then 1 else 0
	end;

	structure intMap = MAKEMAP(intOrd);

	val m = intMap.empty;
	val m1 = intMap.add 1 0 m;
	val m2 = intMap.add 3 2 m1;
	val m3 = intMap.add 0 5 m2;
	val found = intMap.find 0 m3;
	val noutFound = intMap.find 4 m3;
	```
