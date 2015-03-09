From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC PATCH v15 01/11] ARM: cpuidle: Register per cpuidle device
Date: Mon,  9 Mar 2015 09:16:36 -0600
Message-ID: <1425914206-22295-2-git-send-email-lina.iyer@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

Some architectures have some cpus which does not support idle states.

Let the underlying low level code to return -ENOSYS when it is not
possible to set an idle state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Minor clean ups and fixes of the per-cpu variable]
---
 drivers/cpuidle/cpuidle-arm.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 1c94b88..f7cdb73 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -17,11 +17,14 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <asm/cpuidle.h>
 
 #include "dt_idle_states.h"
 
+static DEFINE_PER_CPU(struct cpuidle_device, *cpuidle_arm_dev);
+
 /*
  * arm_enter_idle_state - Programs CPU to enter the specified state
  *
@@ -93,6 +96,7 @@ static const struct of_device_id arm_idle_state_match[] __initconst = {
 static int __init arm_idle_init(void)
 {
 	int cpu, ret;
+	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &arm_idle_driver;
 
 	/*
@@ -105,18 +109,46 @@ static int __init arm_idle_init(void)
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
+
 		ret = arm_cpuidle_init(cpu);
+		/*
+		 * This cpu does not support any idle states
+		 */
+		if (ret == -ENOSYS)
+			continue;
+
 		if (ret) {
 			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
 			return ret;
 		}
+
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev)
+			return -ENOMEM;
+
+		dev->cpu = cpu;
+		ret = cpuidle_register_device(dev);
+		if (ret) {
+			pr_err("Failed to register cpuidle device for CPU %d\n",
+			       cpu);
+			return ret;
+		}
+
+		per_cpu(cpuidle_arm_dev, cpu) = dev;
 	}
 
-	return cpuidle_register(drv, NULL);
+	return 0;
 }
 device_initcall(arm_idle_init);
-- 
2.1.0
