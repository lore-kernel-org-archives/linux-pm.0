From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V3 patch 16/19] ARM: calxeda: cpuidle: use init/exit common routine
Date: Fri, 12 Apr 2013 14:36:02 +0200
Message-ID: <1365770165-27096-17-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:51381 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3DLMhC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 08:37:02 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so2692116wgh.24
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2013 05:37:00 -0700 (PDT)
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

Remove the duplicated code and use the cpuidle common code for initialization.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/cpuidle/cpuidle-calxeda.c |   52 +------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index a3b56f5..e344b56 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -35,8 +35,6 @@
 extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
 extern void *scu_base_addr;
 
-static struct cpuidle_device __percpu *calxeda_idle_cpuidle_devices;
-
 static inline unsigned int get_auxcr(void)
 {
 	unsigned int val;
@@ -85,19 +83,6 @@ static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-static void calxeda_idle_cpuidle_devices_uninit(void)
-{
-	int i;
-	struct cpuidle_device *dev;
-
-	for_each_possible_cpu(i) {
-		dev = per_cpu_ptr(calxeda_idle_cpuidle_devices, i);
-		cpuidle_unregister_device(dev);
-	}
-
-	free_percpu(calxeda_idle_cpuidle_devices);
-}
-
 static struct cpuidle_driver calxeda_idle_driver = {
 	.name = "calxeda_idle",
 	.states = {
@@ -117,44 +102,9 @@ static struct cpuidle_driver calxeda_idle_driver = {
 
 static int __init calxeda_cpuidle_init(void)
 {
-	int cpu_id;
-	int ret;
-	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &calxeda_idle_driver;
-
 	if (!of_machine_is_compatible("calxeda,highbank"))
 		return -ENODEV;
 
-	ret = cpuidle_register_driver(drv);
-	if (ret)
-		return ret;
-
-	calxeda_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
-	if (calxeda_idle_cpuidle_devices == NULL) {
-		ret = -ENOMEM;
-		goto unregister_drv;
-	}
-
-	/* initialize state data for each cpuidle_device */
-	for_each_possible_cpu(cpu_id) {
-		dev = per_cpu_ptr(calxeda_idle_cpuidle_devices, cpu_id);
-		dev->cpu = cpu_id;
-		dev->state_count = drv->state_count;
-
-		ret = cpuidle_register_device(dev);
-		if (ret) {
-			pr_err("Failed to register cpu %u, error: %d\n",
-			       cpu_id, ret);
-			goto uninit;
-		}
-	}
-
-	return 0;
-
-uninit:
-	calxeda_idle_cpuidle_devices_uninit();
-unregister_drv:
-	cpuidle_unregister_driver(drv);
-	return ret;
+	return cpuidle_register(&calxeda_idle_driver, NULL);
 }
 module_init(calxeda_cpuidle_init);
-- 
1.7.9.5

