# Overview of Functional Programming
- Def. a style of programming that builds the structures and elements by treating each computation as the evaluation of mathematical functions.
	- Develope everything as a 'function'.
- Functional Programming Languages: **Scheme**, OCaml, Haskell, **Standard ML**, etc.

## Function
### Lambda Calculus
- More details in the future class.
- It is the fundation of functional languages. Each function definition, function call, and recursion is represented as a formal mathematical logic.

### High Order Function
- Def. A function could take one or more functions as argument or return a function as a result.
- Consider the following python code:
```python
def printer(x):
    print(x)

def high_order_f1(f, x):
    f(x)

def high_order_f2():
    return printer

high_order_f1(high_order_f2(), 1) # 1
```
### Recursion
- Def. a method of solving a problem where the solution depends on solutions to smaller instances of the same problem.
	- In Programming Langauges, it happens when a subroutine is called from within itself.
	- For example, in Scheme:
	```scheme
	(define (rec n) ; recursive function
	  (if (zero? n) 1 (rec (- n 1)))
	)
	(rec 10) ; 1
	```
- Functional languages don't need loop statement. That is, if you want to write a iterative loop, just make it as function's recursion.
- Suppose you want to do some actions as:
	```python
	for (x in collection) {
		action
	}
	```
- The developer will translate as a function, instead of a procedure.
- The actions ususally could be classified as three parts:
	- **Filter** something inside a collection.
		- Design functions such as: `find`, `is_mem`, etc.
	- **Transform** data from a collection into a new collection.
		- `map`, `concat`, `sort`, etc.
	- **Reduce** data to a single value.
		-  `fold`, `zip`, etc.
#### Tail Recursion
- Recursive call: A function call to call itself inside its body.
- Def. it is a recursion in which no additional computation ever follows a recursive call.
- Consider the following standard ML example:
	```sml
	fun factorial n =
	    if n <= 1 then
	      1
	    else
	      n * factorial (n - 1);

	fun factorial_tail n a =
	    if n <= 1 then
	      a
	    else
	      factorial_tail (n - 1) (n * a);

	factorial 3; (* 6 *)
	factorial_tail 3 1; (* 6 *)
	```
- The most benefit for tail recursion is that the compiler can reuse the current activation record at the time of the recursive call, eliminating the need to allocate a new one, i.e. constant stack space.

## Type System
- Def. a system by giving a set of rules that assigns a type to the various constructs of a computer program, such as variables, expressions, functions or modules.
- In imperative programming languages, we usually need to annotate a type for each vairable to let compiler do type checking.
- However, the most of functional languages analyze a program to infer the types of all expressions during the compile time.

### Type Inference
- Instead of annotating types for variables and functions, type inference allows you to omit type annotation while still permmiting type checking.
- Consider the following OCaml code:
	```ocaml
	let rec fib n = (*Recursive function*)
	  if n < 3 
	  then 1 
	  else fib (n-2) + fib (n-1)

	(*val fib : int -> int = <fun>*)
	```
- More details in the future class.

## Polymorphism
- Def. by giving a single interface.
- Ad hoc polymorphism (Overloading): functions or operators can be applied to arguments of different types. That is, one interface, multiple implementations.
	- Function overloading, operator overloading, etc.
	- Functional languages usually does not enable operator overloading. Each type of value has its own operations.
- Parametric polymorphism: a function or a data type can be written generically so that it can handle values identically without depending on their type.
	- **Generic Programming**: templates in C++, generic type for function's parameter.
	- For example, consider the following OCaml program:
	```OCaml
	let id x = x
	(*val fib : 'a -> 'a = <fun>*)
	Format.printf "Hello, %s world!\n" (id "functional")
	Format.printf "Oh, we could get %d by calling id!\n%!" (id 3);
	```
	- One interface, one implementation.
- Subtyping (related to type system): If type `S` is a subtype of type `T`, does each operation on elements of the type `T` that can also operate on elements of the subtype `S`?
	- E.g. **Dynamic dispatch**, Covariance and Contravariance, etc.

## Other Properties

- Avoid mutable data: you can write programs without assignment in principle. That is, if you try to modify a data, just **bind** your result to a new variable name.
- Consider the following Scheme declarations:
	```scheme
	(define x 1) ; Allows you to use it in the future
	(let ((x 1)) (+ x 5)) ; Binding a value to variable x for use
	```
- Programming is done with expressions or declarations instead of statements. Besides, each expression must be evaluated as a value with a corresponded type (if languages support typed lambda calculus).
	- E.g. It treats `if` as an expression, so it must be evaluated as some values.
	- Consider the following OCaml code:
	```ocaml
	let x = if 10 < 20 then 7 else 5
	```
- Pattern matching: it allows you to match a variable with several patterns to avoid if-then-else checking.
	- For each pattern, do some actions based on it.
	- Consider the following Haskell codes:
	```Haskell
	-- Function signature, defines inputs and output of function
	isEven   :: Int -> Bool 
	
	-- Using recursion (imperative programming)
	isEven n = if n == 0 then True 
		else if n == 1 then False 
		else not (isEven (n-1))
	
	-- Using recursion (with pattern matching)
	isEven 0 = True
	isEven 1 = False
	isEven n = not (isEven (n-1))
	```
