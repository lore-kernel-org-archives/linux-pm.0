From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 3/7] cpu_cooling: Add generic driver ready callback
Date: Thu, 10 Jan 2019 05:30:52 +0530
Message-ID: <9cccfabf22ccae92dfd31175b57baab3206eac0d.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

All cpufreq drivers do similar things to register as a cooling device.
Provide a generic call back so we can get rid of duplicated code in the
drivers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Suggested-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/cpu_cooling.c | 18 ++++++++++++++++++
 include/linux/cpu_cooling.h   |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778..5154ffc12332 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -694,6 +694,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
 	cpufreq_cdev->cdev = cdev;
+	policy->cooldev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -785,6 +786,23 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 
+/**
+ * generic_cpufreq_ready - generic driver callback to register a thermal_cooling_device
+ * @policy: cpufreq policy
+ */
+void generic_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct thermal_cooling_device **cdev = &policy->cooldev;
+
+	*cdev = of_cpufreq_cooling_register(policy);
+	if (IS_ERR(*cdev)) {
+		pr_err("Failed to register cpufreq cooling device for CPU%d: %ld\n",
+		       policy->cpu, PTR_ERR(cdev));
+		cdev = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(generic_cpufreq_ready);
+
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index de0dafb9399d..d7815bb2967a 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -65,12 +65,21 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
  */
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy);
+
+/**
+ * generic_cpufreq_ready - generic driver callback to register a thermal_cooling_device
+ * @policy: cpufreq policy
+ */
+void generic_cpufreq_ready(struct cpufreq_policy *policy);
 #else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
+
+void generic_cpufreq_ready(struct cpufreq_policy *policy) {}
+
 #endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1
