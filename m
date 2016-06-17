From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] drivers/idle: make intel_idle.c driver more explicitly non-modular
Date: Fri, 17 Jun 2016 01:28:33 -0400
Message-ID: <cf53e700fa10ffcc6fb2333057e88bac01821040.1466141080.git.len.brown@intel.com>
References: <20160617052834.26064-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34848 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbcFQF3L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 01:29:11 -0400
In-Reply-To: <20160617052834.26064-1-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Len Brown <len.brown@intel.com>

From: Paul Gortmaker <paul.gortmaker@windriver.com>

The Kconfig for this driver is currently declared with:

config INTEL_IDLE
        bool "Cpuidle Driver for Intel Processors"

...meaning that it currently is not being built as a module by anyone.

This was done in commit 6ce9cd8669fa1195fdc21643370e34523c7ac988
("intel_idle: disable module support") since "...the module capability
is cauing more trouble than it is worth."

This was done over 5y ago, and Daniel adds that:

    ...the modular support has been removed from almost all the cpuidle
    drivers and the cpuidle framework is no longer assuming driver could
    be unloaded.

    Removing the modular dead code in the driver makes sense as this
    what have been done in the others drivers.

So lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.  At a
later date we might want to consider whether subsys_init or another
init category seems more appropriate than device_init.

We replace module.h with moduleparam.h since the file does declare
some module parameters, and leaving them as such is currently the
easiest way to remain compatible with existing boot arg use cases.

Note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

Also note that we can't remove intel_idle_cpuidle_devices_uninit() as
that is still used for unwind purposes if the init fails.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 41 ++++++++---------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c966492..f93788f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -46,8 +46,6 @@
  * to avoid complications with the lapic timer workaround.
  * Have not seen issues with suspend, but may need same workaround here.
  *
- * There is currently no kernel-based automatic probing/loading mechanism
- * if the driver is built as a module.
  */
 
 /* un-comment DEBUG to enable pr_debug() statements */
@@ -60,7 +58,7 @@
 #include <linux/sched.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
@@ -1054,7 +1052,6 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x5c, idle_cpu_bxt),
 	{}
 };
-MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
 
 /*
  * intel_idle_probe()
@@ -1415,34 +1412,12 @@ static int __init intel_idle_init(void)
 
 	return 0;
 }
+device_initcall(intel_idle_init);
 
-static void __exit intel_idle_exit(void)
-{
-	struct cpuidle_device *dev;
-	int i;
-
-	cpu_notifier_register_begin();
-
-	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
-		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
-	__unregister_cpu_notifier(&cpu_hotplug_notifier);
-
-	for_each_possible_cpu(i) {
-		dev = per_cpu_ptr(intel_idle_cpuidle_devices, i);
-		cpuidle_unregister_device(dev);
-	}
-
-	cpu_notifier_register_done();
-
-	cpuidle_unregister_driver(&intel_idle_driver);
-	free_percpu(intel_idle_cpuidle_devices);
-}
-
-module_init(intel_idle_init);
-module_exit(intel_idle_exit);
-
+/*
+ * We are not really modular, but we used to support that.  Meaning we also
+ * support "intel_idle.max_cstate=..." at boot and also a read-only export of
+ * it at /sys/module/intel_idle/parameters/max_cstate -- so using module_param
+ * is the easiest way (currently) to continue doing that.
+ */
 module_param(max_cstate, int, 0444);
-
-MODULE_AUTHOR("Len Brown <len.brown@intel.com>");
-MODULE_DESCRIPTION("Cpuidle driver for Intel Hardware v" INTEL_IDLE_VERSION);
-MODULE_LICENSE("GPL");
-- 
2.9.0

