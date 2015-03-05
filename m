From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 2/2] drivers: cpuidle: cpuidle-arm64: heterogeneous systems extension
Date: Thu,  5 Mar 2015 12:52:39 +0000
Message-ID: <1425559959-1796-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1425559959-1796-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57107 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbCEMx2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Mar 2015 07:53:28 -0500
In-Reply-To: <1425559959-1796-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>

Some ARM systems (eg big.LITTLE ones) can be composed of CPUs having
different hardware power management configurations and in the context
of CPUidle, different idle states. The current ARM64 CPUidle driver
treats all possible CPUs as equal and initializes a common idle driver
through DT idle states for all possible CPUs.

Current driver cannot manage systems where CPUs are heterogeneous
and therefore can have different idle states.

This patch augments the ARM64 CPUidle driver, by adding code that
at boot creates CPUidle drivers by going through the cpu_possible_map
and probes the DT in order to create a number of different idle
drivers depending on the idle states present in the device tree.

The dynamically created drivers are then initialized through the DT
idle states interface, that parses and initializes the DT idle states
for the cpus set in the drivers cpumasks.

Cc: Lina Iyer <lina.iyer@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig.arm64   |   1 +
 drivers/cpuidle/cpuidle-arm64.c | 153 ++++++++++++++++++++++++++--------------
 2 files changed, 101 insertions(+), 53 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
index 6effb36..8122308 100644
--- a/drivers/cpuidle/Kconfig.arm64
+++ b/drivers/cpuidle/Kconfig.arm64
@@ -4,6 +4,7 @@
 
 config ARM64_CPUIDLE
 	bool "Generic ARM64 CPU idle Driver"
+	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
 	help
 	  Select this to enable generic cpuidle driver for ARM64.
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 282fc33..539c094 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -58,9 +58,10 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
 	return ret ? -1 : idx;
 }
 
-static struct cpuidle_driver arm64_idle_driver = {
-	.name = "arm64_idle",
-	.owner = THIS_MODULE,
+static void __init arm64_init_driver(struct cpuidle_driver *drv)
+{
+	drv->name = "arm64_idle";
+	drv->owner = THIS_MODULE;
 	/*
 	 * State at index 0 is standby wfi and considered standard
 	 * on all ARM platforms. If in some platforms simple wfi
@@ -68,15 +69,13 @@ static struct cpuidle_driver arm64_idle_driver = {
 	 * to work around this issue and allow installing a special
 	 * handler for idle state index 0.
 	 */
-	.states[0] = {
-		.enter                  = arm64_enter_idle_state,
-		.exit_latency           = 1,
-		.target_residency       = 1,
-		.power_usage		= UINT_MAX,
-		.name                   = "WFI",
-		.desc                   = "ARM64 WFI",
-	}
-};
+	drv->states[0].enter = arm64_enter_idle_state;
+	drv->states[0].exit_latency = 1;
+	drv->states[0].target_residency = 1;
+	drv->states[0].power_usage = UINT_MAX;
+	strncpy(drv->states[0].name, "WFI", CPUIDLE_NAME_LEN - 1);
+	strncpy(drv->states[0].desc, "ARM64 WFI", CPUIDLE_DESC_LEN - 1);
+}
 
 static const struct of_device_id arm64_idle_state_match[] __initconst = {
 	{ .compatible = "arm,idle-state",
@@ -84,63 +83,111 @@ static const struct of_device_id arm64_idle_state_match[] __initconst = {
 	{ },
 };
 
-/*
- * arm64_idle_init
- *
- * Registers the arm64 specific cpuidle driver with the cpuidle
- * framework. It relies on core code to parse the idle states
- * and initialize them using driver data structures accordingly.
- */
+#define ARM64_CPUIDLE_MAX_DRIVERS 4
+
 static int __init arm64_idle_init(void)
 {
-	int cpu, ret;
-	struct cpuidle_driver *drv = &arm64_idle_driver;
+	int cpu, ret, cnt = 0;
+	struct cpuidle_driver *drivers[ARM64_CPUIDLE_MAX_DRIVERS], *drv = NULL;
+	cpumask_var_t tmpmask;
 
-	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
-	if (!drv->cpumask)
+	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpumask_copy(drv->cpumask, cpu_possible_mask);
+	cpumask_copy(tmpmask, cpu_possible_mask);
+
+	while (!cpumask_empty(tmpmask)) {
 
-	dt_probe_idle_affinity(drv->cpumask);
+		if (cnt == ARM64_CPUIDLE_MAX_DRIVERS) {
+			pr_warn("max number of idle drivers reached\n");
+			break;
+		}
+
+		if (!drv) {
+			drv = kzalloc(sizeof(*drv), GFP_KERNEL);
+			if (!drv) {
+				ret = -ENOMEM;
+				goto out_unregister;
+			}
+
+			drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
+			if (!drv->cpumask) {
+				ret = -ENOMEM;
+				goto out_driver;
+			}
+		}
 
-	if (!cpumask_equal(drv->cpumask, cpu_possible_mask)) {
 		/*
-		 * DT idle states are not uniform across all cpus, bail out
+		 * Initialize driver default idle states and common variables
 		 */
-		ret = -ENODEV;
-		goto out_mask;
-	}
-	/*
-	 * Initialize idle states data, starting at index 1.
-	 * This driver is DT only, if no DT idle states are detected (ret == 0)
-	 * let the driver initialization fail accordingly since there is no
-	 * reason to initialize the idle driver if only wfi is supported.
-	 */
-	ret = dt_init_idle_driver(drv, arm64_idle_state_match, 1);
-	if (ret <= 0) {
-		ret = ret ? : -ENODEV;
-		goto out_mask;
-	}
+		arm64_init_driver(drv);
+
+		cpumask_copy(drv->cpumask, tmpmask);
+
+		dt_probe_idle_affinity(drv->cpumask);
+		/*
+		 * Remove the driver cpumask from the list of cpus
+		 * that are still to be probed for idle states detection
+		 */
+		cpumask_andnot(tmpmask, tmpmask, drv->cpumask);
+
+		/*
+		 * Initialize idle states data, starting at index 1.
+		 * These drivers are DT only, if no DT idle states are detected
+		 * (ret == 0) let the driver initialization fail accordingly
+		 * since there is no reason to initialize the idle driver if
+		 * only wfi is supported.
+		 */
+		ret = dt_init_idle_driver(drv, arm64_idle_state_match, 1);
+		if (ret <= 0) {
+			/*
+			 * Give other drivers a chance to init
+			 * even if for this cpumask no idle
+			 * states were detected
+			 */
+			if (!ret)
+				continue;
 
-	/*
-	 * Call arch CPU operations in order to initialize
-	 * idle states suspend back-end specific data
-	 */
-	for_each_possible_cpu(cpu) {
-		ret = cpu_init_idle(cpu);
-		if (ret) {
-			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
 			goto out_mask;
 		}
+
+		/*
+		 * Call arch CPU operations in order to initialize
+		 * idle states suspend back-end specific data
+		 */
+		for_each_cpu(cpu, drv->cpumask) {
+			ret = cpu_init_idle(cpu);
+			if (ret) {
+				pr_err("CPU %d failed to init idle CPU ops\n",
+				       cpu);
+				goto out_mask;
+			}
+		}
+
+		ret = cpuidle_register(drv, NULL);
+		if (ret)
+			goto out_mask;
+
+		drivers[cnt++] = drv;
+		drv = NULL;
 	}
 
-	ret = cpuidle_register(drv, NULL);
-	if (!ret)
-		return ret;
+	free_cpumask_var(tmpmask);
+	return 0;
 
- out_mask:
+out_mask:
 	kfree(drv->cpumask);
+out_driver:
+	kfree(drv);
+out_unregister:
+	while (--cnt >= 0) {
+		cpuidle_unregister(drivers[cnt]);
+		kfree(drivers[cnt]->cpumask);
+		kfree(drivers[cnt]);
+	}
+
+	free_cpumask_var(tmpmask);
+
 	return ret;
 }
 device_initcall(arm64_idle_init);
-- 
2.2.1

