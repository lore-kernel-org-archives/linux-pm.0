From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: [PATCH v3] ACPI: small formatting fixes
Date: Mon, 12 Dec 2016 15:28:05 -0800
Message-ID: <20161212232805.1588-1-nick.desaulniers@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34734 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcLLX2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 18:28:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com, Nick Desaulniers <nick.desaulniers@gmail.com>

A quick cleanup with scripts/checkpatch.pl -f <file>.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/x86/kernel/acpi/cstate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index af15f44..8233a63 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -12,7 +12,6 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
-#include <asm/acpi.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 
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
@@ -104,8 +104,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
 	if (!mwait_supported[cstate_type]) {
 		mwait_supported[cstate_type] = 1;
 		printk(KERN_DEBUG
-			"Monitor-Mwait will be used to enter C-%d "
-			"state\n", cx->type);
+			"Monitor-Mwait will be used to enter C-%d state\n",
+			cx->type);
 	}
 	snprintf(cx->desc,
 			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
@@ -166,6 +166,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
 static int __init ffh_cstate_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return -1;
 
-- 
2.9.3

