#include <iostream>

using namespace std;
class CLASSA {
public:
    virtual void function_f () {}
    void function_g() {}
};

int main()
{
    CLASSA local_a; // instance
    local_a.function_f();
    local_a.function_g();
    CLASSA *dyn_a = new CLASSA(); // pointer
    dyn_a->function_f();
    dyn_a->function_g();
    CLASSA *ptr_a = &local_a;
    ptr_a->function_f();
    ptr_a->function_g();
    // CLASSA& ref_a = local_a; // reference
    // ref_a.function_f();
    // ref_a.function_g();
    return 0;
}
