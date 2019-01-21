From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date: Mon, 21 Jan 2019 21:10:27 +0530
Message-ID: <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Tao Wang <kevin.wangtao@hisilicon.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

All cpufreq drivers do similar things to register as a cooling device.
Provide a cpufreq driver flag so drivers can just ask the cpufreq core
to register the cooling device on their behalf. This allows us to get
rid of duplicated code in the drivers.

In order to allow this, we add a struct thermal_cooling_device pointer
to struct cpufreq_policy so that drivers don't need to store it in a
private data structure.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/cpufreq/cpufreq.c |  6 ++++++
 include/linux/cpufreq.h   | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bc..cf1be057caf4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1318,6 +1318,9 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
+		register_cooling_device(policy);
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1405,6 +1408,9 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
+		unregister_cooling_device(policy);
+
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bd7fbd6a4478..02fc9f210aee 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
@@ -151,6 +152,11 @@ struct cpufreq_policy {
 
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
+
+#ifdef CONFIG_CPU_THERMAL
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
+#endif
 };
 
 /* Only for ACPI */
@@ -386,6 +392,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
+/*
+ * Set by drivers that want the core to automatically register the cpufreq
+ * driver as a thermal cooling device.
+ */
+#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
@@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
 			policy->cpuinfo.max_freq);
 }
 
+#ifdef CONFIG_CPU_THERMAL
+static inline void register_cooling_device(struct cpufreq_policy *policy) {
+	policy->cdev = of_cpufreq_cooling_register(policy);
+}
+
+static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
+	cpufreq_cooling_unregister(policy->cdev);
+	policy->cdev = NULL;
+}
+#else
+static inline void register_cooling_device(struct cpufreq_policy *policy) {}
+static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
+#endif
 #ifdef CONFIG_CPU_FREQ
 void cpufreq_suspend(void);
 void cpufreq_resume(void);
-- 
2.17.1
