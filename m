From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] cpu_cooling: Remove unused cpufreq_power_cooling_register()
Date: Wed, 15 Nov 2017 14:49:46 +0530
Message-ID: <813c6ba9a48a6e092d0e78bdbdc2d6fa069e5fed.1510735482.git.viresh.kumar@linaro.org>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510735482.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1510735482.git.viresh.kumar@linaro.org>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

It isn't used by anyone, drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/thermal/cpu-cooling-api.txt | 24 +++---------------------
 drivers/thermal/cpu_cooling.c             | 30 ------------------------------
 include/linux/cpu_cooling.h               | 10 ----------
 3 files changed, 3 insertions(+), 61 deletions(-)

diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/thermal/cpu-cooling-api.txt
index 4f6f5e9bb4d6..ea61e8bf7e2b 100644
--- a/Documentation/thermal/cpu-cooling-api.txt
+++ b/Documentation/thermal/cpu-cooling-api.txt
@@ -36,28 +36,14 @@ the user. The registration APIs returns the cooling device pointer.
     np: pointer to the cooling device device tree node
     clip_cpus: cpumask of cpus where the frequency constraints will happen.
 
-1.1.3 struct thermal_cooling_device *cpufreq_power_cooling_register(
-    const struct cpumask *clip_cpus, u32 capacitance,
-    get_static_t plat_static_func)
-
-Similar to cpufreq_cooling_register, this function registers a cpufreq
-cooling device.  Using this function, the cooling device will
-implement the power extensions by using a simple cpu power model.  The
-cpus must have registered their OPPs using the OPP library.
-
-The additional parameters are needed for the power model (See 2. Power
-models).  "capacitance" is the dynamic power coefficient (See 2.1
-Dynamic power).  "plat_static_func" is a function to calculate the
-static power consumed by these cpus (See 2.2 Static power).
-
-1.1.4 struct thermal_cooling_device *of_cpufreq_power_cooling_register(
+1.1.3 struct thermal_cooling_device *of_cpufreq_power_cooling_register(
 					struct cpufreq_policy *policy)
 
-Similar to cpufreq_power_cooling_register, this function register a
+Similar to cpufreq_cooling_register, this function register a
 cpufreq cooling device with power extensions using the device tree
 information supplied by the np parameter.
 
-1.1.5 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+1.1.4 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
     This interface function unregisters the "thermal-cpufreq-%x" cooling device.
 
@@ -74,10 +60,6 @@ cpu.  If you are using CONFIG_CPUFREQ_DT then the
 `cpufreq_frequency_table` should already be assigned to the cpu
 device.
 
-The `plat_static_func` parameter of `cpufreq_power_cooling_register()`
-is optional.  If you don't provide it, only dynamic power will be
-considered.
-
 2.1 Dynamic power
 
 The dynamic power consumption of a processor depends on many factors.
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 5740b49fee68..94ffb4463e22 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -841,36 +841,6 @@ of_cpufreq_cooling_register(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 
-/**
- * cpufreq_power_cooling_register() - create cpufreq cooling device with power extensions
- * @policy:		cpufreq policy
- * @capacitance:	dynamic power coefficient for these cpus
- * @plat_static_func:	function to calculate the static power consumed by these
- *			cpus (optional)
- *
- * This interface function registers the cpufreq cooling device with
- * the name "thermal-cpufreq-%x".  This api can support multiple
- * instances of cpufreq cooling devices.  Using this function, the
- * cooling device will implement the power extensions by using a
- * simple cpu power model.  The cpus must have registered their OPPs
- * using the OPP library.
- *
- * An optional @plat_static_func may be provided to calculate the
- * static power consumed by these cpus.  If the platform's static
- * power consumption is unknown or negligible, make it NULL.
- *
- * Return: a valid struct thermal_cooling_device pointer on success,
- * on failure, it returns a corresponding ERR_PTR().
- */
-struct thermal_cooling_device *
-cpufreq_power_cooling_register(struct cpufreq_policy *policy, u32 capacitance,
-			       get_static_t plat_static_func)
-{
-	return __cpufreq_cooling_register(NULL, policy, capacitance,
-				plat_static_func);
-}
-EXPORT_SYMBOL(cpufreq_power_cooling_register);
-
 /**
  * of_cpufreq_power_cooling_register() - create cpufreq cooling device with power extensions
  * @policy: CPUFreq policy.
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index f09d4feb34f4..c35778960a9c 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -41,10 +41,6 @@ typedef int (*get_static_t)(cpumask_t *cpumask, int interval,
 struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy);
 
-struct thermal_cooling_device *
-cpufreq_power_cooling_register(struct cpufreq_policy *policy,
-			       u32 capacitance, get_static_t plat_static_func);
-
 /**
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
  * @np: a valid struct device_node to the cooling device device tree node.
@@ -84,12 +80,6 @@ cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return ERR_PTR(-ENOSYS);
 }
-static inline struct thermal_cooling_device *
-cpufreq_power_cooling_register(struct cpufreq_policy *policy,
-			       u32 capacitance, get_static_t plat_static_func)
-{
-	return NULL;
-}
 
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
-- 
2.15.0.194.g9af6a3dea062
