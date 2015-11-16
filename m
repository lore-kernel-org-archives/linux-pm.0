From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v4 3/3] cpufreq: arm_big_little: Add support to register a cpufreq cooling device
Date: Mon, 16 Nov 2015 19:30:25 +0000
Message-ID: <1447702225-13323-4-git-send-email-punit.agrawal@arm.com>
References: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com, javi.merino@arm.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Register passive cooling devices when initialising cpufreq on
big.LITTLE systems. If the device tree provides a dynamic power
coefficient for the CPUs then the bound cooling device will support
the extensions that allow it to be used with all the existing thermal
governors including the power allocator governor.

A cooling device will be created per individual frequency domain and
can be bound to thermal zones via the thermal DT bindings.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/Kconfig.arm      |  2 ++
 drivers/cpufreq/arm_big_little.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1582c1c..0e0052e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -6,6 +6,8 @@
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
 	depends on (ARM_CPU_TOPOLOGY || ARM64) && HAVE_CLK
+	# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
+	depends on !CPU_THERMAL || THERMAL
 	select PM_OPP
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index c5d256c..60d09c0 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -55,6 +56,7 @@ static bool bL_switching_enabled;
 #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
 #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
 
+static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
 static struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
@@ -493,6 +495,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev;
+	int domain;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -501,12 +504,43 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
+	domain = topology_physical_package_id(cpu_dev->id);
+	cpufreq_cooling_unregister(cdev[domain]);
+	cdev[domain] = NULL;
+
 	put_cluster_clk_and_freq_table(cpu_dev);
 	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
 
 	return 0;
 }
 
+static void bL_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	struct device_node *np = of_node_get(cpu_dev->of_node);
+	int domain = topology_physical_package_id(cpu_dev->id);
+
+	if (WARN_ON(!np))
+		return;
+
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		u32 power_coefficient = 0;
+
+		of_property_read_u32(np, "dynamic-power-coefficient",
+				     &power_coefficient);
+
+		cdev[domain] = of_cpufreq_power_cooling_register(np,
+				policy->related_cpus, power_coefficient, NULL);
+		if (IS_ERR(cdev[domain])) {
+			dev_err(cpu_dev,
+				"running cpufreq without cooling device: %ld\n",
+				PTR_ERR(cdev[domain]));
+			cdev[domain] = NULL;
+		}
+	}
+	of_node_put(np);
+}
+
 static struct cpufreq_driver bL_cpufreq_driver = {
 	.name			= "arm-big-little",
 	.flags			= CPUFREQ_STICKY |
@@ -517,6 +551,7 @@ static struct cpufreq_driver bL_cpufreq_driver = {
 	.get			= bL_cpufreq_get_rate,
 	.init			= bL_cpufreq_init,
 	.exit			= bL_cpufreq_exit,
+	.ready			= bL_cpufreq_ready,
 	.attr			= cpufreq_generic_attr,
 };
 
-- 
2.6.2
