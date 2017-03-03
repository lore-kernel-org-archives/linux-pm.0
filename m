From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH V5 3/6] drivers: firmware: psci: Support cluster idle states
 for OS-Initiated
Date: Fri,  3 Mar 2017 13:48:14 -0800
Message-ID: <1488577697-127445-4-git-send-email-lina.iyer@linaro.org>
References: <1488577697-127445-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488577697-127445-1-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, brendan.jackman@arm.com, sudeep.holla@arm.com, andy.gross@linaro.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
 drivers/firmware/psci.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index ec922b8..18ae62d 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu_domains.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
@@ -54,6 +55,18 @@
  */
 static int resident_cpu = -1;
 static bool psci_has_osi;
+static bool psci_has_osi_pd;
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
 
 bool psci_tos_resident_on(int cpu)
 {
@@ -180,6 +193,8 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 
 	fn = psci_function_id[PSCI_FN_CPU_ON];
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
+	/* Reset CPU cluster states */
+	psci_reset_composite_state_id();
 	return psci_to_linux_errno(err);
 }
 
@@ -251,6 +266,27 @@ static int __init psci_features(u32 psci_func_id)
 
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static bool psci_suspend_mode_is_osi;
+
+static int psci_set_suspend_mode_osi(bool enable)
+{
+	int ret;
+	int mode;
+
+	if (enable && !psci_has_osi)
+		return -ENODEV;
+
+	if (enable == psci_suspend_mode_is_osi)
+		return 0;
+
+	mode = enable ? PSCI_1_0_SUSPEND_MODE_OSI : PSCI_1_0_SUSPEND_MODE_PC;
+	ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			     mode, 0, 0);
+	if (!ret)
+		psci_suspend_mode_is_osi = enable;
+
+	return psci_to_linux_errno(ret);
+}
 
 static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
@@ -353,6 +389,39 @@ static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
 }
 #endif
 
+static int psci_pd_populate_state_data(struct device_node *np, u32 *param)
+{
+	return of_property_read_u32(np, "arm,psci-suspend-param", param);
+}
+
+static int psci_pd_power_off(u32 idx, u32 param, const struct cpumask *mask)
+{
+	__this_cpu_add(cluster_state_id, param);
+	return 0;
+}
+
+const struct cpu_pd_ops psci_pd_ops = {
+	.populate_state_data = psci_pd_populate_state_data,
+	.power_off = psci_pd_power_off,
+};
+
+static int psci_cpu_osi_pd_init(int cpu)
+{
+	int ret;
+
+	if (!psci_has_osi_pd)
+		return 0;
+
+	ret = of_setup_cpu_pd_single(cpu, &psci_pd_ops);
+	if (!ret) {
+		ret = psci_set_suspend_mode_osi(true);
+		if (ret)
+			pr_warn("CPU%d: Error setting PSCI OSI mode\n", cpu);
+	}
+
+	return ret;
+}
+
 int psci_cpu_init_idle(unsigned int cpu)
 {
 	struct device_node *cpu_node;
@@ -368,6 +437,10 @@ int psci_cpu_init_idle(unsigned int cpu)
 	if (!acpi_disabled)
 		return psci_acpi_cpu_init_idle(cpu);
 
+	ret = psci_cpu_osi_pd_init(cpu);
+	if (ret)
+		return ret;
+
 	cpu_node = of_get_cpu_node(cpu, NULL);
 	if (!cpu_node)
 		return -ENODEV;
@@ -382,15 +455,17 @@ int psci_cpu_init_idle(unsigned int cpu)
 static int psci_suspend_finisher(unsigned long index)
 {
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 ext_state = psci_get_composite_state_id(state[index - 1]);
 
-	return psci_ops.cpu_suspend(state[index - 1],
-				    virt_to_phys(cpu_resume));
+	return psci_ops.cpu_suspend(ext_state, virt_to_phys(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 ext_state = psci_get_composite_state_id(state[index - 1]);
+
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
 	 * from the cpu_suspend operations
@@ -399,10 +474,16 @@ int psci_cpu_suspend_enter(unsigned long index)
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
+
 	return ret;
 }
 
@@ -610,6 +691,7 @@ static int __init psci_0_1_init(struct device_node *np)
 
 static int __init psci_1_0_init(struct device_node *np)
 {
+	struct device_node *dn;
 	int ret;
 
 	ret = psci_0_2_init(np);
@@ -621,6 +703,11 @@ static int __init psci_1_0_init(struct device_node *np)
 	if (ret & PSCI_1_0_OS_INITIATED) {
 		if (!psci_features(PSCI_1_0_FN_SET_SUSPEND_MODE))
 			psci_has_osi = true;
+		/* Check if we power domains defined in the PSCI node */
+		dn = of_find_node_with_property(np, "#power-domain-cells");
+		if (dn)
+			psci_has_osi_pd = true;
+		of_node_put(dn);
 	}
 
 	return 0;
-- 
2.7.4
