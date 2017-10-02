From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 02/27] x86: assembly, use DATA_SIMPLE for data
Date: Mon,  2 Oct 2017 11:12:21 +0200
Message-ID: <20171002091246.28432-2-jslaby@suse.cz>
References: <20171002091246.28432-1-jslaby@suse.cz>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750962AbdJBJMv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Oct 2017 05:12:51 -0400
In-Reply-To: <20171002091246.28432-1-jslaby@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

We make proper use of SYM_DATA_SIMPLE on global data instead of marking
them as ENTRY. ENTRY is intended for functions and shall be paired with
ENDPROC. ENTRY also aligns symbols which creates unnecessary holes
here between data.

ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64 is
simply dropped, as these symbols are local only.

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
 arch/x86/kernel/acpi/wakeup_32.S |  4 ++--
 arch/x86/kernel/acpi/wakeup_64.S | 14 +++++++-------
 arch/x86/kernel/head_32.S        |  6 ++----
 arch/x86/kernel/head_64.S        |  5 ++---
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 0c26b1b44e51..4da9931ad4cf 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -89,8 +89,8 @@ ret_point:
 
 .data
 ALIGN
-ENTRY(saved_magic)	.long	0
-ENTRY(saved_eip)	.long	0
+SYM_DATA_SIMPLE(saved_magic, .long 0)
+saved_eip:	.long 0
 
 # saved registers
 saved_idt:	.long	0,0
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 50b8ed0317a3..d0dd131a3e7e 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
 ENDPROC(do_suspend_lowlevel)
 
 .data
-ENTRY(saved_rbp)	.quad	0
-ENTRY(saved_rsi)	.quad	0
-ENTRY(saved_rdi)	.quad	0
-ENTRY(saved_rbx)	.quad	0
+saved_rbp:		.quad	0
+saved_rsi:		.quad	0
+saved_rdi:		.quad	0
+saved_rbx:		.quad	0
 
-ENTRY(saved_rip)	.quad	0
-ENTRY(saved_rsp)	.quad	0
+saved_rip:		.quad	0
+saved_rsp:		.quad	0
 
-ENTRY(saved_magic)	.quad	0
+SYM_DATA_SIMPLE(saved_magic, .quad 0)
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 9ed3074d0d27..519ac5824a24 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -509,10 +509,8 @@ GLOBAL(early_recursion_flag)
 
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
index 42e32c2e51bb..63d17412e210 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -431,9 +431,8 @@ early_gdt_descr:
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
2.14.2
