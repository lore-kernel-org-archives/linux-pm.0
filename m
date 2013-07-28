From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH 4/7] cpuidle: calxeda: add support to use PSCI calls
Date: Sun, 28 Jul 2013 16:56:35 -0500
Message-ID: <1375048598-15637-5-git-send-email-robherring2@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39005 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab3G1V5F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jul 2013 17:57:05 -0400
Received: by mail-oa0-f47.google.com with SMTP id m6so4703378oag.34
        for <linux-pm@vger.kernel.org>; Sun, 28 Jul 2013 14:57:04 -0700 (PDT)
In-Reply-To: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

From: Rob Herring <rob.herring@calxeda.com>

This updates the Calxeda cpuidle driver to use PSCI calls to powergate
cores. This is needed to enable cpuidle for the ECX-2000.

This could possibly become a generic PSCI driver, but there are no other
PSCI users in the kernel other than mach-virt.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpuidle/cpuidle-calxeda.c | 40 ++++++---------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index 0e6e408..01cfecf3 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -22,51 +22,23 @@
 
 #include <linux/cpuidle.h>
 #include <linux/init.h>
-#include <linux/io.h>
 #include <linux/of.h>
-#include <linux/time.h>
-#include <linux/delay.h>
-#include <linux/suspend.h>
 #include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-#include <asm/smp_scu.h>
 #include <asm/suspend.h>
-#include <asm/cacheflush.h>
-#include <asm/cp15.h>
-
-extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
-extern void *scu_base_addr;
-
-static noinline void calxeda_idle_restore(void)
-{
-	set_cr(get_cr() | CR_C);
-	set_auxcr(get_auxcr() | 0x40);
-	scu_power_mode(scu_base_addr, SCU_PM_NORMAL);
-}
+#include <asm/psci.h>
 
 static int calxeda_idle_finish(unsigned long val)
 {
-	/* Already flushed cache, but do it again as the outer cache functions
-	 * dirty the cache with spinlocks */
-	flush_cache_all();
-
-	set_auxcr(get_auxcr() & ~0x40);
-	set_cr(get_cr() & ~CR_C);
-
-	scu_power_mode(scu_base_addr, SCU_PM_DORMANT);
-
-	cpu_do_idle();
-
-	/* Restore things if we didn't enter power-gating */
-	calxeda_idle_restore();
-	return 1;
+	const struct psci_power_state ps = {
+		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+	};
+	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
 }
 
 static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	highbank_set_cpu_jump(smp_processor_id(), cpu_resume);
 	cpu_suspend(0, calxeda_idle_finish);
 	return index;
 }
@@ -90,7 +62,7 @@ static struct cpuidle_driver calxeda_idle_driver = {
 
 static int __init calxeda_cpuidle_init(void)
 {
-	if (!of_machine_is_compatible("calxeda,highbank"))
+	if (!of_machine_is_compatible("calxeda,highbank") || !psci_ops.cpu_suspend)
 		return -ENODEV;
 
 	return cpuidle_register(&calxeda_idle_driver, NULL);
-- 
1.8.1.2

