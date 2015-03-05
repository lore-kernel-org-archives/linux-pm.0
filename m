From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 1/2] drivers: cpuidle: introduce DT idle affinity probing function
Date: Thu,  5 Mar 2015 12:52:38 +0000
Message-ID: <1425559959-1796-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57102 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbCEMx1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Mar 2015 07:53:27 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>

Current DT idle state parsing code validates the idle states while
parsing them for the first logical cpu in the CPUidle driver cpumask,
at driver probing time.

This check is not thorough in that it misses configurations where cpus
other than the first in the driver cpumask have more idle states
than the first cpu in the mask, resulting in false positives.

Furthermore, on systems where cpus are allowed to have different
idle states, current DT parsing code prevents idle states
initialization, which consequently causes the CPUidle driver
initialization to fail.

This patch removes the idle_state_valid() function call check in
dt_init_idle_driver() and adds a new DT function, dt_probe_idle_affinity(),
that allows probing the affinity cpumask in order to detect cpus sharing
a common set of idle states.

This way, CPUidle drivers can use the newly introduced function to
probe cpus in the affinity mask that share the same idle states,
therefore creating an idle affinity cpumask, which is the basic requirement
defining a CPUidle driver.

Existing CPUidle drivers that make use of the DT idle states API are
updated accordingly.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/cpuidle-arm64.c      | 32 ++++++++++--
 drivers/cpuidle/cpuidle-big_little.c |  2 +
 drivers/cpuidle/dt_idle_states.c     | 98 +++++++++++++++++++++++++-----------
 drivers/cpuidle/dt_idle_states.h     |  2 +
 4 files changed, 101 insertions(+), 33 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 39a2c62..282fc33 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <asm/cpuidle.h>
 
@@ -95,6 +96,21 @@ static int __init arm64_idle_init(void)
 	int cpu, ret;
 	struct cpuidle_driver *drv = &arm64_idle_driver;
 
+	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
+	if (!drv->cpumask)
+		return -ENOMEM;
+
+	cpumask_copy(drv->cpumask, cpu_possible_mask);
+
+	dt_probe_idle_affinity(drv->cpumask);
+
+	if (!cpumask_equal(drv->cpumask, cpu_possible_mask)) {
+		/*
+		 * DT idle states are not uniform across all cpus, bail out
+		 */
+		ret = -ENODEV;
+		goto out_mask;
+	}
 	/*
 	 * Initialize idle states data, starting at index 1.
 	 * This driver is DT only, if no DT idle states are detected (ret == 0)
@@ -102,8 +118,10 @@ static int __init arm64_idle_init(void)
 	 * reason to initialize the idle driver if only wfi is supported.
 	 */
 	ret = dt_init_idle_driver(drv, arm64_idle_state_match, 1);
-	if (ret <= 0)
-		return ret ? : -ENODEV;
+	if (ret <= 0) {
+		ret = ret ? : -ENODEV;
+		goto out_mask;
+	}
 
 	/*
 	 * Call arch CPU operations in order to initialize
@@ -113,10 +131,16 @@ static int __init arm64_idle_init(void)
 		ret = cpu_init_idle(cpu);
 		if (ret) {
 			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
-			return ret;
+			goto out_mask;
 		}
 	}
 
-	return cpuidle_register(drv, NULL);
+	ret = cpuidle_register(drv, NULL);
+	if (!ret)
+		return ret;
+
+ out_mask:
+	kfree(drv->cpumask);
+	return ret;
 }
 device_initcall(arm64_idle_init);
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 40c34fa..a9c3217 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -201,11 +201,13 @@ static int __init bl_idle_init(void)
 	if (ret)
 		goto out_uninit_little;
 
+	dt_probe_idle_affinity(bl_idle_big_driver.cpumask);
 	/* Start at index 1, index 0 standard WFI */
 	ret = dt_init_idle_driver(&bl_idle_big_driver, bl_idle_state_match, 1);
 	if (ret < 0)
 		goto out_uninit_big;
 
+	dt_probe_idle_affinity(bl_idle_little_driver.cpumask);
 	/* Start at index 1, index 0 standard WFI */
 	ret = dt_init_idle_driver(&bl_idle_little_driver,
 				  bl_idle_state_match, 1);
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index a5c111b..196f696 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -91,40 +91,87 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	return 0;
 }
 
-/*
- * Check that the idle state is uniform across all CPUs in the CPUidle driver
- * cpumask
+/**
+ * dt_vet_idle_state_mask() - Vet cpumask for a specific idle state
+ *
+ * @state_node: device node of the idle state to be vetted
+ * @idx: idle state index in cpu-idle-states phandle
+ * @possible_mask: cpumask containing cpus to be vetted
+ *
+ * Function that vets and updates the possible_mask by checking if a
+ * specific idle state is valid on all cpus in the possible_mask. If an idle
+ * state for a specific cpu in the possible_mask is either missing or
+ * different from the state_node, the corresponding cpu is cleared from
+ * the possible_mask since this means that the cpu has different idle
+ * states from the first cpu in the possible_mask.
  */
-static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
-			     const cpumask_t *cpumask)
+static void dt_vet_idle_state_mask(struct device_node *state_node,
+				   unsigned int idx,
+				   cpumask_t *possible_mask)
 {
 	int cpu;
 	struct device_node *cpu_node, *curr_state_node;
-	bool valid = true;
 
 	/*
 	 * Compare idle state phandles for index idx on all CPUs in the
-	 * CPUidle driver cpumask. Start from next logical cpu following
-	 * cpumask_first(cpumask) since that's the CPU state_node was
-	 * retrieved from. If a mismatch is found bail out straight
-	 * away since we certainly hit a firmware misconfiguration.
+	 * possible_mask. Start from next logical cpu following the first
+	 * cpu since that's the CPU state_node was retrieved from. If a
+	 * mismatch is found the mismatching cpu is removed from the
+	 * possible_mask in that it has an idle state that is not present
+	 * in the idle states list of the cpu we are vetting the affinity
+	 * for.
 	 */
-	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
-	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
+	for (cpu = cpumask_next(cpumask_first(possible_mask), possible_mask);
+	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, possible_mask)) {
 		cpu_node = of_cpu_device_node_get(cpu);
 		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
 						   idx);
 		if (state_node != curr_state_node)
-			valid = false;
+			cpumask_clear_cpu(cpu, possible_mask);
 
 		of_node_put(curr_state_node);
 		of_node_put(cpu_node);
-		if (!valid)
+	}
+
+}
+
+/**
+ * dt_probe_idle_affinity() - Parse the DT idle states and set the
+ *                            idle states affinity mask
+ * @possible_mask: Pointer to the affinity mask to be probed
+ *
+ * Function probes validity of the possible_mask by comparing
+ * the idle states for all cpus in the possible_mask to the idle
+ * states of the first cpu in the possible_mask. If idle states for a
+ * cpu in the possible_mask differ from the ones of the first cpu, the
+ * cpu in question is cleared in the possible_mask.
+ */
+void dt_probe_idle_affinity(cpumask_t *possible_mask)
+{
+	struct device_node *state_node, *cpu_node;
+	int i;
+
+	cpu_node = of_cpu_device_node_get(cpumask_first(possible_mask));
+	for (i = 0; ; i++) {
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		/*
+		 * cpus in the possible_mask can have more idle states than
+		 * the one we are checking against so even if
+		 * state_node == NULL we have to keep parsing so that we can
+		 * find a mismatch with other cpus in the mask and clear them
+		 * since they have different idle states.
+		 */
+		dt_vet_idle_state_mask(state_node, i, possible_mask);
+
+		if (!state_node)
 			break;
+
+		of_node_put(state_node);
 	}
 
-	return valid;
+	of_node_put(cpu_node);
 }
+EXPORT_SYMBOL_GPL(dt_probe_idle_affinity);
 
 /**
  * dt_init_idle_driver() - Parse the DT idle states and initialize the
@@ -155,20 +202,20 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 	struct cpuidle_state *idle_state;
 	struct device_node *state_node, *cpu_node;
 	int i, err = 0;
-	const cpumask_t *cpumask;
 	unsigned int state_idx = start_idx;
 
 	if (state_idx >= CPUIDLE_STATE_MAX)
 		return -EINVAL;
+
+	if (!drv->cpumask)
+		return -EINVAL;
 	/*
 	 * We get the idle states for the first logical cpu in the
-	 * driver mask (or cpu_possible_mask if the driver cpumask is not set)
-	 * and we check through idle_state_valid() if they are uniform
-	 * across CPUs, otherwise we hit a firmware misconfiguration.
+	 * driver mask. The driver mask must have been previously vetted
+	 * through dt_probe_idle_affinity to make sure all of the
+	 * cpus in the driver cpumask have common idle states.
 	 */
-	cpumask = drv->cpumask ? : cpu_possible_mask;
-	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
-
+	cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));
 	for (i = 0; ; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
 		if (!state_node)
@@ -177,13 +224,6 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!of_device_is_available(state_node))
 			continue;
 
-		if (!idle_state_valid(state_node, i, cpumask)) {
-			pr_warn("%s idle state not valid, bailing out\n",
-				state_node->full_name);
-			err = -EINVAL;
-			break;
-		}
-
 		if (state_idx == CPUIDLE_STATE_MAX) {
 			pr_warn("State index reached static CPU idle driver states array size\n");
 			break;
diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_idle_states.h
index 4818134..faa95bf 100644
--- a/drivers/cpuidle/dt_idle_states.h
+++ b/drivers/cpuidle/dt_idle_states.h
@@ -1,6 +1,8 @@
 #ifndef __DT_IDLE_STATES
 #define __DT_IDLE_STATES
 
+void dt_probe_idle_affinity(cpumask_t *possible_mask);
+
 int dt_init_idle_driver(struct cpuidle_driver *drv,
 			const struct of_device_id *matches,
 			unsigned int start_idx);
-- 
2.2.1

