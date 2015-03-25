From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 7/8] ARM: cpuidle: Register per cpuidle device
Date: Wed, 25 Mar 2015 10:07:15 +0100
Message-ID: <1427274436-21916-7-git-send-email-daniel.lezcano@linaro.org>
References: <55127A53.8050206@linaro.org>
 <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, lina.iyer@linaro.org, Lorenzo.Pieralisi@arm.com
List-Id: linux-pm@vger.kernel.org

If the cpuidle init cpu operation returns -ENXIO, therefore reporting HW
failure or misconfiguration, the CPUidle driver skips the respective
cpuidle device initialization because the associated platform back-end HW
is not operational.

That prevents the system to crash and allows to handle the error gracefully.

For example, on Qcom's platform, each core has a SPM. The device associated
with this SPM is initialized before the cpuidle framework. If there is an error
in the initialization (eg. error in the DT), the system continues to boot but
in degraded mode as some SPM may not be correctly initialized.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/cpuidle-arm.c | 45 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 1c94b88..545069d 100644
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
@@ -105,18 +107,57 @@ static int __init arm_idle_init(void)
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
+		/*
+		 * Skip the cpuidle device initialization if the reported
+		 * failure is a HW misconfiguration/breakage (-ENXIO).
+		 */
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
