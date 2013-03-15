From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 10/11] cpuidle / calxeda : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:09 +0100
Message-ID: <1363357630-22214-11-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:59290 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab3COO1j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:39 -0400
Received: by mail-wg0-f54.google.com with SMTP id fm10so3041403wgb.21
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:38 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-calxeda.c |   52 +------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index e1aab38..5db7935 100644
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
 	.en_core_tk_irqen = 1,
@@ -118,44 +103,9 @@ static struct cpuidle_driver calxeda_idle_driver = {
 
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
+	return arm_idle_init(&calxeda_idle_driver);
 }
 module_init(calxeda_cpuidle_init);
-- 
1.7.9.5

