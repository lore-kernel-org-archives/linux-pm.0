From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/1] drivers: cpuidle: cpuidle-arm: heterogeneous systems extension
Date: Mon, 20 Jul 2015 15:54:51 +0100
Message-ID: <1437404091-30555-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1437404091-30555-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437404091-30555-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Howard Chen <howard.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Some ARM systems (eg big.LITTLE ones) can be composed of CPUs having
different hardware power management configurations and in the context
of CPUidle, different idle states. The generic ARM CPUidle driver
treats all possible CPUs as equal and initializes a common idle driver
through DT idle states for all possible CPUs.

Current driver cannot manage systems where CPUs are heterogeneous
and therefore can have different idle states.

This patch augments the generic ARM CPUidle driver, by adding code and
related config option that at boot allows to initialize CPUidle drivers
by going through the cpu_possible_mask and through DT parsing detects
the cpus sharing the same idle states, thus creating the CPUidle drivers
cpumasks.

The drivers are then initialized through the DT idle states interface,
that parses and initializes the DT idle states for the cpus set in the
drivers cpumasks.

When the newly introduced

ARM_CPUIDLE_MULTIPLE_DRIVERS

config option is selected, this patch instantiates a static array of idle
drivers (configurable through Kconfig), some of which can turn out to be
unused (eg platforms with a set of idle states smaller than the number of
static CPUidle drivers - a CPUidle driver is a set of idle states), and
selects the config option CPU_IDLE_MULTIPLE_DRIVERS by default; this can
cause a little memory overhead, but at the same time allows supporting most
of the current and future ARM platforms through a single generic CPUidle
driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Howard Chen <howard.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
---
 drivers/cpuidle/Kconfig.arm   |  25 +++++
 drivers/cpuidle/cpuidle-arm.c | 236 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 230 insertions(+), 31 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 21340e0..45d78ce 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -11,6 +11,31 @@ config ARM_CPUIDLE
           initialized by calling the CPU operations init idle hook
           provided by architecture code.
 
+config ARM_CPUIDLE_MULTIPLE_DRIVERS
+        bool "Support multiple Generic ARM/ARM64 CPU idle Drivers"
+	depends on ARM_CPUIDLE && SMP
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this option to enable initialization of multiple
+	  ARM generic CPUidle drivers to support systems having
+	  heterogeneous idle states. The sets of idle states are
+	  created through probing of firmware idle states and
+	  CPUidle drivers corresponding to the idle states sets
+	  are initialized through the DT idle states API.
+	  Each CPUidle driver manages CPUidle runtime behaviour for
+	  a set of logical cpus sharing the same idle states.
+
+config ARM_CPUIDLE_MAX_NR_DRIVERS
+	int "Maximum number of generic ARM CPUidle drivers to support (2 - 4)"
+	depends on ARM_CPUIDLE_MULTIPLE_DRIVERS
+	range 2 4
+	default "2"
+	help
+	  Systems with heterogeneous CPUs can require multiple idle
+	  drivers to be instantiated according to the sets of idle states
+	  provided by the platform firmware. This option defines
+	  the maximum number of generic ARM cpuidle drivers supported.
+
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..bd34ec03 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -14,6 +14,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
+#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -58,43 +59,15 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	return ret ? -1 : idx;
 }
 
-static struct cpuidle_driver arm_idle_driver = {
-	.name = "arm_idle",
-	.owner = THIS_MODULE,
-	/*
-	 * State at index 0 is standby wfi and considered standard
-	 * on all ARM platforms. If in some platforms simple wfi
-	 * can't be used as "state 0", DT bindings must be implemented
-	 * to work around this issue and allow installing a special
-	 * handler for idle state index 0.
-	 */
-	.states[0] = {
-		.enter                  = arm_enter_idle_state,
-		.exit_latency           = 1,
-		.target_residency       = 1,
-		.power_usage		= UINT_MAX,
-		.name                   = "WFI",
-		.desc                   = "ARM WFI",
-	}
-};
-
 static const struct of_device_id arm_idle_state_match[] __initconst = {
 	{ .compatible = "arm,idle-state",
 	  .data = arm_enter_idle_state },
 	{ },
 };
 
-/*
- * arm_idle_init
- *
- * Registers the arm specific cpuidle driver with the cpuidle
- * framework. It relies on core code to parse the idle states
- * and initialize them using driver data structures accordingly.
- */
-static int __init arm_idle_init(void)
+static int __init arm_idle_init_driver(struct cpuidle_driver *drv)
 {
-	int cpu, ret;
-	struct cpuidle_driver *drv = &arm_idle_driver;
+	int ret, cpu;
 	struct cpuidle_device *dev;
 
 	/*
@@ -117,7 +90,7 @@ static int __init arm_idle_init(void)
 	 * Call arch CPU operations in order to initialize
 	 * idle states suspend back-end specific data
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, drv->cpumask) {
 		ret = arm_cpuidle_init(cpu);
 
 		/*
@@ -157,7 +130,208 @@ out_fail:
 	}
 
 	cpuidle_unregister_driver(drv);
+	return ret;
+}
+
+#ifdef CONFIG_ARM_CPUIDLE_MULTIPLE_DRIVERS
+
+#define ARM_CPUIDLE_MAX_DRIVERS	 CONFIG_ARM_CPUIDLE_MAX_NR_DRIVERS
+
+static struct cpuidle_driver arm_idle_drivers[ARM_CPUIDLE_MAX_DRIVERS] = {
+	[0 ... ARM_CPUIDLE_MAX_DRIVERS - 1] = {
+		.name = "arm_idle",
+		.owner = THIS_MODULE,
+		/*
+		 * State at index 0 is standby wfi and considered standard
+		 * on all ARM platforms. If in some platforms simple wfi
+		 * can't be used as "state 0", DT bindings must be implemented
+		 * to work around this issue and allow installing a special
+		 * handler for idle state index 0.
+		 */
+		.states[0] = {
+			.enter                  = arm_enter_idle_state,
+			.exit_latency           = 1,
+			.target_residency       = 1,
+			.power_usage		= UINT_MAX,
+			.name                   = "WFI",
+			.desc                   = "ARM WFI",
+		}
+	}
+};
 
+/*
+ * Compare idle states phandle properties
+ *
+ * Return true if properties are valid and equal, false otherwise
+ */
+static bool __init idle_states_cmp(struct property *states1,
+				   struct property *states2)
+{
+	/*
+	 * NB: Implemented through code from drivers/of/unittest.c
+	 *     Function is generic and can be moved to generic OF code
+	 *     if needed
+	 */
+	return states1 && states2 &&
+	       (states1->length == states2->length) &&
+	       states1->value && states2->value &&
+	       !memcmp(states1->value, states2->value, states1->length);
+}
+
+static int __init arm_vet_idle_states(struct cpuidle_driver *drv)
+{
+	int cpu;
+	struct property *curr_idle_states, *idle_states = NULL;
+	struct device_node *cpu_node;
+
+	for_each_cpu(cpu, drv->cpumask) {
+		cpu_node = of_cpu_device_node_get(cpu);
+		curr_idle_states = of_find_property(cpu_node,
+						    "cpu-idle-states", NULL);
+		of_node_put(cpu_node);
+
+		/*
+		 * Stash the first valid idle states phandle in the cpumask.
+		 * If curr_idle_states is NULL assigning it to idle_states
+		 * is harmless and it is managed by idle states comparison
+		 * code. Keep track of first valid phandle so that
+		 * subsequent cpus can compare against it.
+		 */
+		if (!idle_states)
+			idle_states = curr_idle_states;
+
+		/*
+		 * If idle states phandles are not equal, remove the
+		 * cpu from the driver mask since a CPUidle driver
+		 * is only capable of managing uniform idle states.
+		 *
+		 * Comparison works also when idle_states and
+		 * curr_idle_states are the same property, since
+		 * they can be == NULL so the cpu must be removed from
+		 * the driver mask in that case too (ie cpu has no idle
+		 * states).
+		 */
+		if (!idle_states_cmp(idle_states, curr_idle_states))
+			cpumask_clear_cpu(cpu, drv->cpumask);
+	}
+
+	/*
+	 *  If there are no valid states for this driver we rely on arch
+	 *  default idle behaviour, bail out
+	 */
+	if (!idle_states)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int __init arm_init_drivers(void)
+{
+	int i, ret = -ENODEV;
+	struct cpuidle_driver *drv;
+	cpumask_var_t tmpmask;
+
+	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+	/*
+	 * We need to vet idle states to create CPUidle drivers
+	 * that share a common set of them. Create a tmp mask
+	 * that we use to keep track of initialized cpus.
+	 * Start off by initializing the mask with all possible
+	 * cpus, we clear it as we go, till either all cpus
+	 * have a CPUidle driver initialized or there are some
+	 * CPUs that have no idle states or a parsing error
+	 * occurs.
+	 */
+	cpumask_copy(tmpmask, cpu_possible_mask);
+
+	for (i = 0; !cpumask_empty(tmpmask); i++) {
+		if (i == ARM_CPUIDLE_MAX_DRIVERS) {
+			pr_warn("number of drivers exceeding static allocation\n");
+			break;
+		}
+
+		drv = &arm_idle_drivers[i];
+		drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
+		if (!drv->cpumask) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		/*
+		 * Force driver mask, arm_idle_init_driver()
+		 * will tweak it by vetting idle states.
+		 */
+		cpumask_copy(drv->cpumask, tmpmask);
+
+		ret = arm_vet_idle_states(drv);
+		if (ret) {
+			kfree(drv->cpumask);
+			break;
+		}
+
+		ret = arm_idle_init_driver(drv);
+		if (ret) {
+			kfree(drv->cpumask);
+			break;
+		}
+		/*
+		 * Remove the cpus that were part of the registered
+		 * driver from the mask of cpus to be initialized
+		 * and restart.
+		 */
+		cpumask_andnot(tmpmask, tmpmask, drv->cpumask);
+	}
+
+	free_cpumask_var(tmpmask);
 	return ret;
 }
+
+#else
+
+static struct cpuidle_driver arm_idle_driver = {
+		.name = "arm_idle",
+		.owner = THIS_MODULE,
+		/*
+		 * State at index 0 is standby wfi and considered standard
+		 * on all ARM platforms. If in some platforms simple wfi
+		 * can't be used as "state 0", DT bindings must be implemented
+		 * to work around this issue and allow installing a special
+		 * handler for idle state index 0.
+		 */
+		.states[0] = {
+			.enter                  = arm_enter_idle_state,
+			.exit_latency           = 1,
+			.target_residency       = 1,
+			.power_usage		= UINT_MAX,
+			.name                   = "WFI",
+			.desc                   = "ARM WFI",
+		}
+};
+
+static int __init arm_init_drivers(void)
+{
+	return arm_idle_init_driver(&arm_idle_driver);
+}
+#endif
+
+/*
+ * arm_idle_init
+ *
+ * Registers the arm specific cpuidle driver(s) with the cpuidle
+ * framework. It relies on core code to parse the idle states
+ * and initialize them using driver data structures accordingly.
+ */
+static int __init arm_idle_init(void)
+{
+	/*
+	 * These drivers require DT idle states to be present.
+	 * If no idle states are detected there is no reason to
+	 * proceed any further hence we return early.
+	 */
+	if (!of_find_node_by_name(NULL, "idle-states"))
+		return -ENODEV;
+
+	return arm_init_drivers();
+}
 device_initcall(arm_idle_init);
-- 
2.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
