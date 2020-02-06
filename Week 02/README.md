# Binding, Scoping and Control Flow

## (Name) Binding

- Def. An association of entities with identifiers (name)
	- Entities: classes, functions, data, types, etc.
```c++
int i = 1; // Name value
void my_func () {} // Name function
typedef int myint; // Name type
```
- Binding time: the time to make this association

### Early Binding (Static)
- Def. name binding performed before the program is running (at compile time).
- What are the benefits of static binding?
	- Efficiency: the association are made during the compilation time, which means the compiler could make some optimizations for the code generation
	- Invariance: the compilation phase fixes all types of variables and expressions.

### Late Binding (Dynamic)
- Def. name binding achieved during the program execution (during run time). 
- What are some advantages of this one?
	- Flexibility: languages give more control to programmer (e.g. postpone binding)
	- Polymorphic code: code that can be used on objects of different types is polymorphic.
		- Subtype polymorphism (**dynamic dispatch**)
		- Parametric polymorphism (**generics**)
- Consider the following Python3 code:
```Python
func_lsts = []
for i in range(3):
    def adder(x):
        return i + x
    func_lsts.append(adder)

print('{}'.format(str([adr(2) for adr in func_lsts])))
```
**Q:** What does this program output?

## Scoping
- Def. A scope is the region of program text where a binding is active.
- Global scope: binding is visible throughout the entire programs.
	- Global variable: a variable with global scope. The lifetime of this kind variable is the duration from the program started to terminated.
- Function scope: the scope of variable is within the function
	- Local variable: a variable with function scope. The lifetime is the duration of the function call.
- Variable shadowing: in a certain scope, if you redeclare a variable, the original binding is hidden, and has a hole in its scope.
- Consider the following C++ example:
```c++
using namespace std; // imports all bindings made in std namespace
int x = 0; // Assume it is a global variable

void f () {
	int x = 4; // x now binds to value 4
	cout<<"The x inside f is: "<<x<<endl;
}

f();
cout<<"The x outside f is: "<<x<<endl;
```

### Static / Lexical Scoping
- Def. binding of a name is determined by rules that refer only to the program text (i.e. its syntactic structure)
- The scope for a variable depends on the code structure.
**Q:** How do we know a variable's scoping by using static scoping approach?

```c++
float x = 0.0;
int y = 0;

void f () {
    int x = 0;
    x = x + 1;
    {
        int x = 2;
        y = y + x;
    }
    y = y - x;
}
```

### Dynamic Scoping
- Def. binding of a name is given by the most recent declaration encountered during run-time.
- The variable's scope is depending on the execution order.

**Q:** How to determine scoping of each variable under dynamic scoping?

```c++
void f () {
    cout<<x<<endl;
}

void g() {
    int x = 1;
    f();
}
```

### Scoping examples
To help you understand the difference, consider this 
C++ code:
```c++
int x = 2; // This is not a global variabe

void f(){
    int x = 3;
}

int g(){
    f();
    return x + 4;
}

int h(){
    int x = 5;
    return g();
}

printf("function g returns %d", g());
printf("function h returns %d", h());
```
1. Assume program will run under static scoping, what does this program print?
<details><summary>Solution</summary>
<p>

     ```
		function g returns 6
		function h returns 6
	  ```
     </p></details>

2. Assume program will run under dynamic scoping, what does this program print?
<details><summary>Solution</summary>
<p>

     ```
		function g returns 6
		function h returns 9
	  ```
     </p></details>