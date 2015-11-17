From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 23/27] ARM64: psci: Support cluster idle states for OS-Initated
Date: Tue, 17 Nov 2015 15:37:47 -0700
Message-ID: <1447799871-56374-24-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34415 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641AbbKQWjF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:39:05 -0500
Received: by padhx2 with SMTP id hx2so22145339pad.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:39:04 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>

ARMv8 PSCI firmware may allow Linux to determine the state of the CPU
cluster and the cluster at coherency level to enter idle states when
there are no active CPUs. Since Linux has a better idea of the QoS and
the wakeup pattern of the CPUs, the cluster idle states may be better
determined by the OS instead of the firmware.

The last CPU entering idle in a cluster, holds the responsibility of
selecting the state of the cluster. Only one CPU in a cluster may
provide the cluster idle state to the firmware. Similarly, the last CPU
in the cluster of clusters may provide the state of the coherency
domain.

The CPU PM domain framework facilitates registration of CPU PM domains
and reference counting for the last man down and the first man up. But
the organzation of CPUs into clusters must be provided. The cpu-map
topology node provides the information. Call into the CPU PM framework
to parse the CPU topology node and setup the PM domains. The state id
for the cluster ids is available with the domain idle state.

The last CPU PSCI state id of the entire system would therefore be -
Coherency State ID + Cluster State ID + CPU idle state ID, that is
passed into the PSCI firmware when the CPU makes the PSCI enable-method.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/kernel/psci.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f67f35b..6618d33 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -15,10 +15,12 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/cpu-pd.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
 #include <linux/delay.h>
+#include <linux/pm_domain.h>
 #include <linux/psci.h>
 #include <linux/slab.h>
 
@@ -31,6 +33,44 @@
 #include <asm/suspend.h>
 
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static DEFINE_PER_CPU(u32, cluster_state_id);
+
+static inline u32 psci_get_composite_state_id(u32 cpu_state)
+{
+	u32 val = cpu_state;
+
+	if (psci_has_ext_power_state())
+		val += this_cpu_read(cluster_state_id);
+
+	return val;
+}
+
+static inline void psci_reset_composite_state_id(void)
+{
+	this_cpu_write(cluster_state_id, 0);
+}
+
+static int psci_pd_power_on(struct generic_pm_domain *genpd)
+{
+	return 0;
+}
+
+static int psci_pd_power_off(struct generic_pm_domain *genpd)
+{
+	__this_cpu_add(cluster_state_id, genpd->states[genpd->state_idx].param);
+	return 0;
+}
+
+static const struct cpu_pd_ops psci_pd_ops = {
+	.power_on = psci_pd_power_on,
+	.power_off = psci_pd_power_off,
+};
+
+static int __init psci_setup_cpu_domains(void)
+{
+	return of_setup_cpu_domain_topology(&psci_pd_ops);
+}
+subsys_initcall(psci_setup_cpu_domains);
 
 static int __maybe_unused cpu_psci_cpu_init_idle(unsigned int cpu)
 {
@@ -117,6 +157,8 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 	if (err)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
 
+	/* Reset CPU cluster states */
+	psci_reset_composite_state_id();
 	return err;
 }
 
@@ -181,15 +223,16 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 static int psci_suspend_finisher(unsigned long index)
 {
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 ext_state = psci_get_composite_state_id(state[index - 1]);
 
-	return psci_ops.cpu_suspend(state[index - 1],
-				    virt_to_phys(cpu_resume));
+	return psci_ops.cpu_suspend(ext_state, virt_to_phys(cpu_resume));
 }
 
 static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 ext_state = psci_get_composite_state_id(state[index - 1]);
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
 	 * from the cpu_suspend operations
@@ -198,10 +241,15 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 		return -EINVAL;
 
 	if (!psci_power_state_loses_context(state[index - 1]))
-		ret = psci_ops.cpu_suspend(state[index - 1], 0);
+		ret = psci_ops.cpu_suspend(ext_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	/*
+	 * Clear the CPU's cluster states, we start afresh after coming
+	 * out of idle.
+	 */
+	psci_reset_composite_state_id();
 	return ret;
 }
 
-- 
2.1.4

