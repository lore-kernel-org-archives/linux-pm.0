From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/10] x86: assembly, ENTRY for fn, GLOBAL for data
Date: Fri, 17 Feb 2017 11:47:48 +0100
Message-ID: <20170217104757.28588-1-jslaby@suse.cz>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755428AbdBQKsC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Feb 2017 05:48:02 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

This is a start of series to unify use of ENTRY, ENDPROC, GLOBAL, END,
and other macros across x86. When we have all this sorted out, this will
help to inject DWARF unwinding info by objtool later.

So, let us use the macros this way:
* ENTRY -- start of a global function
* ENDPROC -- end of a local/global function
* GLOBAL -- start of a globally visible data symbol
* END -- end of local/global data symbol

The goal is forcing ENTRY to emit .cfi_startproc and ENDPROC to emit
.cfi_endproc.

This particular patch makes proper use of GLOBAL on data and ENTRY on a
function which was not the case on 4 locations.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: <xen-devel@lists.xenproject.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <linux-pm@vger.kernel.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 14 +++++++-------
 arch/x86/kernel/head_64.S        |  2 +-
 arch/x86/kernel/mcount_64.S      |  2 +-
 arch/x86/xen/xen-head.S          |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 50b8ed0317a3..bfd0ddefa5e8 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
 ENDPROC(do_suspend_lowlevel)
 
 .data
-ENTRY(saved_rbp)	.quad	0
-ENTRY(saved_rsi)	.quad	0
-ENTRY(saved_rdi)	.quad	0
-ENTRY(saved_rbx)	.quad	0
+GLOBAL(saved_rbp)	.quad	0
+GLOBAL(saved_rsi)	.quad	0
+GLOBAL(saved_rdi)	.quad	0
+GLOBAL(saved_rbx)	.quad	0
 
-ENTRY(saved_rip)	.quad	0
-ENTRY(saved_rsp)	.quad	0
+GLOBAL(saved_rip)	.quad	0
+GLOBAL(saved_rsp)	.quad	0
 
-ENTRY(saved_magic)	.quad	0
+GLOBAL(saved_magic)	.quad	0
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index b467b14b03eb..7c14ab3a0f3b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -489,7 +489,7 @@ early_gdt_descr:
 early_gdt_descr_base:
 	.quad	INIT_PER_CPU_VAR(gdt_page)
 
-ENTRY(phys_base)
+GLOBAL(phys_base)
 	/* This must match the first entry in level2_kernel_pgt */
 	.quad   0x0000000000000000
 EXPORT_SYMBOL(phys_base)
diff --git a/arch/x86/kernel/mcount_64.S b/arch/x86/kernel/mcount_64.S
index b50b283f90e4..3e35675e201e 100644
--- a/arch/x86/kernel/mcount_64.S
+++ b/arch/x86/kernel/mcount_64.S
@@ -314,7 +314,7 @@ ENTRY(ftrace_graph_caller)
 	retq
 END(ftrace_graph_caller)
 
-GLOBAL(return_to_handler)
+ENTRY(return_to_handler)
 	subq  $24, %rsp
 
 	/* Save the return values */
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 37794e42b67d..39ea5484763a 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -37,7 +37,7 @@ ENTRY(startup_xen)
 
 .pushsection .text
 	.balign PAGE_SIZE
-ENTRY(hypercall_page)
+GLOBAL(hypercall_page)
 	.skip PAGE_SIZE
 
 #define HYPERCALL(n) \
-- 
2.11.1
