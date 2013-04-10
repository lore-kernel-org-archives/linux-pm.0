From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 06/18] ARM: ux500: cpuidle: use init/exit common routine
Date: Wed, 10 Apr 2013 16:22:11 +0200
Message-ID: <1365603743-5618-7-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:56055 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936727Ab3DJOWs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 10:22:48 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so522746wib.16
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 07:22:47 -0700 (PDT)
In-Reply-To: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicate code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |   32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index 5657d4a..488e074 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -21,7 +21,6 @@
 
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
-static DEFINE_PER_CPU(struct cpuidle_device, ux500_cpuidle_device);
 
 static inline int ux500_enter_idle(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int index)
@@ -112,40 +111,11 @@ static struct cpuidle_driver ux500_idle_driver = {
 
 int __init ux500_idle_init(void)
 {
-	int ret, cpu;
-	struct cpuidle_device *device;
-
         /* Configure wake up reasons */
 	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
 			     PRCMU_WAKEUP(ABB));
 
-	ret = cpuidle_register_driver(&ux500_idle_driver);
-	if (ret) {
-		printk(KERN_ERR "failed to register ux500 idle driver\n");
-		return ret;
-	}
-
-	for_each_possible(cpu) {
-		device = &per_cpu(ux500_cpuidle_device, cpu);
-		device->cpu = cpu;
-		ret = cpuidle_register_device(device);
-		if (ret) {
-			printk(KERN_ERR "Failed to register cpuidle "
-			       "device for cpu%d\n", cpu);
-			goto out_unregister;
-		}
-	}
-out:
-	return ret;
-
-out_unregister:
-	for_each_possible_cpu(cpu) {
-		device = &per_cpu(ux500_cpuidle_device, cpu);
-		cpuidle_unregister_device(device);
-	}
-
-	cpuidle_unregister_driver(&ux500_idle_driver);
-	goto out;
+	return cpuidle_register(&ux500_idle_driver, NULL);
 }
 
 device_initcall(ux500_idle_init);
-- 
1.7.9.5

