From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v3 10/12] ARM64: psci: Support cluster idle states for OS-Initiated
Date: Tue,  1 Mar 2016 14:15:29 -0700
Message-ID: <1456866931-37851-12-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34796 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbcCAVQ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 16:16:27 -0500
Received: by mail-pf0-f177.google.com with SMTP id 4so41322955pfd.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 13:16:26 -0800 (PST)
In-Reply-To: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>

PSCI OS initiated firmware may allow Linux to determine the state of the
CPU cluster and the cluster at coherency level to enter idle states when
there are no active CPUs. Since Linux has a better idea of the QoS and
the wakeup pattern of the CPUs, the cluster idle states may be better
determined by the OS instead of the firmware.

The last CPU entering idle in a cluster, is responsible for selecting
the state of the cluster. Only one CPU in a cluster may provide the
cluster idle state to the firmware. Similarly, the last CPU in the
system may provide the state of the coherency domain along with the
cluster and the CPU state IDs.

Utilize the CPU PM domain framework's helper functions to build up the
hierarchy of cluster topology using Generic PM domains. We provide
callbacks for domain power_on and power_off. By appending the state IDs
at each domain level in the -power_off() callbacks, we build up a
composite state ID that can be passed onto the firmware to idle the CPU,
the cluster and the coherency interface.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/kernel/psci.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f67f35b..75b1707 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/cpu_domains.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
@@ -31,6 +32,24 @@
 #include <asm/suspend.h>
 
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static DEFINE_PER_CPU(u32, cluster_state_id);
+
+static inline u32 psci_get_composite_state_id(u32 cpu_state)
+{
+	return cpu_state | this_cpu_read(cluster_state_id);
+}
+
+static inline void psci_reset_composite_state_id(void)
+{
+	this_cpu_write(cluster_state_id, 0);
+}
+
+static int psci_pd_power_off(u32 state_idx, u32 param,
+		const struct cpumask *mask)
+{
+	__this_cpu_add(cluster_state_id, param);
+	return 0;
+}
 
 static int __maybe_unused cpu_psci_cpu_init_idle(unsigned int cpu)
 {
@@ -89,6 +108,19 @@ static int __maybe_unused cpu_psci_cpu_init_idle(unsigned int cpu)
 	}
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
+
+	if (psci_has_osi_pd_support()) {
+		const struct cpu_pd_ops psci_pd_ops = {
+			.power_off = psci_pd_power_off,
+		};
+
+		ret = of_setup_cpu_pd_single(cpu, &psci_pd_ops);
+		if (!ret)
+			ret = psci_set_suspend_mode_osi(true);
+		if (ret)
+			pr_warn("CPU%d: Error setting PSCI OSI mode\n", cpu);
+	}
+
 	return 0;
 
 free_mem:
@@ -117,6 +149,8 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 	if (err)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
 
+	/* Reset CPU cluster states */
+	psci_reset_composite_state_id();
 	return err;
 }
 
@@ -181,15 +215,16 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
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
@@ -198,10 +233,15 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
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

