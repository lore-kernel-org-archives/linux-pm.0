From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V4 patch 06/15] ARM: OMAP3: cpuidle: use init/exit common routine
Date: Tue, 23 Apr 2013 10:54:36 +0200
Message-ID: <1366707285-12179-7-git-send-email-daniel.lezcano@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:33799 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab3DWIzF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 04:55:05 -0400
Received: by mail-we0-f180.google.com with SMTP id x43so341216wey.11
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 01:55:04 -0700 (PDT)
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 20785b2..cca045c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -26,6 +26,7 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/cpu_pm.h>
+#include <asm/cpuidle.h>
 
 #include "powerdomain.h"
 #include "clockdomain.h"
@@ -259,8 +260,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	return ret;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
-
 static struct cpuidle_driver omap3_idle_driver = {
 	.name             = "omap3_idle",
 	.owner            = THIS_MODULE,
@@ -336,8 +335,6 @@ static struct cpuidle_driver omap3_idle_driver = {
  */
 int __init omap3_idle_init(void)
 {
-	struct cpuidle_device *dev;
-
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
 	per_pd = pwrdm_lookup("per_pwrdm");
@@ -346,20 +343,5 @@ int __init omap3_idle_init(void)
 	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
 		return -ENODEV;
 
-	if (cpuidle_register_driver(&omap3_idle_driver)) {
-		pr_err("%s: CPUidle driver register failed\n", __func__);
-		return -EIO;
-	}
-
-	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
-	dev->cpu = 0;
-
-	if (cpuidle_register_device(dev)) {
-		printk(KERN_ERR "%s: CPUidle register device failed\n",
-		       __func__);
-		cpuidle_unregister_driver(&omap3_idle_driver);
-		return -EIO;
-	}
-
-	return 0;
+	return cpuidle_register(&omap3_idle_driver, NULL);
 }
-- 
1.7.9.5

