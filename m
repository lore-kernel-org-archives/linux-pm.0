From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 13/19] ARM: OMAP4: cpuidle: use init/exit common routine
Date: Fri, 12 Apr 2013 14:35:59 +0200
Message-ID: <1365770165-27096-14-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:45981 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3DLMgw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:36:52 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so1495739wgg.16
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:36:51 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index cd188de..861dd90 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -15,6 +15,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
 
+#include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
 #include "common.h"
@@ -157,8 +158,6 @@ fail:
 	return index;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
-
 static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
@@ -207,9 +206,6 @@ static struct cpuidle_driver omap4_idle_driver = {
  */
 int __init omap4_idle_init(void)
 {
-	struct cpuidle_device *dev;
-	unsigned int cpu_id = 0;
-
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
 	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
@@ -221,19 +217,5 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
-	for_each_cpu(cpu_id, cpu_online_mask) {
-		dev = &per_cpu(omap4_idle_dev, cpu_id);
-		dev->cpu = cpu_id;
-#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-		dev->coupled_cpus = *cpu_online_mask;
-#endif
-		cpuidle_register_driver(&omap4_idle_driver);
-
-		if (cpuidle_register_device(dev)) {
-			pr_err("%s: CPUidle register failed\n", __func__);
-			return -EIO;
-		}
-	}
-
-	return 0;
+	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
 }
-- 
1.7.9.5

