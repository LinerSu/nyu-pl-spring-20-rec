	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	$0, -4(%rbp)
	leaq	-16(%rbp), %rdi
	callq	__ZN6CLASSAC1Ev
	leaq	-16(%rbp), %rdi
	callq	__ZN6CLASSA10function_fEv
	leaq	-16(%rbp), %rdi
	callq	__ZN6CLASSA10function_gEv
	movl	$8, %eax
	movl	%eax, %edi
	callq	__Znwm
	xorl	%esi, %esi
	movl	$8, %ecx
	movl	%ecx, %edx
	movq	%rax, %rdi
	movq	%rax, -48(%rbp)         ## 8-byte Spill
	callq	_memset
	movq	-48(%rbp), %rdi         ## 8-byte Reload
	callq	__ZN6CLASSAC1Ev
	movq	-48(%rbp), %rax         ## 8-byte Reload
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	(%rdx), %rdi
	movq	%rdi, -56(%rbp)         ## 8-byte Spill
	movq	%rdx, %rdi
	movq	-56(%rbp), %rdx         ## 8-byte Reload
	callq	*(%rdx)
	movq	-24(%rbp), %rdi
	callq	__ZN6CLASSA10function_gEv
	leaq	-16(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rdx
	movq	%rax, %rdi
	callq	*(%rdx)
	movq	-32(%rbp), %rdi
	callq	__ZN6CLASSA10function_gEv
	movq	-32(%rbp), %rsi
	leaq	-40(%rbp), %rdi
	callq	__ZN6CLASSAC1ERKS_
	leaq	-40(%rbp), %rdi
	callq	__ZN6CLASSA10function_fEv
	leaq	-40(%rbp), %rdi
	callq	__ZN6CLASSA10function_gEv
	xorl	%eax, %eax
	addq	$64, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__ZN6CLASSAC1Ev         ## -- Begin function _ZN6CLASSAC1Ev
	.weak_def_can_be_hidden	__ZN6CLASSAC1Ev
	.p2align	4, 0x90
__ZN6CLASSAC1Ev:                        ## @_ZN6CLASSAC1Ev
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	callq	__ZN6CLASSAC2Ev
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__ZN6CLASSA10function_fEv ## -- Begin function _ZN6CLASSA10function_fEv
	.weak_def_can_be_hidden	__ZN6CLASSA10function_fEv
	.p2align	4, 0x90
__ZN6CLASSA10function_fEv:              ## @_ZN6CLASSA10function_fEv
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__ZN6CLASSA10function_gEv ## -- Begin function _ZN6CLASSA10function_gEv
	.weak_definition	__ZN6CLASSA10function_gEv
	.p2align	4, 0x90
__ZN6CLASSA10function_gEv:              ## @_ZN6CLASSA10function_gEv
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__ZN6CLASSAC1ERKS_      ## -- Begin function _ZN6CLASSAC1ERKS_
	.weak_def_can_be_hidden	__ZN6CLASSAC1ERKS_
	.p2align	4, 0x90
__ZN6CLASSAC1ERKS_:                     ## @_ZN6CLASSAC1ERKS_
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	__ZN6CLASSAC2ERKS_
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__ZN6CLASSAC2Ev         ## -- Begin function _ZN6CLASSAC2Ev
	.weak_def_can_be_hidden	__ZN6CLASSAC2Ev
	.p2align	4, 0x90
__ZN6CLASSAC2Ev:                        ## @_ZN6CLASSAC2Ev
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	__ZTV6CLASSA@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__ZN6CLASSAC2ERKS_      ## -- Begin function _ZN6CLASSAC2ERKS_
	.weak_def_can_be_hidden	__ZN6CLASSAC2ERKS_
	.p2align	4, 0x90
__ZN6CLASSAC2ERKS_:                     ## @_ZN6CLASSAC2ERKS_
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	__ZTV6CLASSA@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	%rax, (%rsi)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__const
	.globl	__ZTV6CLASSA            ## @_ZTV6CLASSA
	.weak_def_can_be_hidden	__ZTV6CLASSA
	.p2align	3
__ZTV6CLASSA:
	.quad	0
	.quad	__ZTI6CLASSA
	.quad	__ZN6CLASSA10function_fEv

	.section	__TEXT,__const
	.globl	__ZTS6CLASSA            ## @_ZTS6CLASSA
	.weak_definition	__ZTS6CLASSA
__ZTS6CLASSA:
	.asciz	"6CLASSA"

	.section	__DATA,__const
	.globl	__ZTI6CLASSA            ## @_ZTI6CLASSA
	.weak_definition	__ZTI6CLASSA
	.p2align	3
__ZTI6CLASSA:
	.quad	__ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	__ZTS6CLASSA


.subsections_via_symbols
