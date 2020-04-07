# Standard ML, Types, Type System & Polymorphism
## Introduction to Standard ML
### Installation
- You can use [this](https://www.smlnj.org/) website to download Standard ML.
- Please follow the [instructions](https://www.smlnj.org/dist/working/110.96/index.html) to download SML.
- Once installed, type `sml` in your terminal to use SML compiler.
- You can also write a file of your assignment by using `.sml` extension. After named SML source file, open the compiler and type this:
```
- use "<file_name>.sml";
```

### Basic Syntax

#### Declarations
- Binding: a binding is a name associated with a value.
- value bindings
	- Bind a value to a variable
	```sml
	val x = 3
	val y = x + 1
	```
- function bindings
	- Bind a function to a expression
	```sml
	fun fib x = if x < 3 then 1 
		else fib (x - 1) + fib (x - 2)
	```
- Generally, formats of those bindings could be:
	```sml
	val <pat> = <exp>
	fun f <pat> = <exp>
	``` 

#### Expressions
- Basic expressions
	```sml
	(* Integers *)
	1
	~3 (*Negative 3*)
	
	(* Reals *)
	3.14
	~3.2E3
	
	(* Booleans *)
	true
	false
	
	(* Strings *)
	" This is a string "
	"A string" ^ " with another"
	```
- Arithmetic expressions
	```sml
	3 + 4
	3 + 4.0 (* WRONG ✘! SML does not support convertion *)
	real 3 + 4.0 (* or 3.0 + 4.0 *)
	3 <> 4 (* not equal, val it = true : bool *)
	```
- Control flow expressions
	- if-then-else:
		```sml
		(* Format: 
			if <cond> then <exp> else <exp> 
		*)
		 
		if true then 3 else false (* WRONG ✘! types of then branch and else branch should be the same *)
		```
	- Multiple selection (switch): 
		```sml
		(* Format:
			case <exp1> of
			<pattern_1> => <exp>
			| <pattern_2> => <exp>
			| · · · · · · · · ·
			| <pattern_n> => <exp>
		*)
		fun compare (x, y) =
			if x < y then ~1
			else if x > y then 1
			else 0;
					
		case compare(3, 4) of
			 1 => "Greater"
			| ~1 => "Less"
			| 0 => "Equal"
			| _ => "Error input!" ;
		```
- [`let` binding expression](https://en.wikipedia.org/wiki/Let_expression)
	```sml
	(* Format
	let <decl> in <expr> end
	*)
	let 
		val x = 2
		fun add_two y = x + y
	in
		add_two 3
	end
	```
	
#### Lists and Tuples
- Lists
	- Basic forms
	```sml
	(* Format:
	[ <exp1>, ..., <expn> ] means constructing a list
	:: means adding an element at the beginning
	*)
	[] or nil (* an empty list *)
	[1,2,3] or 1::2::3::nil (* int list *)
	[1,false,"test"] (* WRONG ✘! The elements inside list must have the same type *)
	```
	- Manipulations
	```sml
	(* Matching a list *)
	val lst = [1, 2];
	val a::b::nil = lst;
	
	let 
		val lst = ["1","2","3"]
   		val lst2 = "0" :: lst (* Bind a new list*)
	in
	case lst2 of
	    [] => print "Empty\n"
	    | hd::tl => print (hd^"\n")
	end;
	```
- Tuples
	- Basic forms
	```sml
	(* Format:
	(exp1, ... , expn) means construct a tuple
	#i means get an i-th item from a tuple
	*)
	val tp = (3, true, "This")
	val snd = #2 tp
	(* val snd = true : bool *)
	```
	- Manipulations
	```sml
	(* Matching a tuple *)
	val p = (3, 4)
	val (x, y) = p (* Match patterns for a tuple *)
	
	fun plus (x, y) = x + y
	(* val plus = fn : int * int -> int *)
	```

#### Functions
- Function declarations
	```sml
	(* Format:
	fun <fun_name> <param 1...> = <fun_body>
	<param 1...> must contain at least one parameter
	fn <param> => <fun_body>
	<param> has to contain (at most) one parameter 
	*)
	fun add x y = x + y;   (* function declaration *)
	fn x => fn y => x + y; (* anonymous function expression *)
	```
- Examples:
	```sml
	val plusOne = fn x => x + 1;
	```
	- A `fn` that is defined by a lambda abstraction as in the previous example can be abbreviated by:
	```sml
	fun plusOne x = x + 1;
	```
- Function types: function types are constructed using the arrow type constructor `->`. The type `t1 -> t2` represents functions that take a value of type `t1` and return a value of type `t2`.
	- For instance,
	```sml
	fun add x y = x + y;
	(* val add = fn : int -> int -> int *)
	```
	- Remember that, lambda  abstraction is right associative. The type of that function should be interpreted as `int -> (int -> int)`. **Why?**
	- If you call function `add` with only one argument, you will get a new function with a body:
	```sml
	val add_one = add 1; 
	(* val add_one = fn : int -> int *)
	
	(* The body of add_one is:
	val add_one = fn y => 1 + y;
	*)
	```

### SML Types and Semantics
- Check details in [next class](https://github.com/LinerSu/nyu-pl-spring-20-rec/tree/master/Week%2010#standard-ml)

## Types, Type System & Polymorphism

### Type or Data Type
- Def. a type describes a set of possible values that share the same mapping to the low-level representation and a set of operations that perform computations on those values. 
- Different view points of type:
	- Denotational view:
		- A type **T** is a set of values
		- A value has type **T** if it belongs to the set
		- An expression has type **T** if it evaluates to a value in the set
	- Constructive view:
		- A type is either:
			- A built-in primitive type (`int`, `bool`, `real`, `char`, etc.)
			- A composite type constructed from simpler types using a type-constructor (`array`, `record`, `list`, etc.)
	- Abstraction-based view:
		- Type is an interface consisting of a set of operations.
- Why we need type?
	- Detecting errors: detecting run-time errors related to operations on values that are not of the appropriate data type.
		- Consider the following sml program:
		```sml
		fun f (x: int): int = x + 1;
		
		f "test";
		```
		- If SML compiler continued executing `"test" + 1` without producing a type error, this would cause unintended behavior inside the low-level representation of numbers and strings due to incompatible. However, the compiler will raise this error:
		```
			Error: operator and operand don't agree [tycon mismatch]
	  		operator domain: int
	  		operand:         string
		```
	- Documentation:
		- The programmer could use type annotations for reading. Type declarations in function headers document the constraints of inputs and outputs, which guarantees the behavior in a way.
			- Consider the following C++ program:
			```c++
			int f (int x) {
				return x + 1;
			}
			f("test"); // Based on the declaration, this call won't be allowed.
			``` 
	- Abstraction: Types are fundamental to module and class that help to structure large programs into smaller components. 
		- In particular, types help to abstract away implementation details of these components.
		- That is, if we changes the internal implementation details of one module, it does not affect other modules in the program.
		- E.g. abstract class in Java:
		```java
		abstract class Collection  
		{ 
		    // declare fields 
		    int size;
		    ArrayList<Integer> data;
		      
		    // declare non-abstract methods 
		    // it has default implementation 
		    public int getSize() { return this.size; } 
		      
		    // abstract methods which will be 
		    // implemented by its subclass(es) 
		    abstract public void push(int item);
		}
		
		class Stack extends Collection { 
		    public void push(int item) {
		        ...
		    }
		}
		
		class Queue extends Collection { 
		    public void push(int item) {
		        ...
		    }
		} 
		```

### Type System
- Def. a system by giving a set of rules that assigns a type to the various constructs of a computer program, such as variables, expressions, functions or modules.
- Motto: "Do not believe programmer!"
- Type system also gives us a set of rules for:
	- Type compatibility: answers a question when a particular value (or expression) of type `t` can be used in a context that expects a different type `s`.
		- For instance, consider the following expression:
		```
		1.2 + 2
		```
		- The operator `+` will be treated as `Float` (`Real`) operation. This means the operands should contain the same type, which is `Float`. However, `2` has a type `Int`.
		- In C/C++, Java or Scheme compiler, `2` requires be [converted](https://en.wikipedia.org/wiki/Type_conversion) from type `Int` to type `Float` during computation.
		- In SML, OCaml, they will detect type error in the second operand. Those languages don't do this implicit conversion.
	- Type checking: a process of ensuring a program that obeys the typing rules. 
		- A violation could casue *type error*. 
		- If a program that is free of type errors, this program is cosidered as *well-typed*.
	- Type Inference: a process to analyze a program by automatically inferring the types of all expressions during the compile time.
	- Type equivalence: a process to determine whether two types are considered to be equal.
		- Name equivalence: two types are the same only if they have the same name.
		- Structural equivalence: two types are equivalent if they have the same structure. Take a SML program as an instance:
		```sml
		type A = int * int;
		type B = int * int;
		
		val m : A = (2, 3);
		val n : B = m;
		val k : int * int = n;
		(* A = B = int * int *)
		```

#### Type checking
- Strong vs. Weak type systems
	- A strongly type language captures both consistent type invariants of the code, and ensure its correctness. This guarantees that all type errors and exceptions coudl be detected.
		- E.g. Java, Scala, OCaml, Python, Lisp, and Scheme.
	- A weekly type language might allow some ways to avoid using the type system. This will cause some undetected errors during execution.
	- E.g. Memory leak by using a pointer in C/C++ 
	```c++
	void memory_leak()
	{
	    for (int i = 0; i < 1000; ++i) {
	    	int * ptr = new int(3);
	    }
	    // Return without deallocating ptrs
	}
	 
	int main()
	{
	    for (int i = 0; i < 1000; ++i) {
	    	memory_leak();
	    }
	    return 0;
	}
	```
- Static vs. Dynamic type systems
	- Static typing: detect type errors at compile time.
	```
	int i = 0; // Annotating types: Java, C/C++
	val m = 3 ; (* Type infer: SML *)
	```
	- Dynamic typing: detect type errors during the run time. 
	```
	(def x 1) ; Scheme
	k = 1     # Python
	```
- **Note that**, the distinction between weak/strong and static/dynamic is not always clear cut.

#### Type Inference
- Instead of annotating types for variables and functions, type inference allows you to omit type annotation while still permmiting type checking.
- That is, it concerns the problem of statically inferring the type of an expression from the types of its parts.
- Consider the following Standard ML code:
	```sml
	(*val fib = fn : int -> int*)
	fun fib n =
    if n < 3 then
        1
    else
        fib (n-1) + fib (n-2);

	fib 6;
	```
	- Even if the type of the function `fib` is not explicitly specified, the SML compiler can infer the type of function `fib` by the following procedures:
		- The body of `fib` contains a `if` expression, the value of that expression will be a return value for `fib`.
			- The conditional expression compares two integers, which infers `n` has a type of `int`. 
			- The `then` branch contains `1` which has a type `int`.
			- The `else` branch contains integer addition `+`, which implies the result has a type `int`.
		- Thus, the `if` expression has a type of `int`. This means function should return a value which has a type of `int`.
- More details in the next class.

### Polymorphism
- Def. by providing a single interface, the compiler could use that interface(e.g. type, operator, variable, function) to represent many forms.
- Categories
	- Ad hoc polymorphism (Overloading): functions or operators can be applied to arguments of different types.
		- Function overloading, operator overloading, etc.
		- For instance of function overloading, consider the following C++ code:
		```c++
		bool comp (int x , int y) {
			return x > y;
		}
		
		bool comp (string x, string y) {
			return x.compare(y) > 0 ? true : false;
		}
		
		int comp () {
			return 0;
		}
		
		int main()
		{
		    cout<<"Empty: "<<comp()<<endl;
		    cout<<"Int: "<<comp(2, 3)<<endl;
		    cout<<"Str: "<<comp("c", "b")<<endl;
		    return 0;
		}
		```
		- Note that, the `comp` functions could also have different numbers of parameters and different types of output.
	- Parametric polymorphism: a function or a data type can be written generically so that it can handle values identically without depending on their type.
		- **Generic Programming**: templates in C++, generic type for function's parameter.
		- For example of the generic type, consider the following SML program:
		```sml
		fun id x = x;
		(*val id = fn : 'a -> 'a*)
		print("Hello, "^(id "functional")^" world!\n");
		print("Oh, we could get "^(Int.toString (id 3))^" by calling id!\n");
		```
	- Subtyping (related to type system): If type `S` is a subtype of type `T`, does each operation on elements of the type `T` that can also operate on elements of the subtype `S`?
		- E.g. **Dynamic dispatch**, Covariance and Contravariance, etc.
		- Take a C++ class inheritence and dynamic dispatch as an example:
			```c++
			class A
			{
			public:
			  virtual void f() { cout<<"Use method inside Class A"<<endl; }
			};
			
			class B: public A
			{
			public:
			  void f() { cout<<"Use method inside Class B"<<endl; }
			};
			
			int main()
			{
			    A *pa = new B();
			    pa->f(); // What does this line print?
			    return 0;
			}	
			```
		- More details in the future class.

### Limitations of Type System
- Problem: the compiler (type checker) will reject all bad programs but also some good ones
- Restirction with polymorphism: do not trust programmer given input parameter with correct type
	- Consider the following SML example:
	```sml
	fun id x = x; (*val id = fn : 'a -> 'a*)
	val main = 
	    let
	        fun g f = (f 3, f true)
	    in
	        g id
	    end;
	(*
	Error: operator and operand don't agree [overload conflict]
	  operator domain: [int ty]
	  operand:         bool
	  in expression:
	    f true
	*)
	```
	- The type of parameter will be treated as monomorphically. That is, the type must be inferred by the current context.
- Recursive function: type systems does not allow cyclic program structure
	- For example, consider the following SML example:
	```sml
	fun hungry (x: int) = hungry;
	(*
	Error: right-hand-side of clause doesn't agree with function result type [circularity]
	  expression:  int -> 'Z
	  result type:  'Z
	  in declaration:
	    hungry = (fn x : int => hungry)
	*)
	```
	- The reason is causing by [occurs check](https://en.wikipedia.org/wiki/Occurs_check): unification of a variable V and a structure S to fail if S contains V
