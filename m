From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 07/10] x86/asm/acpi: Fix asmvalidate warnings for wakeup_64.S
Date: Wed, 10 Jun 2015 07:06:15 -0500
Message-ID: <2817f5690aa760a601a614b738545fd60b087bbb.1433937132.git.jpoimboe@redhat.com>
References: <cover.1433937132.git.jpoimboe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433937132.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Michal Marek <mmarek@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Fix the following asmvalidate warnings:

   asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x15: unsupported jump to outside of function
   asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64()+0x55: unsupported jump to outside of function
   asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: wakeup_long64(): unsupported fallthrough at end of function
   asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x9a: unsupported jump to outside of function
   asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel()+0x116: unsupported jump to outside of function
   asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): unsupported fallthrough at end of function
   asmvalidate: arch/x86/kernel/acpi/wakeup_64.o: do_suspend_lowlevel(): missing FP_SAVE/RESTORE macros

1. wakeup_long64() isn't a function that can be called.  It's actually
   redirected to via a return instruction in the entry code.  It
   shouldn't be annotated as a callable function.  Change ENDPROC ->
   PROC accordingly.

2. do_suspend_lowlevel() is a non-leaf callable function, so
   save/restore the frame pointer with FP_SAVE/RESTORE.

3. Remove the unnecessary jump to .Lresume_point, as it just results in
   jumping to the next instruction (which is a nop because of the
   align).  Otherwise asmvalidate gets confused by the jump.

4. Change the "jmp restore_processor_state" to a call instruction,
   because jumping outside the function's boundaries isn't allowed.  Now
   restore_processor_state() will return back to do_suspend_lowlevel()
   instead of do_suspend_lowlevel()'s caller.

5. Remove superfluous rsp changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_64.S | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 8c35df4..7e442be 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -5,6 +5,7 @@
 #include <asm/page_types.h>
 #include <asm/msr.h>
 #include <asm/asm-offsets.h>
+#include <asm/func.h>
 
 # Copyright 2003 Pavel Machek <pavel@suse.cz>, distribute under GPLv2
 
@@ -33,13 +34,13 @@ ENTRY(wakeup_long64)
 
 	movq	saved_rip, %rax
 	jmp	*%rax
-ENDPROC(wakeup_long64)
+END(wakeup_long64)
 
 bogus_64_magic:
 	jmp	bogus_64_magic
 
 ENTRY(do_suspend_lowlevel)
-	subq	$8, %rsp
+	FP_SAVE
 	xorl	%eax, %eax
 	call	save_processor_state
 
@@ -70,12 +71,11 @@ ENTRY(do_suspend_lowlevel)
 	movq	%rdi, saved_rdi
 	movq	%rsi, saved_rsi
 
-	addq	$8, %rsp
 	movl	$3, %edi
 	xorl	%eax, %eax
 	call	x86_acpi_enter_sleep_state
+
 	/* in case something went wrong, restore the machine status and go on */
-	jmp	.Lresume_point
 
 	.align 4
 .Lresume_point:
@@ -108,8 +108,9 @@ ENTRY(do_suspend_lowlevel)
 	movq	pt_regs_r15(%rax), %r15
 
 	xorl	%eax, %eax
-	addq	$8, %rsp
-	jmp	restore_processor_state
+	call	restore_processor_state
+	FP_RESTORE
+	ret
 ENDPROC(do_suspend_lowlevel)
 
 .data
-- 
2.1.0
