From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 09/29] x86: assembly, use DATA_SIMPLE for data
Date: Fri, 21 Apr 2017 16:12:45 +0200
Message-ID: <20170421141305.25180-9-jslaby@suse.cz>
References: <20170421141305.25180-1-jslaby@suse.cz>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1040362AbdDUONN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Apr 2017 10:13:13 -0400
In-Reply-To: <20170421141305.25180-1-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

This is a start of series to cleanup macros used for starting functions,
data, globals etc. across x86. When we have all this sorted out, this
will help to inject DWARF unwinding info by objtool later.

The goal is forcing SYM_FUNC_START to emit .cfi_startproc and
SYM_FUNC_END to emit .cfi_endproc. Automatically (by objtool) at best.

This particular patch makes proper use of SYM_DATA_SIMPLE on data
instead of ENTRY. This was not the case on these 4 locations. Rationale:
ENTRY is intended for functions and is to be paired with ENDPROC. It
also aligns symbols which creates unnecessary holes between data.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_32.S | 10 +++++-----
 arch/x86/kernel/acpi/wakeup_64.S | 14 +++++++-------
 arch/x86/kernel/head_32.S        |  6 ++----
 arch/x86/kernel/head_64.S        |  5 ++---
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index ea9a29e6a96c..11fb24d15f3d 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -91,11 +91,11 @@ ENDPROC(do_suspend_lowlevel)
 
 .data
 ALIGN
-ENTRY(saved_magic)	.long	0
-ENTRY(saved_eip)	.long	0
+SYM_DATA_SIMPLE(saved_magic, .long 0)
+SYM_DATA_SIMPLE_LOCAL(saved_eip, .long 0)
 
 # saved registers
-saved_idt:	.long	0,0
-saved_ldt:	.long	0
-saved_tss:	.long	0
+SYM_DATA_SIMPLE_LOCAL(saved_idt, .long 0,0)
+SYM_DATA_SIMPLE_LOCAL(saved_ldt, .long 0)
+SYM_DATA_SIMPLE_LOCAL(saved_tss, .long 0)
 
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 50b8ed0317a3..e53a03648cc7 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
 ENDPROC(do_suspend_lowlevel)
 
 .data
-ENTRY(saved_rbp)	.quad	0
-ENTRY(saved_rsi)	.quad	0
-ENTRY(saved_rdi)	.quad	0
-ENTRY(saved_rbx)	.quad	0
+SYM_DATA_SIMPLE_LOCAL(saved_rbp, .quad 0)
+SYM_DATA_SIMPLE_LOCAL(saved_rsi, .quad 0)
+SYM_DATA_SIMPLE_LOCAL(saved_rdi, .quad 0)
+SYM_DATA_SIMPLE_LOCAL(saved_rbx, .quad 0)
 
-ENTRY(saved_rip)	.quad	0
-ENTRY(saved_rsp)	.quad	0
+SYM_DATA_SIMPLE_LOCAL(saved_rip, .quad 0)
+SYM_DATA_SIMPLE_LOCAL(saved_rsp, .quad 0)
 
-ENTRY(saved_magic)	.quad	0
+SYM_DATA_SIMPLE(saved_magic, .quad 0)
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index e2acba5b0f2f..b9b6c6ff16a0 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -548,10 +548,8 @@ GLOBAL(early_recursion_flag)
 
 __REFDATA
 	.align 4
-ENTRY(initial_code)
-	.long i386_start_kernel
-ENTRY(setup_once_ref)
-	.long setup_once
+SYM_DATA_SIMPLE(initial_code, .long i386_start_kernel)
+SYM_DATA_SIMPLE(setup_once_ref, .long setup_once)
 
 /*
  * BSS section
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index e1da48448cc0..dace17c6c5fe 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -488,9 +488,8 @@ early_gdt_descr:
 early_gdt_descr_base:
 	.quad	INIT_PER_CPU_VAR(gdt_page)
 
-ENTRY(phys_base)
-	/* This must match the first entry in level2_kernel_pgt */
-	.quad   0x0000000000000000
+/* This must match the first entry in level2_kernel_pgt */
+SYM_DATA_SIMPLE(phys_base, .quad 0x0000000000000000)
 EXPORT_SYMBOL(phys_base)
 
 #include "../../x86/xen/xen-head.S"
-- 
2.12.2
