From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: [PATCH] ACPI: small formatting fixes
Date: Sun, 20 Nov 2016 22:51:49 -0800
Message-ID: <20161121065149.9760-1-nick.desaulniers@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36777 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbcKUGwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 01:52:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <nick.desaulniers@gmail.com>

A quick cleanup that passes scripts/checkpatch.pl -f <file>.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 arch/x86/kernel/acpi/cstate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index af15f44..ed52aec 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2005 Intel Corporation
- * 	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
- * 	- Added _PDC for SMP C-states on Intel CPUs
+ * Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ * - Added _PDC for SMP C-states on Intel CPUs
  */
 
 #include <linux/kernel.h>
@@ -12,7 +12,6 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
-#include <asm/acpi.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 
@@ -50,8 +49,8 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	 * P4, Core and beyond CPUs
 	 */
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
-	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
-			flags->bm_control = 0;
+			(c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
+		flags->bm_control = 0;
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
@@ -89,7 +88,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
 	retval = 0;
 	/* If the HW does not support any sub-states in this C-state */
 	if (num_cstate_subtype == 0) {
-		pr_warn(FW_BUG "ACPI MWAIT C-state 0x%x not supported by HW (0x%x)\n", cx->address, edx_part);
+		pr_warn(FW_BUG "ACPI MWAIT C-state 0x%x not supported by HW (0x%x)\n",
+				cx->address, edx_part);
 		retval = -1;
 		goto out;
 	}
@@ -103,9 +103,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
 
 	if (!mwait_supported[cstate_type]) {
 		mwait_supported[cstate_type] = 1;
-		printk(KERN_DEBUG
-			"Monitor-Mwait will be used to enter C-%d "
-			"state\n", cx->type);
+		pr_debug("Monitor-Mwait will be used to enter C-%d state\n",
+				cx->type);
 	}
 	snprintf(cx->desc,
 			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
@@ -159,13 +158,14 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 
 	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
 	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
-	                      percpu_entry->states[cx->index].ecx);
+		percpu_entry->states[cx->index].ecx);
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
 
 static int __init ffh_cstate_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return -1;
 
-- 
2.9.3

