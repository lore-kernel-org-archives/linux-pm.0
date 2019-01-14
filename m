From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 4/9] cpufreq: Add a flag to auto-register a cooling device
Date: Mon, 14 Jan 2019 15:51:06 +0530
Message-ID: <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

All cpufreq drivers do similar things to register as a cooling device.
Provide a cpufreq driver flag so drivers can just ask the cpufreq core
to register the cooling device on their behalf. This allows us to get
rid of duplicated code in the drivers.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 13 +++++++++++++
 include/linux/cpufreq.h   |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6f23ebb395f1..7faebfc61e60 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -30,6 +30,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tick.h>
 #include <trace/events/power.h>
+#include <linux/cpu_cooling.h>
 
 static LIST_HEAD(cpufreq_policy_list);
 
@@ -1318,6 +1319,12 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
+		struct thermal_cooling_device **cdev = &policy->cooldev;
+
+		*cdev = of_cpufreq_cooling_register(policy);
+	}
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1411,6 +1418,12 @@ static int cpufreq_offline(unsigned int cpu)
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
+		struct thermal_cooling_device **cdev = &policy->cooldev;
+
+		cpufreq_cooling_unregister(*cdev);
+	}
+
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9fbc1d996967..0c51d5ce7350 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -388,6 +388,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
 
+/*
+ * Set by drivers that want the core to automatically register the cpufreq
+ * driver as a thermal cooling device
+ */
+#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.17.1
