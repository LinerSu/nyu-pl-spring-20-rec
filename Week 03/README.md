# Stack, Activation Records and Parameter Passing

## Stack
- Def. A stack is a linear structure where data are inserted and deleted according to the last-in first-out (LIFO) principle.
- Operations:
	- Push: adds the element into the container.
	- Pop: removes the most recently added element that was not yet removed.
- Stack-based memory allocation: using stack structure to maintain regions of memory.
- Stack and heap structure in the memeory:
<p align="center">
<img src="img/123.png" height="50%" width="50%">
</p>

## Activation Records / Stack Frames
- Def. the piece of memory on the stack used for storing information of a particular function call.
- Layouts: TODODODODODODODODO!
- Stack Pointer (SP): points to the top of the stack. That is, it holds the address of the last item put on the stack.
- Components
	- Return Address: store the return address that resumes at the point in the code after the call.
	- Frame Pointer (FP): a pointer that points into the activation record of a subroutine so that any objects allocated on the stack can be referred with a static offset from the frame pointer.
	- Parameter: store the data provided as input to the subroutine on the stack.
	- Static Link: a pointer that points to the activation record of the lexically surrounding subroutine. The value that is stored here is the address of the frame of the procedure that statically encloses the current procedure.
	- Dynamic Link: a pointer that points to the frame of the caller. The value that is stored here is the address of its caller’s frame on the stack.
		- What is the difference? Consider the following Python example:
		```python
		def main ():
		    x = 10
		    def f():
		        print(x)
		        g(3)
		
		    def g(y):
		        if y == 1:
		            f()
		        else:
		            print("exit!")
		    g(1)
		
		main()
		```

## Calling & Return Sequence
- Def. it is the conventional sequence of instructions to set up and call a given subroutine and to return after the subroutine is executed.
- Prologue (work before the call): management code executed at the beginning of a subroutine call.
	- E.g. Pass parameters, save return address, update static chain, change PC counter, move SP, save register values, move FP, initialize objects...
- Epilogue (work once the call is completed): management code executed at the end of a subroutine call.
	- E.g. Finalize objects, pass return value back to caller, restore...

## Calling Convention
- Def. a strategy describing how subroutines receive parameters from their caller and how they return a result. 
- Caller: function or procedure who makes the function call.
- Callee: function or procedure has been called.
- The variation depends on compiler, cpu and operation system. There is no general rule.

## Activation trees and execution procedure (Optional)
- Consider this code example:
```c++
int fib (int n) { 
     int t, s;
     if (-1 < n && n < 2) return n; 
     s = fib(n−1);
     t = fib(n−2);
     return s+t;
}
```
**Q:** If we plan to call this function as `fib(5)`, what is the real sequence of steps on the stack during the execution?
	- Using the activation trees to represent the steps.

### Activation trees
- Def. A tree structure to represent the sequence of steps. Execution corresponds to depth-first traversal of the activation tree.
- This tree is used for control flows. It represents a series of activations (function execution order).
- Consider the previous function call, it will have this activation tree:

<p align="center">
<img src="img/tree.png" height="50%" width="50%">
</p>

## Parameter passing modes

### Types of parameters
- Formal parameter (parameter): names / variables that appear in the declaration of the subroutine.
- Actual parameter (argument): the expressions passed to a subroutine at a particular call site.

```C++
void func (int x, int y) { // x and y are formal parameters
...
}
int a = 0, b = 0; 
func(a, b); // a and b are actual parameters
func(a+b, atoi("10")); // a+b and atoi("10") are acutual parameters
```
- Value assignment
	- l-value: a value for expression that could be stored in memory.
		- E.g. Variable expression.
	- r-value: a temporary value for expression that is stored in register.
		- E.g. Arithmetic expression.
	- In general, we could not do an assignment to an expression who has a r-value.
	```c++
		int x = 10 + 20;
		/*
			expression "10 + 20" has a r-value 30.
			After the execution, 'x' contains a l-value 30.
		*/
		10 = x; // Get error!
	```
	- In Ada, we have `input`, `output` and `input/output` parameter.

### Evaluation strategy

#### Strict Evaluation
- Def. the actual is evaluated before the function is evaluated.
- Call by value
  - Formal is bound to copy of value of actual
  - Assignment to formal, if allowed, changes value at location of local copy, not at location of the actual that stores the original value.
  - Language specified by default: C/C++, Java.
- Call by reference
  - Formal is bound to location of actual, forming an alias
  - Assignment to formal, if allowed, also affects actual
  - Only works if actual evaluates to a l-value (l-value: value refers to memory location)
  - Language supported: C++, C#.

#### Lazy Evaluation
- Def. the actual is evaluated only if it needs to be evaluated.
- Call by name
  - Formal is bound to *expression* of actual
  - Expression is evaluated **each time** formal is read when executing
  - Not common for doing an assginment in recent languages, usually you cannot assign a value to formal.
  	- Formal parameter has r-value. 
  - Language supported: Algol 60, Scala.
- Call by need
  - Formal is bound to *expression* of actual
  - Expression is evaluated **only the first time** its value is needed
  - **Subsequent reads** from the formal will use the value computed earlier.
  - Not common for doing an assginment in recent languages, usually you cannot assign a value to formal.
  	- Formal parameter has r-value. 
  - Language supported: Haskell, R.
  
####  How to calculate the values of several variables in the parameter passing modes? 

1. Call by value --- values are copied by actual parameters when they pass.

2. Call by reference --- formal parameter is the actual one (change formal also change actual).

3. Call by name --- formal parameter is bound by expression (execute formal by executing the expression), the parameter is evaluated until it will be used.

#### Sample Question
Consider this following Pseudo code:
```scala
def f(x: Int, y: Int) {
  x = y + 1
  println(x + y)
}

var z = 1
f(z, {z = z + 1; z}) // {z = z + 1; z} means increase z by 1 and return z
println(z)
```
What does this program print if we make the following assumptions about the parameter passing modes for the parameters `x` and `y` of `f`:

1. `x` and `y` using call-by-value parameter
	<details><summary>Solution</summary>
	<p>

	```
	5
	2
	```
     </p></details>

2. `x` is call-by-reference and `y` is call-by-value
	<details><summary>Solution</summary>
	<p>

	```
	5
	3
	```
     </p></details>

3. `x` is call-by-value and `y` is call-by-name
	<details><summary>Solution</summary>
	<p>

	```
	6
	3
	```
     </p></details>

4. `x` is call-by-reference and `y` is call-by-name
	<details><summary>Solution</summary>
	<p>

	```
	7
	4
	```
     </p></details>

- Here are more examples to practice, please check [this page](https://courses.cs.washington.edu/courses/cse341/03wi/imperative/parameters.html).

### First-class functions and Closure (Optional)
- In some programming languages (usually functional languages), they treat functions as [first-class citizen](https://en.wikipedia.org/wiki/First-class_citizen).
- The question is how could nested function access some local variables that are enclosing scopes when we call it.
- Closure: a record storing function (reference) together with an environment.
- Environment: a mapping associating each free variable of the function (variables that are used locally, but defined in an enclosing scope) with the value or reference to which the name was bound when the closure was created.
- Free variable: variable is not defined by the current function.

#### Evaluation strategy

1. Deep binding: When an inner function is passed as an argument, it will create a closure that storing function's information and environment. When it is called, the referencing environment is restored from when the closure of that function created.


2. Shallow binding: When the inner function is called, it uses the current referencing environment at the call site.

#### Example
- Consider the following Python code example:
```python
def closure_test(i, a):
    def nested():
        print(i)
    if i > 1:
        a()
    else:
        closure_test(i+1, nested)
    

def void():
    print("this should not be called!")

closure_test(1, void)
```
**Q:** What does this program print if we make the following assumptions about the parameter passing:

1. This code is running under static scoping and deep binding.
<details><summary>Solution</summary>
	<p>

	```
	1
	```
     </p></details>
2. This code is running under dynamic scoping and shallow binding.
<details><summary>Solution</summary>
	<p>

	```
	2
	```
     </p></details>
- Consider another Python example:
```python
def f(x, h):
	def g(y):
		return h(x) + y
	if (x == 0):
	    return f(2, g)
	else: return g

x = 3

def z(b):
	return  b + x # 3

print(f(0, z)(4))
```
**Q:** What does this function print? (Note that, python uses static scoping and deep binding)

<details><summary>Solution</summary>
	<p>

	```
	9
	```
     </p></details>