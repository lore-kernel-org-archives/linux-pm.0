From: Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Mon, 12 Dec 2016 09:56:55 -0800
Message-ID: <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
 <20161212085620.GA738@amd>
Mime-Version: 1.0
Content-Type: text/x-diff; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename="0001-ACPI-small-formatting-fixes.patch"
In-Reply-To: <20161212085620.GA738@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>From 47d3bcb76ef89ddbe74c8d8aacee1c0c6203a766 Mon Sep 17 00:00:00 2001
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Mon, 12 Dec 2016 09:50:23 -0800
Subject: [PATCH v2] ACPI: small formatting fixes

A quick cleanup that passes scripts/checkpatch.pl -f <file>.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 arch/x86/kernel/acpi/cstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index af15f44..37d40a3 100644
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
@@ -166,6 +165,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
 static int __init ffh_cstate_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return -1;
 
-- 
2.9.3
