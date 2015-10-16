From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 2/2] ARM64: kernel: PSCI: move PSCI idle management code to drivers/firmware
Date: Fri, 16 Oct 2015 17:02:59 +0100
Message-ID: <1445011379-8787-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42313 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932449AbbJPQC2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 12:02:28 -0400
In-Reply-To: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Jisheng Zhang <jszhang@marvell.com>

ARM64 PSCI kernel interfaces that initialize idle states and implement
the suspend API to enter them are generic and can be shared with the
ARM architecture.

To achieve that goal, this patch moves ARM64 PSCI idle management
code to drivers/firmware, so that the interface to initialize and
enter idle states can actually be shared by ARM and ARM64 arches
back-ends.

The ARM generic CPUidle implementation also requires the definition of
a cpuidle_ops section entry for the kernel to initialize the CPUidle
operations at boot based on the enable-method (ie ARM64 has the
statically initialized cpu_ops counterparts for that purpose); therefore
this patch also adds the required section entry on CONFIG_ARM for PSCI so
that the kernel can initialize the PSCI CPUidle back-end when PSCI is
the probed enable-method.

On ARM64 this patch provides no functional change.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com> [arch/arm64]
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Jisheng Zhang <jszhang@marvell.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/psci.c |  99 +--------------------------------------
 drivers/firmware/psci.c  | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/psci.h     |   3 ++
 3 files changed, 124 insertions(+), 97 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f67f35b..42816be 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -20,7 +20,6 @@
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/psci.h>
-#include <linux/slab.h>
 
 #include <uapi/linux/psci.h>
 
@@ -28,73 +27,6 @@
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
 #include <asm/smp_plat.h>
-#include <asm/suspend.h>
-
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
-
-static int __maybe_unused cpu_psci_cpu_init_idle(unsigned int cpu)
-{
-	int i, ret, count = 0;
-	u32 *psci_states;
-	struct device_node *state_node, *cpu_node;
-
-	cpu_node = of_get_cpu_node(cpu, NULL);
-	if (!cpu_node)
-		return -ENODEV;
-
-	/*
-	 * If the PSCI cpu_suspend function hook has not been initialized
-	 * idle states must not be enabled, so bail out
-	 */
-	if (!psci_ops.cpu_suspend)
-		return -EOPNOTSUPP;
-
-	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
-		count++;
-		of_node_put(state_node);
-	}
-
-	if (!count)
-		return -ENODEV;
-
-	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
-	if (!psci_states)
-		return -ENOMEM;
-
-	for (i = 0; i < count; i++) {
-		u32 state;
-
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
-
-		ret = of_property_read_u32(state_node,
-					   "arm,psci-suspend-param",
-					   &state);
-		if (ret) {
-			pr_warn(" * %s missing arm,psci-suspend-param property\n",
-				state_node->full_name);
-			of_node_put(state_node);
-			goto free_mem;
-		}
-
-		of_node_put(state_node);
-		pr_debug("psci-power-state %#x index %d\n", state, i);
-		if (!psci_power_state_is_valid(state)) {
-			pr_warn("Invalid PSCI power state %#x\n", state);
-			ret = -EINVAL;
-			goto free_mem;
-		}
-		psci_states[i] = state;
-	}
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
-	return 0;
-
-free_mem:
-	kfree(psci_states);
-	return ret;
-}
 
 static int __init cpu_psci_cpu_init(unsigned int cpu)
 {
@@ -178,38 +110,11 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 }
 #endif
 
-static int psci_suspend_finisher(unsigned long index)
-{
-	u32 *state = __this_cpu_read(psci_power_state);
-
-	return psci_ops.cpu_suspend(state[index - 1],
-				    virt_to_phys(cpu_resume));
-}
-
-static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
-{
-	int ret;
-	u32 *state = __this_cpu_read(psci_power_state);
-	/*
-	 * idle state index 0 corresponds to wfi, should never be called
-	 * from the cpu_suspend operations
-	 */
-	if (WARN_ON_ONCE(!index))
-		return -EINVAL;
-
-	if (!psci_power_state_loses_context(state[index - 1]))
-		ret = psci_ops.cpu_suspend(state[index - 1], 0);
-	else
-		ret = cpu_suspend(index, psci_suspend_finisher);
-
-	return ret;
-}
-
 const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
 #ifdef CONFIG_CPU_IDLE
-	.cpu_init_idle	= cpu_psci_cpu_init_idle,
-	.cpu_suspend	= cpu_psci_cpu_suspend,
+	.cpu_init_idle	= psci_cpu_init_idle,
+	.cpu_suspend	= psci_cpu_suspend_enter,
 #endif
 	.cpu_init	= cpu_psci_cpu_init,
 	.cpu_prepare	= cpu_psci_cpu_prepare,
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 492db42..73046de 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -13,17 +13,21 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/cpuidle.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
+#include <linux/percpu.h>
 #include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
+#include <linux/slab.h>
 #include <linux/suspend.h>
 
 #include <uapi/linux/psci.h>
 
+#include <asm/cpuidle.h>
 #include <asm/cputype.h>
 #include <asm/system_misc.h>
 #include <asm/smp_plat.h>
@@ -225,6 +229,121 @@ static int __init psci_features(u32 psci_func_id)
 			      psci_func_id, 0, 0);
 }
 
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
+static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+{
+	int i, ret, count = 0;
+	u32 *psci_states;
+	struct device_node *state_node;
+
+	/*
+	 * If the PSCI cpu_suspend function hook has not been initialized
+	 * idle states must not be enabled, so bail out
+	 */
+	if (!psci_ops.cpu_suspend)
+		return -EOPNOTSUPP;
+
+	/* Count idle states */
+	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
+					      count))) {
+		count++;
+		of_node_put(state_node);
+	}
+
+	if (!count)
+		return -ENODEV;
+
+	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	if (!psci_states)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		u32 state;
+
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+
+		ret = of_property_read_u32(state_node,
+					   "arm,psci-suspend-param",
+					   &state);
+		if (ret) {
+			pr_warn(" * %s missing arm,psci-suspend-param property\n",
+				state_node->full_name);
+			of_node_put(state_node);
+			goto free_mem;
+		}
+
+		of_node_put(state_node);
+		pr_debug("psci-power-state %#x index %d\n", state, i);
+		if (!psci_power_state_is_valid(state)) {
+			pr_warn("Invalid PSCI power state %#x\n", state);
+			ret = -EINVAL;
+			goto free_mem;
+		}
+		psci_states[i] = state;
+	}
+	/* Idle states parsed correctly, initialize per-cpu pointer */
+	per_cpu(psci_power_state, cpu) = psci_states;
+	return 0;
+
+free_mem:
+	kfree(psci_states);
+	return ret;
+}
+
+int psci_cpu_init_idle(unsigned int cpu)
+{
+	struct device_node *cpu_node;
+	int ret;
+
+	cpu_node = of_get_cpu_node(cpu, NULL);
+	if (!cpu_node)
+		return -ENODEV;
+
+	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
+
+	of_node_put(cpu_node);
+
+	return ret;
+}
+
+static int psci_suspend_finisher(unsigned long index)
+{
+	u32 *state = __this_cpu_read(psci_power_state);
+
+	return psci_ops.cpu_suspend(state[index - 1],
+				    virt_to_phys(cpu_resume));
+}
+
+int psci_cpu_suspend_enter(unsigned long index)
+{
+	int ret;
+	u32 *state = __this_cpu_read(psci_power_state);
+	/*
+	 * idle state index 0 corresponds to wfi, should never be called
+	 * from the cpu_suspend operations
+	 */
+	if (WARN_ON_ONCE(!index))
+		return -EINVAL;
+
+	if (!psci_power_state_loses_context(state[index - 1]))
+		ret = psci_ops.cpu_suspend(state[index - 1], 0);
+	else
+		ret = cpu_suspend(index, psci_suspend_finisher);
+
+	return ret;
+}
+
+/* ARM specific CPU idle operations */
+#ifdef CONFIG_ARM
+static struct cpuidle_ops psci_cpuidle_ops __initdata = {
+	.suspend = psci_cpu_suspend_enter,
+	.init = psci_dt_cpu_init_idle,
+};
+
+CPUIDLE_METHOD_OF_DECLARE(psci, "arm,psci", &psci_cpuidle_ops);
+#endif
+
 static int psci_system_suspend(unsigned long unused)
 {
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 12c4865..393efe2 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -24,6 +24,9 @@ bool psci_tos_resident_on(int cpu);
 bool psci_power_state_loses_context(u32 state);
 bool psci_power_state_is_valid(u32 state);
 
+int psci_cpu_init_idle(unsigned int cpu);
+int psci_cpu_suspend_enter(unsigned long index);
+
 struct psci_operations {
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
 	int (*cpu_off)(u32 state);
-- 
2.5.1

