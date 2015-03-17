From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v16 01/11] ARM: cpuidle: Register per cpuidle device
Date: Tue, 17 Mar 2015 16:33:41 -0600
Message-ID: <1426631631-56937-2-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

Some architectures have some cpus which does not support idle states or
may be ready to do idle states only when the platform dependencies are
probed.

Let the underlying low level code return -ENOSYS when it is not possible
to set an idle state at this time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Minor clean ups]
---
 drivers/cpuidle/cpuidle-arm.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 1c94b88..e176469 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -17,6 +17,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/cpu.h>
 
 #include <asm/cpuidle.h>
 
@@ -93,6 +96,7 @@ static const struct of_device_id arm_idle_state_match[] __initconst = {
 static int __init arm_idle_init(void)
 {
 	int cpu, ret;
+	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &arm_idle_driver;
 
 	/*
@@ -105,18 +109,49 @@ static int __init arm_idle_init(void)
 	if (ret <= 0)
 		return ret ? : -ENODEV;
 
+
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
+		 * -ENOSYS: Either the platform driver shall register
+		 * a cpuidle device for this cpu, or there are no
+		 * supported idle states.
+		 */
+		if (ret == -ENOSYS)
+			continue;
+
 		if (ret) {
-			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
+			pr_err("CPU %d failed to init idle CPU ops, err=%d\n",
+					cpu, ret);
 			return ret;
 		}
+
+		dev = devm_kzalloc(get_cpu_device(cpu), sizeof(*dev),
+				GFP_KERNEL);
+		if (!dev)
+			return -ENOMEM;
+
+		dev->cpu = cpu;
+		ret = cpuidle_register_device(dev);
+		if (ret) {
+			pr_err("Failed to register cpuidle device for CPU %d, err=%d\n",
+			       cpu, ret);
+			kfree(dev);
+			continue;
+		}
 	}
 
-	return cpuidle_register(drv, NULL);
+	return ret;
 }
 device_initcall(arm_idle_init);
-- 
2.1.0
