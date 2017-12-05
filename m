From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/4] cpu_cooling: Keep only one of_cpufreq*cooling_register() helper
Date: Tue,  5 Dec 2017 11:02:45 +0530
Message-ID: <8a3b025d3214f6e792196c24df3eb12fa45e89a3.1512451487.git.viresh.kumar@linaro.org>
References: <cover.1512451487.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40830 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdLEFhE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 00:37:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id v26so10421643pfl.7
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 21:37:04 -0800 (PST)
In-Reply-To: <cover.1512451487.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1512451487.git.viresh.kumar@linaro.org>
References: <cover.1512451487.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, javi.merino@kernel.org, amit.kachhap@gmail.com, rui.zhang@intel.com, ionela.voinescu@arm.com

of_cpufreq_cooling_register() isn't used by anyone and so can be
removed, but then we would be left with two routines:
cpufreq_cooling_register() and of_cpufreq_power_cooling_register() that
would look odd.

Remove current implementation of of_cpufreq_cooling_register() and
rename of_cpufreq_power_cooling_register() as
of_cpufreq_cooling_register(). This simplifies lots of stuff.

Acked-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/thermal/cpu-cooling-api.txt | 14 ++------
 drivers/cpufreq/arm_big_little.c          |  2 +-
 drivers/cpufreq/cpufreq-dt.c              |  2 +-
 drivers/cpufreq/mediatek-cpufreq.c        |  2 +-
 drivers/cpufreq/qoriq-cpufreq.c           |  2 +-
 drivers/thermal/cpu_cooling.c             | 28 ++--------------
 include/linux/cpu_cooling.h               | 53 ++++++++-----------------------
 7 files changed, 23 insertions(+), 80 deletions(-)

diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/thermal/cpu-cooling-api.txt
index ea61e8bf7e2b..7a1c89db0419 100644
--- a/Documentation/thermal/cpu-cooling-api.txt
+++ b/Documentation/thermal/cpu-cooling-api.txt
@@ -26,24 +26,16 @@ the user. The registration APIs returns the cooling device pointer.
    clip_cpus: cpumask of cpus where the frequency constraints will happen.
 
 1.1.2 struct thermal_cooling_device *of_cpufreq_cooling_register(
-	struct device_node *np, const struct cpumask *clip_cpus)
+					struct cpufreq_policy *policy)
 
     This interface function registers the cpufreq cooling device with
     the name "thermal-cpufreq-%x" linking it with a device tree node, in
     order to bind it via the thermal DT code. This api can support multiple
     instances of cpufreq cooling devices.
 
-    np: pointer to the cooling device device tree node
-    clip_cpus: cpumask of cpus where the frequency constraints will happen.
-
-1.1.3 struct thermal_cooling_device *of_cpufreq_power_cooling_register(
-					struct cpufreq_policy *policy)
-
-Similar to cpufreq_cooling_register, this function register a
-cpufreq cooling device with power extensions using the device tree
-information supplied by the np parameter.
+    policy: CPUFreq policy.
 
-1.1.4 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+1.1.3 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
     This interface function unregisters the "thermal-cpufreq-%x" cooling device.
 
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 3d5ed4ef3927..c56b57dcfda5 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -532,7 +532,7 @@ static void bL_cpufreq_ready(struct cpufreq_policy *policy)
 	if (cur_cluster >= MAX_CLUSTERS)
 		return;
 
-	cdev[cur_cluster] = of_cpufreq_power_cooling_register(policy);
+	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
 }
 
 static struct cpufreq_driver bL_cpufreq_driver = {
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 1e7bec7694ab..de3d104c25d7 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -320,7 +320,7 @@ static void cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
 
-	priv->cdev = of_cpufreq_power_cooling_register(policy);
+	priv->cdev = of_cpufreq_cooling_register(policy);
 }
 
 static struct cpufreq_driver dt_cpufreq_driver = {
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 6ff783e1b18a..f95975b76d98 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -311,7 +311,7 @@ static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 
-	info->cdev = of_cpufreq_power_cooling_register(policy);
+	info->cdev = of_cpufreq_cooling_register(policy);
 }
 
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3a665c18e14e..0562761a3dec 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -276,7 +276,7 @@ static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct cpu_data *cpud = policy->driver_data;
 
-	cpud->cdev = of_cpufreq_power_cooling_register(policy);
+	cpud->cdev = of_cpufreq_cooling_register(policy);
 }
 
 static struct cpufreq_driver qoriq_cpufreq_driver = {
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 10199f7e1196..3371caf3095c 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -819,7 +819,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 
 /**
  * of_cpufreq_cooling_register - function to create cpufreq cooling device.
- * @np: a valid struct device_node to the cooling device device tree node
  * @policy: cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
@@ -827,29 +826,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
  * cooling devices. Using this API, the cpufreq cooling device will be
  * linked to the device tree node provided.
  *
- * Return: a valid struct thermal_cooling_device pointer on success,
- * on failure, it returns a corresponding ERR_PTR().
- */
-struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct device_node *np,
-			    struct cpufreq_policy *policy)
-{
-	if (!np)
-		return ERR_PTR(-EINVAL);
-
-	return __cpufreq_cooling_register(np, policy, 0, NULL);
-}
-EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
-
-/**
- * of_cpufreq_power_cooling_register() - create cpufreq cooling device with power extensions
- * @policy: CPUFreq policy.
- *
- * This interface function registers the cpufreq cooling device with
- * the name "thermal-cpufreq-%x".  This api can support multiple
- * instances of cpufreq cooling devices.  Using this API, the cpufreq
- * cooling device will be linked to the device tree node of the provided
- * policy's CPU.
  * Using this function, the cooling device will implement the power
  * extensions by using a simple cpu power model.  The cpus must have
  * registered their OPPs using the OPP library.
@@ -861,7 +837,7 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
  * and NULL on failure.
  */
 struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct cpufreq_policy *policy)
+of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
 	struct thermal_cooling_device *cdev = NULL;
@@ -889,7 +865,7 @@ of_cpufreq_power_cooling_register(struct cpufreq_policy *policy)
 	of_node_put(np);
 	return cdev;
 }
-EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
+EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index c35778960a9c..fd0ea8ddca93 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -42,33 +42,6 @@ struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy);
 
 /**
- * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
- * @np: a valid struct device_node to the cooling device device tree node.
- * @policy: cpufreq policy.
- */
-#ifdef CONFIG_THERMAL_OF
-struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct device_node *np,
-			    struct cpufreq_policy *policy);
-
-struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct cpufreq_policy *policy);
-#else
-static inline struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct device_node *np,
-			    struct cpufreq_policy *policy)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct cpufreq_policy *policy)
-{
-	return NULL;
-}
-#endif
-
-/**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
  */
@@ -81,24 +54,26 @@ cpufreq_cooling_register(struct cpufreq_policy *policy)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct device_node *np,
-			    struct cpufreq_policy *policy)
+static inline
+void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-	return ERR_PTR(-ENOSYS);
+	return;
 }
+#endif	/* CONFIG_CPU_THERMAL */
 
+#if defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL)
+/**
+ * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
+ * @policy: cpufreq policy.
+ */
+struct thermal_cooling_device *
+of_cpufreq_cooling_register(struct cpufreq_policy *policy);
+#else
 static inline struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct cpufreq_policy *policy)
+of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
-
-static inline
-void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
-{
-	return;
-}
-#endif	/* CONFIG_CPU_THERMAL */
+#endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.11.0
