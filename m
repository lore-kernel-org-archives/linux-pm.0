From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] x86_64: Save registers in saved_context during
	suspend and hibernation
Date: Mon, 13 Aug 2007 23:47:06 +0200
Message-ID: <200708132347.07396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: discuss@x86-64.org, Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

During hibernation and suspend on x86_64 save CPU registers in the saved_context
structure rather than in a handful of separate variables.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86_64/kernel/acpi/wakeup.S |  101 ++++++++++++++++++++-------------------
 arch/x86_64/kernel/asm-offsets.c |   22 ++++++++
 arch/x86_64/kernel/suspend.c     |    6 --
 arch/x86_64/kernel/suspend_asm.S |   72 ++++++++++++++-------------
 include/asm-x86_64/suspend.h     |   39 ++++++++-------
 5 files changed, 135 insertions(+), 105 deletions(-)

Index: linux-2.6.23-rc2/arch/x86_64/kernel/asm-offsets.c
===================================================================
--- linux-2.6.23-rc2.orig/arch/x86_64/kernel/asm-offsets.c	2007-08-12 12:07:51.000000000 +0200
+++ linux-2.6.23-rc2/arch/x86_64/kernel/asm-offsets.c	2007-08-13 21:38:24.000000000 +0200
@@ -76,6 +76,28 @@ int main(void)
 	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
 	DEFINE(pbe_next, offsetof(struct pbe, next));
 	BLANK();
+	DEFINE(saved_context_rbx, offsetof(struct saved_context, rbx));
+	DEFINE(saved_context_rcx, offsetof(struct saved_context, rcx));
+	DEFINE(saved_context_rdx, offsetof(struct saved_context, rdx));
+	DEFINE(saved_context_rsp, offsetof(struct saved_context, rsp));
+	DEFINE(saved_context_rbp, offsetof(struct saved_context, rbp));
+	DEFINE(saved_context_rsi, offsetof(struct saved_context, rsi));
+	DEFINE(saved_context_rdi, offsetof(struct saved_context, rdi));
+	DEFINE(saved_context_r8, offsetof(struct saved_context, r8));
+	DEFINE(saved_context_r9, offsetof(struct saved_context, r9));
+	DEFINE(saved_context_r10, offsetof(struct saved_context, r10));
+	DEFINE(saved_context_r11, offsetof(struct saved_context, r11));
+	DEFINE(saved_context_r12, offsetof(struct saved_context, r12));
+	DEFINE(saved_context_r13, offsetof(struct saved_context, r13));
+	DEFINE(saved_context_r14, offsetof(struct saved_context, r14));
+	DEFINE(saved_context_r15, offsetof(struct saved_context, r15));
+	DEFINE(saved_context_rflags, offsetof(struct saved_context, rflags));
+	DEFINE(saved_context_cr0, offsetof(struct saved_context, cr0));
+	DEFINE(saved_context_cr2, offsetof(struct saved_context, cr2));
+	DEFINE(saved_context_cr3, offsetof(struct saved_context, cr3));
+	DEFINE(saved_context_cr4, offsetof(struct saved_context, cr4));
+	DEFINE(saved_context_cr8, offsetof(struct saved_context, cr8));
+	BLANK();
 	DEFINE(TSS_ist, offsetof(struct tss_struct, ist));
 	BLANK();
 	DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
Index: linux-2.6.23-rc2/include/asm-x86_64/suspend.h
===================================================================
--- linux-2.6.23-rc2.orig/include/asm-x86_64/suspend.h	2007-08-12 12:07:51.000000000 +0200
+++ linux-2.6.23-rc2/include/asm-x86_64/suspend.h	2007-08-13 21:38:38.000000000 +0200
@@ -3,6 +3,9 @@
  * Based on code
  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
  */
+#ifndef __ASM_X86_64_SUSPEND_H
+#define __ASM_X86_64_SUSPEND_H
+
 #include <asm/desc.h>
 #include <asm/i387.h>
 
@@ -12,8 +15,24 @@ arch_prepare_suspend(void)
 	return 0;
 }
 
-/* Image of the saved processor state. If you touch this, fix acpi_wakeup.S. */
+/* Image of the saved processor state. If you touch this, fix acpi/wakeup.S. */
 struct saved_context {
+	unsigned long rax;
+	unsigned long rbx;
+	unsigned long rcx;
+	unsigned long rdx;
+	unsigned long rsp;
+	unsigned long rbp;
+	unsigned long rsi;
+	unsigned long rdi;
+	unsigned long r8;
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+	unsigned long r12;
+	unsigned long r13;
+	unsigned long r14;
+	unsigned long r15;
   	u16 ds, es, fs, gs, ss;
 	unsigned long gs_base, gs_kernel_base, fs_base;
 	unsigned long cr0, cr2, cr3, cr4, cr8;
@@ -29,27 +48,15 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
-	unsigned long eflags;
+	unsigned long rflags;
 } __attribute__((packed));
 
-/* We'll access these from assembly, so we'd better have them outside struct */
-extern unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
-extern unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
-extern unsigned long saved_context_r08, saved_context_r09, saved_context_r10, saved_context_r11;
-extern unsigned long saved_context_r12, saved_context_r13, saved_context_r14, saved_context_r15;
-extern unsigned long saved_context_eflags;
-
 #define loaddebug(thread,register) \
 	set_debugreg((thread)->debugreg##register, register)
 
 extern void fix_processor_context(void);
 
-extern unsigned long saved_rip;
-extern unsigned long saved_rsp;
-extern unsigned long saved_rbp;
-extern unsigned long saved_rbx;
-extern unsigned long saved_rsi;
-extern unsigned long saved_rdi;
-
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
+
+#endif /* __ASM_X86_64_SUSPEND_H */
Index: linux-2.6.23-rc2/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.23-rc2.orig/arch/x86_64/kernel/suspend.c	2007-08-12 12:07:51.000000000 +0200
+++ linux-2.6.23-rc2/arch/x86_64/kernel/suspend.c	2007-08-13 21:38:24.000000000 +0200
@@ -19,12 +19,6 @@ extern const void __nosave_begin, __nosa
 
 struct saved_context saved_context;
 
-unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
-unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
-unsigned long saved_context_r08, saved_context_r09, saved_context_r10, saved_context_r11;
-unsigned long saved_context_r12, saved_context_r13, saved_context_r14, saved_context_r15;
-unsigned long saved_context_eflags;
-
 void __save_processor_state(struct saved_context *ctxt)
 {
 	kernel_fpu_begin();
Index: linux-2.6.23-rc2/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.23-rc2.orig/arch/x86_64/kernel/suspend_asm.S	2007-08-12 12:07:51.000000000 +0200
+++ linux-2.6.23-rc2/arch/x86_64/kernel/suspend_asm.S	2007-08-13 21:38:24.000000000 +0200
@@ -17,24 +17,24 @@
 #include <asm/asm-offsets.h>
 
 ENTRY(swsusp_arch_suspend)
-
-	movq %rsp, saved_context_esp(%rip)
-	movq %rax, saved_context_eax(%rip)
-	movq %rbx, saved_context_ebx(%rip)
-	movq %rcx, saved_context_ecx(%rip)
-	movq %rdx, saved_context_edx(%rip)
-	movq %rbp, saved_context_ebp(%rip)
-	movq %rsi, saved_context_esi(%rip)
-	movq %rdi, saved_context_edi(%rip)
-	movq %r8,  saved_context_r08(%rip)
-	movq %r9,  saved_context_r09(%rip)
-	movq %r10, saved_context_r10(%rip)
-	movq %r11, saved_context_r11(%rip)
-	movq %r12, saved_context_r12(%rip)
-	movq %r13, saved_context_r13(%rip)
-	movq %r14, saved_context_r14(%rip)
-	movq %r15, saved_context_r15(%rip)
-	pushfq ; popq saved_context_eflags(%rip)
+	movq	$saved_context, %rax
+	movq	%rsp, saved_context_rsp(%rax)
+	movq	%rbp, saved_context_rbp(%rax)
+	movq	%rsi, saved_context_rsi(%rax)
+	movq	%rdi, saved_context_rdi(%rax)
+	movq	%rbx, saved_context_rbx(%rax)
+	movq	%rcx, saved_context_rcx(%rax)
+	movq	%rdx, saved_context_rdx(%rax)
+	movq	%r8, saved_context_r8(%rax)
+	movq	%r9, saved_context_r9(%rax)
+	movq	%r10, saved_context_r10(%rax)
+	movq	%r11, saved_context_r11(%rax)
+	movq	%r12, saved_context_r12(%rax)
+	movq	%r13, saved_context_r13(%rax)
+	movq	%r14, saved_context_r14(%rax)
+	movq	%r15, saved_context_r15(%rax)
+	pushfq
+	popq	saved_context_rflags(%rax)
 
 	call swsusp_save
 	ret
@@ -87,23 +87,25 @@ done:
 	movl	$24, %eax
 	movl	%eax, %ds
 
-	movq saved_context_esp(%rip), %rsp
-	movq saved_context_ebp(%rip), %rbp
-	/* Don't restore %rax, it must be 0 anyway */
-	movq saved_context_ebx(%rip), %rbx
-	movq saved_context_ecx(%rip), %rcx
-	movq saved_context_edx(%rip), %rdx
-	movq saved_context_esi(%rip), %rsi
-	movq saved_context_edi(%rip), %rdi
-	movq saved_context_r08(%rip), %r8
-	movq saved_context_r09(%rip), %r9
-	movq saved_context_r10(%rip), %r10
-	movq saved_context_r11(%rip), %r11
-	movq saved_context_r12(%rip), %r12
-	movq saved_context_r13(%rip), %r13
-	movq saved_context_r14(%rip), %r14
-	movq saved_context_r15(%rip), %r15
-	pushq saved_context_eflags(%rip) ; popfq
+	/* We don't restore %rax, it must be 0 anyway */
+	movq	$saved_context, %rax
+	movq	saved_context_rsp(%rax), %rsp
+	movq	saved_context_rbp(%rax), %rbp
+	movq	saved_context_rsi(%rax), %rsi
+	movq	saved_context_rdi(%rax), %rdi
+	movq	saved_context_rbx(%rax), %rbx
+	movq	saved_context_rcx(%rax), %rcx
+	movq	saved_context_rdx(%rax), %rdx
+	movq	saved_context_r8(%rax), %r8
+	movq	saved_context_r9(%rax), %r9
+	movq	saved_context_r10(%rax), %r10
+	movq	saved_context_r11(%rax), %r11
+	movq	saved_context_r12(%rax), %r12
+	movq	saved_context_r13(%rax), %r13
+	movq	saved_context_r14(%rax), %r14
+	movq	saved_context_r15(%rax), %r15
+	pushq	saved_context_rflags(%rax)
+	popfq
 
 	xorq	%rax, %rax
 
Index: linux-2.6.23-rc2/arch/x86_64/kernel/acpi/wakeup.S
===================================================================
--- linux-2.6.23-rc2.orig/arch/x86_64/kernel/acpi/wakeup.S	2007-08-04 11:59:25.000000000 +0200
+++ linux-2.6.23-rc2/arch/x86_64/kernel/acpi/wakeup.S	2007-08-12 13:38:05.000000000 +0200
@@ -4,6 +4,7 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/msr.h>
+#include <asm/asm-offsets.h>
 
 # Copyright 2003 Pavel Machek <pavel@suse.cz>, distribute under GPLv2
 #
@@ -395,31 +396,32 @@ do_suspend_lowlevel:
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq %rsp, saved_context_esp(%rip)
-	movq %rax, saved_context_eax(%rip)
-	movq %rbx, saved_context_ebx(%rip)
-	movq %rcx, saved_context_ecx(%rip)
-	movq %rdx, saved_context_edx(%rip)
-	movq %rbp, saved_context_ebp(%rip)
-	movq %rsi, saved_context_esi(%rip)
-	movq %rdi, saved_context_edi(%rip)
-	movq %r8,  saved_context_r08(%rip)
-	movq %r9,  saved_context_r09(%rip)
-	movq %r10, saved_context_r10(%rip)
-	movq %r11, saved_context_r11(%rip)
-	movq %r12, saved_context_r12(%rip)
-	movq %r13, saved_context_r13(%rip)
-	movq %r14, saved_context_r14(%rip)
-	movq %r15, saved_context_r15(%rip)
-	pushfq ; popq saved_context_eflags(%rip)
+	movq	$saved_context, %rax
+	movq	%rsp, saved_context_rsp(%rax)
+	movq	%rbp, saved_context_rbp(%rax)
+	movq	%rsi, saved_context_rsi(%rax)
+	movq	%rdi, saved_context_rdi(%rax)
+	movq	%rbx, saved_context_rbx(%rax)
+	movq	%rcx, saved_context_rcx(%rax)
+	movq	%rdx, saved_context_rdx(%rax)
+	movq	%r8, saved_context_r8(%rax)
+	movq	%r9, saved_context_r9(%rax)
+	movq	%r10, saved_context_r10(%rax)
+	movq	%r11, saved_context_r11(%rax)
+	movq	%r12, saved_context_r12(%rax)
+	movq	%r13, saved_context_r13(%rax)
+	movq	%r14, saved_context_r14(%rax)
+	movq	%r15, saved_context_r15(%rax)
+	pushfq
+	popq	saved_context_rflags(%rax)
 
 	movq	$.L97, saved_rip(%rip)
 
-	movq %rsp,saved_rsp
-	movq %rbp,saved_rbp
-	movq %rbx,saved_rbx
-	movq %rdi,saved_rdi
-	movq %rsi,saved_rsi
+	movq	%rsp, saved_rsp
+	movq	%rbp, saved_rbp
+	movq	%rbx, saved_rbx
+	movq	%rdi, saved_rdi
+	movq	%rsi, saved_rsi
 
 	addq	$8, %rsp
 	movl	$3, %edi
@@ -430,32 +432,35 @@ do_suspend_lowlevel:
 .L99:
 	.align 4
 	movl	$24, %eax
-	movw %ax, %ds
-	movq	saved_context+58(%rip), %rax
-	movq %rax, %cr4
-	movq	saved_context+50(%rip), %rax
-	movq %rax, %cr3
-	movq	saved_context+42(%rip), %rax
-	movq %rax, %cr2
-	movq	saved_context+34(%rip), %rax
-	movq %rax, %cr0
-	pushq saved_context_eflags(%rip) ; popfq
-	movq saved_context_esp(%rip), %rsp
-	movq saved_context_ebp(%rip), %rbp
-	movq saved_context_eax(%rip), %rax
-	movq saved_context_ebx(%rip), %rbx
-	movq saved_context_ecx(%rip), %rcx
-	movq saved_context_edx(%rip), %rdx
-	movq saved_context_esi(%rip), %rsi
-	movq saved_context_edi(%rip), %rdi
-	movq saved_context_r08(%rip), %r8
-	movq saved_context_r09(%rip), %r9
-	movq saved_context_r10(%rip), %r10
-	movq saved_context_r11(%rip), %r11
-	movq saved_context_r12(%rip), %r12
-	movq saved_context_r13(%rip), %r13
-	movq saved_context_r14(%rip), %r14
-	movq saved_context_r15(%rip), %r15
+	movw	%ax, %ds
+
+	/* We don't restore %rax, it must be 0 anyway */
+	movq	$saved_context, %rax
+	movq	saved_context_cr4(%rax), %rbx
+	movq	%rbx, %cr4
+	movq	saved_context_cr3(%rax), %rbx
+	movq	%rbx, %cr3
+	movq	saved_context_cr2(%rax), %rbx
+	movq	%rbx, %cr2
+	movq	saved_context_cr0(%rax), %rbx
+	movq	%rbx, %cr0
+	pushq	saved_context_rflags(%rax)
+	popfq
+	movq	saved_context_rsp(%rax), %rsp
+	movq	saved_context_rbp(%rax), %rbp
+	movq	saved_context_rsi(%rax), %rsi
+	movq	saved_context_rdi(%rax), %rdi
+	movq	saved_context_rbx(%rax), %rbx
+	movq	saved_context_rcx(%rax), %rcx
+	movq	saved_context_rdx(%rax), %rdx
+	movq	saved_context_r8(%rax), %r8
+	movq	saved_context_r9(%rax), %r9
+	movq	saved_context_r10(%rax), %r10
+	movq	saved_context_r11(%rax), %r11
+	movq	saved_context_r12(%rax), %r12
+	movq	saved_context_r13(%rax), %r13
+	movq	saved_context_r14(%rax), %r14
+	movq	saved_context_r15(%rax), %r15
 
 	xorl	%eax, %eax
 	addq	$8, %rsp
