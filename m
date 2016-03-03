From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] PM: Fix crash on graph trace through x86 suspend
Date: Wed,  2 Mar 2016 16:05:29 -0800
Message-ID: <1456963529-4962-1-git-send-email-todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59251 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149AbcCCAFi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Mar 2016 19:05:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com
Cc: rjw@rjwysocki.net, todd.e.brandt@intel.com, todd.e.brandt@linux.intel.com

Pause/unpause graph tracing around do_suspend_lowlevel as it has
inconsistent call/return info after it jumps to the wakeup vector.
The graph trace buffer will otherwise become misaligned and
may eventually crash and hang on suspend.

To reproduce the issue and test the fix:
Run a function_graph trace over suspend/resume and set the graph 
function to suspend_devices_and_enter. This consistently hangs the
system without this fix.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 arch/x86/kernel/acpi/sleep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index d1daead..311360e 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -16,6 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/realmode.h>
 
+#include <linux/ftrace.h>
 #include "../../realmode/rm/wakeup.h"
 #include "sleep.h"
 
@@ -107,7 +108,13 @@ int x86_acpi_suspend_lowlevel(void)
        saved_magic = 0x123456789abcdef0L;
 #endif /* CONFIG_64BIT */
 
+	/*
+	 * Pause/unpause graph tracing around do_suspend_lowlevel as it has
+	 * inconsistent call/return info after it jumps to the wakeup vector
+	 */
+	pause_graph_tracing();
 	do_suspend_lowlevel();
+	unpause_graph_tracing();
 	return 0;
 }
 
-- 
2.1.4

