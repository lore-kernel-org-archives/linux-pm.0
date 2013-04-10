From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 18/18] ARM: imx: cpuidle: use init/exit common routine
Date: Wed, 10 Apr 2013 16:22:23 +0200
Message-ID: <1365603743-5618-19-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:61054 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936888Ab3DJOX2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 10:23:28 -0400
Received: by mail-we0-f180.google.com with SMTP id r5so404619wey.11
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 07:23:27 -0700 (PDT)
In-Reply-To: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/cpuidle-imx5.c  |   36 +-----------------------------------
 arch/arm/mach-imx/cpuidle-imx6q.c |   36 +-----------------------------------
 2 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cpuidle-imx5.c
index 3d9f0c9..ba4565f 100644
--- a/arch/arm/mach-imx/cpuidle-imx5.c
+++ b/arch/arm/mach-imx/cpuidle-imx5.c
@@ -13,8 +13,6 @@
 
 #include "hardware.h"
 
-static DEFINE_PER_CPU(struct cpuidle_device, devices);
-
 static int imx5_cpuidle_enter(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index)
 {
@@ -38,37 +36,5 @@ static struct cpuidle_driver imx5_cpuidle_driver = {
 
 int __init imx5_cpuidle_init(void)
 {
-	struct cpuidle_device *dev;
-	int cpu, ret;
-
-	ret = cpuidle_register_driver(&imx5_cpuidle_driver);
-	if (ret) {
-		pr_err("%s: Failed to register cpuidle driver with error: %d\n",
-			 __func__, ret);
-		return ret;
-	}
-
-	/* initialize state data for each cpuidle_device */
-	for_each_possible_cpu(cpu) {
-		dev = &per_cpu(devices, cpu);
-		dev->cpu = cpu;
-
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("%s: Failed to register cpu %u, error: %d\n",
-				__func__, cpu, ret);
-			goto out_unregister;
-		}
-	}
-
-	return 0;
-
-out_unregister:
-	for_each_possible_cpu(cpu) {
-		dev = &per_cpu(devices, cpu);
-		cpuidle_unregister_device(dev);
-	}
-
-	cpuidle_unregister_driver(&imx5_cpuidle_driver);
-	return ret;
+	return cpuidle_register(&imx5_cpuidle_driver, NULL);
 }
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index c066b74faa..23ddfb6 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -14,8 +14,6 @@
 #include "common.h"
 #include "cpuidle.h"
 
-static DEFINE_PER_CPU(struct cpuidle_device, devices);
-
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
 
@@ -67,43 +65,11 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
 
 int __init imx6q_cpuidle_init(void)
 {
-	struct cpuidle_device *dev;
-	int cpu, ret;
-
 	/* Need to enable SCU standby for entering WAIT modes */
 	imx_scu_standby_enable();
 
 	/* Set chicken bit to get a reliable WAIT mode support */
 	imx6q_set_chicken_bit();
 
-	ret = cpuidle_register_driver(&imx6q_cpuidle_driver);
-	if (ret) {
-		pr_err("%s: Failed to register cpuidle driver with error: %d\n",
-			 __func__, ret);
-		return ret;
-	}
-
-	/* initialize state data for each cpuidle_device */
-	for_each_possible_cpu(cpu) {
-		dev = &per_cpu(devices, cpu);
-		dev->cpu = cpu;
-
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("%s: Failed to register cpu %u, error: %d\n",
-				__func__, cpu, ret);
-			goto out_unregister;
-		}
-	}
-
-	return 0;
-
-out_unregister:
-	for_each_possible_cpu(cpu) {
-		dev = &per_cpu(devices, cpu);
-		cpuidle_unregister_device(dev);
-	}
-
-	cpuidle_unregister_driver(&imx6q_cpuidle_driver);
-	return ret;
+	return cpuidle_register(&imx6q_cpuidle_driver, NULL);
 }
-- 
1.7.9.5

