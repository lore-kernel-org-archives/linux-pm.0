From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 7/8] ARM: cpuidle: Register per cpuidle device
Date: Fri, 20 Mar 2015 12:44:00 +0100
Message-ID: <1426851841-2072-8-git-send-email-daniel.lezcano@linaro.org>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38366 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbbCTLoW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 07:44:22 -0400
Received: by wibgn9 with SMTP id gn9so11652658wib.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 04:44:20 -0700 (PDT)
In-Reply-To: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin.Marinas@arm.com, robherring2@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lina.iyer@linaro.org, sboyd@codeaurora.org

Some architectures have some cpus which does not support idle states.

Let the underlying low level code to return -ENXIO when it is not
possible to set an idle state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 1c94b88..e4a6eba 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <asm/cpuidle.h>
 
@@ -94,6 +95,7 @@ static int __init arm_idle_init(void)
 {
 	int cpu, ret;
 	struct cpuidle_driver *drv = &arm_idle_driver;
+	struct cpuidle_device *dev;
 
 	/*
 	 * Initialize idle states data, starting at index 1.
@@ -105,18 +107,54 @@ static int __init arm_idle_init(void)
 	if (ret <= 0)
 		return ret ? : -ENODEV;
 
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		pr_err("Failed to register cpuidle driver\n");
+		return ret;
+	}
+
 	/*
 	 * Call arch CPU operations in order to initialize
 	 * idle states suspend back-end specific data
 	 */
 	for_each_possible_cpu(cpu) {
 		ret = arm_cpuidle_init(cpu);
+
+		/* This cpu does not support any idle states */
+		if (ret == -ENXIO)
+			continue;
+
 		if (ret) {
 			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
-			return ret;
+			goto out_fail;
+		}
+
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev) {
+			pr_err("Failed to allocate cpuidle device\n");
+			goto out_fail;
+		}
+		dev->cpu = cpu;
+
+		ret = cpuidle_register_device(dev);
+		if (ret) {
+			pr_err("Failed to register cpuidle device for CPU %d\n",
+			       cpu);
+			kfree(dev);
+			goto out_fail;
 		}
 	}
 
-	return cpuidle_register(drv, NULL);
+	return 0;
+out_fail:
+	while (--cpu >= 0) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		cpuidle_unregister_device(dev);
+		kfree(dev);
+	}
+
+	cpuidle_unregister_driver(drv);
+
+	return ret;
 }
 device_initcall(arm_idle_init);
-- 
1.9.1

