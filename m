From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/4] cpu_cooling: Make of_cpufreq_power_cooling_register() parse DT
Date: Tue,  5 Dec 2017 11:02:43 +0530
Message-ID: <22be9e04703b04d0b48f57e62ba170bf81660c14.1512451487.git.viresh.kumar@linaro.org>
References: <cover.1512451487.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1512451487.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1512451487.git.viresh.kumar@linaro.org>
References: <cover.1512451487.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, javi.merino@kernel.org, amit.kachhap@gmail.com, rui.zhang@intel.com, ionela.voinescu@arm.com
List-Id: linux-pm@vger.kernel.org

All the callers of of_cpufreq_power_cooling_register() have almost
identical code and it makes more sense to move that code into the helper
as its all about reading DT properties.

This got rid of lot of redundant code.

Acked-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/thermal/cpu-cooling-api.txt |  7 ++---
 drivers/cpufreq/arm_big_little.c          | 23 +--------------
 drivers/cpufreq/cpufreq-dt.c              | 27 +----------------
 drivers/cpufreq/mediatek-cpufreq.c        | 22 +-------------
 drivers/cpufreq/qoriq-cpufreq.c           | 14 +--------
 drivers/thermal/cpu_cooling.c             | 49 +++++++++++++++++++------------
 include/linux/cpu_cooling.h               | 15 ++--------
 7 files changed, 41 insertions(+), 116 deletions(-)

diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/thermal/cpu-cooling-api.txt
index 71653584cd03..4f6f5e9bb4d6 100644
--- a/Documentation/thermal/cpu-cooling-api.txt
+++ b/Documentation/thermal/cpu-cooling-api.txt
@@ -51,8 +51,7 @@ Dynamic power).  "plat_static_func" is a function to calculate the
 static power consumed by these cpus (See 2.2 Static power).
 
 1.1.4 struct thermal_cooling_device *of_cpufreq_power_cooling_register(
-    struct device_node *np, const struct cpumask *clip_cpus, u32 capacitance,
-    get_static_t plat_static_func)
+					struct cpufreq_policy *policy)
 
 Similar to cpufreq_power_cooling_register, this function register a
 cpufreq cooling device with power extensions using the device tree
@@ -76,8 +75,8 @@ cpu.  If you are using CONFIG_CPUFREQ_DT then the
 device.
 
 The `plat_static_func` parameter of `cpufreq_power_cooling_register()`
-and `of_cpufreq_power_cooling_register()` is optional.  If you don't
-provide it, only dynamic power will be considered.
+is optional.  If you don't provide it, only dynamic power will be
+considered.
 
 2.1 Dynamic power
 
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 65ec5f01aa8d..3d5ed4ef3927 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -526,34 +526,13 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 
 static void bL_cpufreq_ready(struct cpufreq_policy *policy)
 {
-	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	int cur_cluster = cpu_to_cluster(policy->cpu);
-	struct device_node *np;
 
 	/* Do not register a cpu_cooling device if we are in IKS mode */
 	if (cur_cluster >= MAX_CLUSTERS)
 		return;
 
-	np = of_node_get(cpu_dev->of_node);
-	if (WARN_ON(!np))
-		return;
-
-	if (of_find_property(np, "#cooling-cells", NULL)) {
-		u32 power_coefficient = 0;
-
-		of_property_read_u32(np, "dynamic-power-coefficient",
-				     &power_coefficient);
-
-		cdev[cur_cluster] = of_cpufreq_power_cooling_register(np,
-				policy, power_coefficient, NULL);
-		if (IS_ERR(cdev[cur_cluster])) {
-			dev_err(cpu_dev,
-				"running cpufreq without cooling device: %ld\n",
-				PTR_ERR(cdev[cur_cluster]));
-			cdev[cur_cluster] = NULL;
-		}
-	}
-	of_node_put(np);
+	cdev[cur_cluster] = of_cpufreq_power_cooling_register(policy);
 }
 
 static struct cpufreq_driver bL_cpufreq_driver = {
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 545946ad0752..1e7bec7694ab 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -319,33 +319,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 static void cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
-	struct device_node *np = of_node_get(priv->cpu_dev->of_node);
 
-	if (WARN_ON(!np))
-		return;
-
-	/*
-	 * For now, just loading the cooling device;
-	 * thermal DT code takes care of matching them.
-	 */
-	if (of_find_property(np, "#cooling-cells", NULL)) {
-		u32 power_coefficient = 0;
-
-		of_property_read_u32(np, "dynamic-power-coefficient",
-				     &power_coefficient);
-
-		priv->cdev = of_cpufreq_power_cooling_register(np,
-				policy, power_coefficient, NULL);
-		if (IS_ERR(priv->cdev)) {
-			dev_err(priv->cpu_dev,
-				"running cpufreq without cooling device: %ld\n",
-				PTR_ERR(priv->cdev));
-
-			priv->cdev = NULL;
-		}
-	}
-
-	of_node_put(np);
+	priv->cdev = of_cpufreq_power_cooling_register(policy);
 }
 
 static struct cpufreq_driver dt_cpufreq_driver = {
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index e0d5090b303d..6ff783e1b18a 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -310,28 +310,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
-	struct device_node *np = of_node_get(info->cpu_dev->of_node);
-	u32 capacitance = 0;
 
-	if (WARN_ON(!np))
-		return;
-
-	if (of_find_property(np, "#cooling-cells", NULL)) {
-		of_property_read_u32(np, DYNAMIC_POWER, &capacitance);
-
-		info->cdev = of_cpufreq_power_cooling_register(np,
-						policy, capacitance, NULL);
-
-		if (IS_ERR(info->cdev)) {
-			dev_err(info->cpu_dev,
-				"running cpufreq without cooling device: %ld\n",
-				PTR_ERR(info->cdev));
-
-			info->cdev = NULL;
-		}
-	}
-
-	of_node_put(np);
+	info->cdev = of_cpufreq_power_cooling_register(policy);
 }
 
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 4ada55b8856e..3a665c18e14e 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -275,20 +275,8 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct cpu_data *cpud = policy->driver_data;
-	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
 
-	if (of_find_property(np, "#cooling-cells", NULL)) {
-		cpud->cdev = of_cpufreq_cooling_register(np, policy);
-
-		if (IS_ERR(cpud->cdev) && PTR_ERR(cpud->cdev) != -ENOSYS) {
-			pr_err("cpu%d is not running as cooling device: %ld\n",
-					policy->cpu, PTR_ERR(cpud->cdev));
-
-			cpud->cdev = NULL;
-		}
-	}
-
-	of_node_put(np);
+	cpud->cdev = of_cpufreq_power_cooling_register(policy);
 }
 
 static struct cpufreq_driver qoriq_cpufreq_driver = {
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dc63aba092e4..a31eb03c788e 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -873,38 +873,51 @@ EXPORT_SYMBOL(cpufreq_power_cooling_register);
 
 /**
  * of_cpufreq_power_cooling_register() - create cpufreq cooling device with power extensions
- * @np:	a valid struct device_node to the cooling device device tree node
- * @policy: cpufreq policy
- * @capacitance:	dynamic power coefficient for these cpus
- * @plat_static_func:	function to calculate the static power consumed by these
- *			cpus (optional)
+ * @policy: CPUFreq policy.
  *
  * This interface function registers the cpufreq cooling device with
  * the name "thermal-cpufreq-%x".  This api can support multiple
  * instances of cpufreq cooling devices.  Using this API, the cpufreq
- * cooling device will be linked to the device tree node provided.
+ * cooling device will be linked to the device tree node of the provided
+ * policy's CPU.
  * Using this function, the cooling device will implement the power
  * extensions by using a simple cpu power model.  The cpus must have
  * registered their OPPs using the OPP library.
  *
- * An optional @plat_static_func may be provided to calculate the
- * static power consumed by these cpus.  If the platform's static
- * power consumption is unknown or negligible, make it NULL.
+ * It also takes into account, if property present in policy CPU node, the
+ * static power consumed by the cpu.
  *
  * Return: a valid struct thermal_cooling_device pointer on success,
- * on failure, it returns a corresponding ERR_PTR().
+ * and NULL on failure.
  */
 struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct device_node *np,
-				  struct cpufreq_policy *policy,
-				  u32 capacitance,
-				  get_static_t plat_static_func)
+of_cpufreq_power_cooling_register(struct cpufreq_policy *policy)
 {
-	if (!np)
-		return ERR_PTR(-EINVAL);
+	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
+	struct thermal_cooling_device *cdev = NULL;
+	u32 capacitance = 0;
+
+	if (!np) {
+		pr_err("cpu_cooling: OF node not available for cpu%d\n",
+		       policy->cpu);
+		return NULL;
+	}
 
-	return __cpufreq_cooling_register(np, policy, capacitance,
-				plat_static_func);
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &capacitance);
+
+		cdev = __cpufreq_cooling_register(np, policy, capacitance,
+						  NULL);
+		if (IS_ERR(cdev)) {
+			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
+			       policy->cpu, PTR_ERR(cdev));
+			cdev = NULL;
+		}
+	}
+
+	of_node_put(np);
+	return cdev;
 }
 EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
 
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index d4292ebc5c8b..f09d4feb34f4 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -56,10 +56,7 @@ of_cpufreq_cooling_register(struct device_node *np,
 			    struct cpufreq_policy *policy);
 
 struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct device_node *np,
-				  struct cpufreq_policy *policy,
-				  u32 capacitance,
-				  get_static_t plat_static_func);
+of_cpufreq_power_cooling_register(struct cpufreq_policy *policy);
 #else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
@@ -69,10 +66,7 @@ of_cpufreq_cooling_register(struct device_node *np,
 }
 
 static inline struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct device_node *np,
-				  struct cpufreq_policy *policy,
-				  u32 capacitance,
-				  get_static_t plat_static_func)
+of_cpufreq_power_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
@@ -105,10 +99,7 @@ of_cpufreq_cooling_register(struct device_node *np,
 }
 
 static inline struct thermal_cooling_device *
-of_cpufreq_power_cooling_register(struct device_node *np,
-				  struct cpufreq_policy *policy,
-				  u32 capacitance,
-				  get_static_t plat_static_func)
+of_cpufreq_power_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
-- 
2.11.0
