From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 04/11] cpuidle / omap3 : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:03 +0100
Message-ID: <1363357630-22214-5-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:57637 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab3COO1Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:25 -0400
Received: by mail-wg0-f53.google.com with SMTP id fn15so3202734wgb.32
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:24 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 80392fc..0112da3c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -26,6 +26,7 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/cpu_pm.h>
+#include <asm/cpuidle.h>
 
 #include "powerdomain.h"
 #include "clockdomain.h"
@@ -271,8 +272,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	return ret;
 }
 
-static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
-
 static struct cpuidle_driver omap3_idle_driver = {
 	.name =		"omap3_idle",
 	.owner =	THIS_MODULE,
@@ -348,8 +347,6 @@ static struct cpuidle_driver omap3_idle_driver = {
  */
 int __init omap3_idle_init(void)
 {
-	struct cpuidle_device *dev;
-
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
 	per_pd = pwrdm_lookup("per_pwrdm");
@@ -358,16 +355,5 @@ int __init omap3_idle_init(void)
 	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
 		return -ENODEV;
 
-	cpuidle_register_driver(&omap3_idle_driver);
-
-	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
-	dev->cpu = 0;
-
-	if (cpuidle_register_device(dev)) {
-		printk(KERN_ERR "%s: CPUidle register device failed\n",
-		       __func__);
-		return -EIO;
-	}
-
-	return 0;
+	return arm_idle_init(&omap3_idle_driver);
 }
-- 
1.7.9.5

