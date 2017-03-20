From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 03/10] x86: assembly, use SYM_FUNC_END for functions
Date: Mon, 20 Mar 2017 13:32:15 +0100
Message-ID: <20170320123222.15453-3-jslaby@suse.cz>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
 <20170320123222.15453-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320123222.15453-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
List-Id: linux-pm@vger.kernel.org

Somewhere END was used to end a function, elsewhere, nothing was used.
So unify it and mark them all by SYM_FUNC_END.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <linux-pm@vger.kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com> [xen parts]
Cc: <xen-devel@lists.xenproject.org>
---
 arch/x86/entry/entry_64.S            | 40 ++++++++++++++++++------------------
 arch/x86/entry/entry_64_compat.S     |  5 +++--
 arch/x86/kernel/mcount_64.S          | 12 ++++++-----
 arch/x86/power/hibernate_asm_64.S    |  2 ++
 arch/x86/realmode/rm/reboot.S        |  1 +
 arch/x86/realmode/rm/trampoline_64.S |  4 ++++
 arch/x86/realmode/rm/wakeup_asm.S    |  1 +
 arch/x86/xen/xen-asm_64.S            |  2 ++
 arch/x86/xen/xen-head.S              |  2 +-
 arch/x86/xen/xen-pvh.S               |  2 +-
 10 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d2b2a2948ffe..3e523f8d7e7f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -324,7 +324,7 @@ syscall_return_via_sysret:
 opportunistic_sysret_failed:
 	SWAPGS
 	jmp	restore_c_regs_and_iret
-END(entry_SYSCALL_64)
+SYM_FUNC_END(entry_SYSCALL_64)
 
 ENTRY(stub_ptregs_64)
 	/*
@@ -350,13 +350,13 @@ ENTRY(stub_ptregs_64)
 
 1:
 	jmp	*%rax				/* Called from C */
-END(stub_ptregs_64)
+SYM_FUNC_END(stub_ptregs_64)
 
 .macro ptregs_stub func
 ENTRY(ptregs_\func)
 	leaq	\func(%rip), %rax
 	jmp	stub_ptregs_64
-END(ptregs_\func)
+SYM_FUNC_END(ptregs_\func)
 .endm
 
 /* Instantiate ptregs_stub for each ptregs-using syscall */
@@ -399,7 +399,7 @@ ENTRY(__switch_to_asm)
 	popq	%rbp
 
 	jmp	__switch_to
-END(__switch_to_asm)
+SYM_FUNC_END(__switch_to_asm)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -435,7 +435,7 @@ ENTRY(ret_from_fork)
 	 */
 	movq	$0, RAX(%rsp)
 	jmp	2b
-END(ret_from_fork)
+SYM_FUNC_END(ret_from_fork)
 
 /*
  * Build the entry stubs with some assembler magic.
@@ -450,7 +450,7 @@ ENTRY(irq_entries_start)
 	jmp	common_interrupt
 	.align	8
     .endr
-END(irq_entries_start)
+SYM_FUNC_END(irq_entries_start)
 
 /*
  * Interrupt entry/exit.
@@ -652,7 +652,7 @@ native_irq_return_ldt:
 	 */
 	jmp	native_irq_return_iret
 #endif
-END(common_interrupt)
+SYM_FUNC_END(common_interrupt)
 
 /*
  * APIC interrupts.
@@ -664,7 +664,7 @@ ENTRY(\sym)
 .Lcommon_\sym:
 	interrupt \do_sym
 	jmp	ret_from_intr
-END(\sym)
+SYM_FUNC_END(\sym)
 .endm
 
 #ifdef CONFIG_TRACING
@@ -830,7 +830,7 @@ ENTRY(\sym)
 
 	jmp	error_exit			/* %ebx: no swapgs flag */
 	.endif
-END(\sym)
+SYM_FUNC_END(\sym)
 .endm
 
 #ifdef CONFIG_TRACING
@@ -873,7 +873,7 @@ ENTRY(native_load_gs_index)
 	SWAPGS
 	popfq
 	ret
-END(native_load_gs_index)
+SYM_FUNC_END(native_load_gs_index)
 EXPORT_SYMBOL(native_load_gs_index)
 
 	_ASM_EXTABLE(.Lgs_change, bad_gs)
@@ -903,7 +903,7 @@ ENTRY(do_softirq_own_stack)
 	leaveq
 	decl	PER_CPU_VAR(irq_count)
 	ret
-END(do_softirq_own_stack)
+SYM_FUNC_END(do_softirq_own_stack)
 
 #ifdef CONFIG_XEN
 idtentry xen_hypervisor_callback xen_do_hypervisor_callback has_error_code=0
@@ -939,7 +939,7 @@ ENTRY(xen_do_hypervisor_callback)		/* do_hypervisor_callback(struct *pt_regs) */
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	error_exit
-END(xen_do_hypervisor_callback)
+SYM_FUNC_END(xen_do_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
@@ -985,7 +985,7 @@ ENTRY(xen_failsafe_callback)
 	SAVE_EXTRA_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
-END(xen_failsafe_callback)
+SYM_FUNC_END(xen_failsafe_callback)
 
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	xen_hvm_callback_vector xen_evtchn_do_upcall
@@ -1036,7 +1036,7 @@ ENTRY(paranoid_entry)
 	SWAPGS
 	xorl	%ebx, %ebx
 1:	ret
-END(paranoid_entry)
+SYM_FUNC_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
@@ -1065,7 +1065,7 @@ paranoid_exit_restore:
 	RESTORE_C_REGS
 	REMOVE_PT_GPREGS_FROM_STACK 8
 	INTERRUPT_RETURN
-END(paranoid_exit)
+SYM_FUNC_END(paranoid_exit)
 
 /*
  * Save all registers in pt_regs, and switch gs if needed.
@@ -1147,7 +1147,7 @@ ENTRY(error_entry)
 	mov	%rax, %rsp
 	decl	%ebx
 	jmp	.Lerror_entry_from_usermode_after_swapgs
-END(error_entry)
+SYM_FUNC_END(error_entry)
 
 
 /*
@@ -1161,7 +1161,7 @@ ENTRY(error_exit)
 	testl	%ebx, %ebx
 	jnz	retint_kernel
 	jmp	retint_user
-END(error_exit)
+SYM_FUNC_END(error_exit)
 
 /* Runs on exception stack */
 ENTRY(nmi)
@@ -1509,12 +1509,12 @@ nmi_restore:
 	 * mode, so this cannot result in a fault.
 	 */
 	INTERRUPT_RETURN
-END(nmi)
+SYM_FUNC_END(nmi)
 
 ENTRY(ignore_sysret)
 	mov	$-ENOSYS, %eax
 	sysret
-END(ignore_sysret)
+SYM_FUNC_END(ignore_sysret)
 
 ENTRY(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
@@ -1525,4 +1525,4 @@ ENTRY(rewind_stack_do_exit)
 
 	call	do_exit
 1:	jmp 1b
-END(rewind_stack_do_exit)
+SYM_FUNC_END(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 73d7ff0b125c..9239f80e11ce 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -262,7 +262,7 @@ sysret32_from_system_call:
 	movq	RSP-ORIG_RAX(%rsp), %rsp
 	swapgs
 	sysretl
-END(entry_SYSCALL_compat)
+SYM_FUNC_END(entry_SYSCALL_compat)
 
 /*
  * 32-bit legacy system call entry.
@@ -340,7 +340,7 @@ ENTRY(entry_INT80_compat)
 	TRACE_IRQS_ON
 	SWAPGS
 	jmp	restore_regs_and_iret
-END(entry_INT80_compat)
+SYM_FUNC_END(entry_INT80_compat)
 
 SYM_FUNC_START(stub32_clone)
 	/*
@@ -352,3 +352,4 @@ SYM_FUNC_START(stub32_clone)
 	 */
 	xchg	%r8, %rcx
 	jmp	sys_clone
+SYM_FUNC_END(stub32_clone)
diff --git a/arch/x86/kernel/mcount_64.S b/arch/x86/kernel/mcount_64.S
index 2b4d7045e823..f3b0cb57a8c7 100644
--- a/arch/x86/kernel/mcount_64.S
+++ b/arch/x86/kernel/mcount_64.S
@@ -152,7 +152,7 @@ EXPORT_SYMBOL(mcount)
 
 ENTRY(function_hook)
 	retq
-END(function_hook)
+SYM_FUNC_END(function_hook)
 
 ENTRY(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
@@ -184,11 +184,12 @@ GLOBAL(ftrace_epilogue)
 GLOBAL(ftrace_graph_call)
 	jmp ftrace_stub
 #endif
+SYM_FUNC_END(ftrace_caller)
 
 /* This is weak to keep gas from relaxing the jumps */
 WEAK(ftrace_stub)
 	retq
-END(ftrace_caller)
+SYM_FUNC_END(ftrace_caller)
 
 ENTRY(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
@@ -259,7 +260,7 @@ GLOBAL(ftrace_regs_caller_end)
 
 	jmp ftrace_epilogue
 
-END(ftrace_regs_caller)
+SYM_FUNC_END(ftrace_regs_caller)
 
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
@@ -295,7 +296,7 @@ trace:
 	restore_mcount_regs
 
 	jmp fgraph_trace
-END(function_hook)
+SYM_FUNC_END(function_hook)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_TRACER */
 
@@ -318,7 +319,7 @@ ENTRY(ftrace_graph_caller)
 	restore_mcount_regs
 
 	retq
-END(ftrace_graph_caller)
+SYM_FUNC_END(ftrace_graph_caller)
 
 SYM_FUNC_START(return_to_handler)
 	subq  $24, %rsp
@@ -335,4 +336,5 @@ SYM_FUNC_START(return_to_handler)
 	movq (%rsp), %rax
 	addq $24, %rsp
 	jmp *%rdi
+SYM_FUNC_END(return_to_handler)
 #endif
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index ce8da3a0412c..5b6eb95e1b7b 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -68,6 +68,7 @@ ENTRY(restore_image)
 	/* jump to relocated restore code */
 	movq	relocated_restore_code(%rip), %rcx
 	jmpq	*%rcx
+SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
 ENTRY(core_restore_code)
@@ -98,6 +99,7 @@ ENTRY(core_restore_code)
 .Ldone:
 	/* jump to the restore_registers address from the image header */
 	jmpq	*%r8
+SYM_FUNC_END(core_restore_code)
 
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index d66c607bdc58..3dec2ba4adc5 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -62,6 +62,7 @@ GLOBAL(machine_real_restart_paging_off)
 	movl	%ecx, %gs
 	movl	%ecx, %ss
 	ljmpw	$8, $1f
+SYM_FUNC_END(machine_real_restart_asm)
 
 /*
  * This is 16-bit protected mode code to disable paging and the cache,
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index dac7b20d2f9d..6869f1229c3a 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -79,6 +79,8 @@ ENTRY(trampoline_start)
 no_longmode:
 	hlt
 	jmp no_longmode
+SYM_FUNC_END(trampoline_start)
+
 #include "../kernel/verify_cpu.S"
 
 	.section ".text32","ax"
@@ -116,6 +118,7 @@ ENTRY(startup_32)
 	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
 	 */
 	ljmpl	$__KERNEL_CS, $pa_startup_64
+SYM_FUNC_END(startup_32)
 
 	.section ".text64","ax"
 	.code64
@@ -123,6 +126,7 @@ ENTRY(startup_32)
 ENTRY(startup_64)
 	# Now jump into the kernel using virtual addresses
 	jmpq	*tr_start(%rip)
+SYM_FUNC_END(startup_64)
 
 	.section ".rodata","a"
 	# Duplicate the global descriptor table
diff --git a/arch/x86/realmode/rm/wakeup_asm.S b/arch/x86/realmode/rm/wakeup_asm.S
index 9e7e14797a72..b5f711327aef 100644
--- a/arch/x86/realmode/rm/wakeup_asm.S
+++ b/arch/x86/realmode/rm/wakeup_asm.S
@@ -134,6 +134,7 @@ ENTRY(wakeup_start)
 #else
 	jmp	trampoline_start
 #endif
+SYM_FUNC_END(wakeup_start)
 
 bogus_real_magic:
 1:
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index c3df43141e70..2a968c087269 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -49,6 +49,7 @@ ENTRY(xen_iret)
 1:	jmp hypercall_iret
 ENDPATCH(xen_iret)
 RELOC(xen_iret, 1b+1)
+SYM_FUNC_END(xen_iret)
 
 ENTRY(xen_sysret64)
 	/*
@@ -68,6 +69,7 @@ ENTRY(xen_sysret64)
 1:	jmp hypercall_iret
 ENDPATCH(xen_sysret64)
 RELOC(xen_sysret64, 1b+1)
+SYM_FUNC_END(xen_sysret64)
 
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 37794e42b67d..f8b2371faf62 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -32,7 +32,7 @@ ENTRY(startup_xen)
 	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
 
 	jmp xen_start_kernel
-
+SYM_FUNC_END(startup_xen)
 	__FINIT
 
 .pushsection .text
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index 5e246716d58f..7dc332435c14 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -133,7 +133,7 @@ ENTRY(pvh_start_xen)
 
 	ljmp $__BOOT_CS, $_pa(startup_32)
 #endif
-END(pvh_start_xen)
+SYM_FUNC_END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
-- 
2.12.0
