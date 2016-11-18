From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
Date: Thu, 17 Nov 2016 19:15:02 -0800
Message-ID: <1479438902-167977-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:19230 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbcKRDST (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Nov 2016 22:18:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When user has selected performance policy, then set the EPP (Energy
Performance Preference) or EPB (Energy Performance Bias) to maximum
performance mode.
Also when user switch back to powersave, then restore EPP/EPB to power on
default value.
It is also possible to change EPP/EPB using direct MSR writes or using
x86_energy_perf_policy utility. When user changes the default EPP/EPB
value using the above methods in powersave policy, then this change
preserves those settings, whenever intel_pstate_hwp_set() is called.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 104 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4737520..2dade36 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -196,6 +196,8 @@ struct _pid {
  * @sample:		Storage for storing last Sample data
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
+ * @epp_default:	Power on default HWP energy performance preference
+ *			or energy performance bias
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -222,6 +224,7 @@ struct cpudata {
 	bool valid_pss_table;
 #endif
 	unsigned int iowait_boost;
+	int epp_default;
 };
 
 static struct cpudata **all_cpu_data;
@@ -559,12 +562,76 @@ static inline void update_turbo_state(void)
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
 
+static int intel_pstate_get_epb(struct cpudata *cpu_data)
+{
+	u64 epb;
+	int ret;
+
+	if (!static_cpu_has(X86_FEATURE_EPB))
+		return -ENXIO;
+
+	ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	if (ret)
+		return ret;
+
+	return (int)(epb & 0x0f);
+}
+
+static int intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
+{
+	int epp;
+
+	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+		if (!hwp_req_data) {
+			int ret;
+
+			ret = rdmsrl_on_cpu(cpu_data->cpu,
+					    MSR_HWP_REQUEST,
+					    &hwp_req_data);
+			if (ret)
+				return ret;
+		}
+		epp = (hwp_req_data >> 24) & 0xff;
+	} else {
+		/* When there is no EPP present, HWP uses EPB settings */
+		epp = intel_pstate_get_epb(cpu_data);
+	}
+
+	return epp;
+}
+
+static void intel_pstate_update_epp(struct cpudata *cpu_data)
+{
+	int epp;
+
+	epp = intel_pstate_get_epp(cpu_data, 0);
+
+	if (!cpu_data->epp_default)
+		cpu_data->epp_default = epp;
+}
+
+static void intel_pstate_set_epb(int cpu, int pref)
+{
+	u64 epb;
+
+	if (!static_cpu_has(X86_FEATURE_EPB))
+		return;
+
+	if (rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb))
+		return;
+
+	epb = (epb & ~0x0f) | pref;
+	wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
+}
+
 static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
 	u64 value, cap;
 
 	for_each_cpu(cpu, cpumask) {
+		struct cpudata *cpu_data = all_cpu_data[cpu];
+
 		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 		hw_min = HWP_LOWEST_PERF(cap);
 		hw_max = HWP_HIGHEST_PERF(cap);
@@ -586,6 +653,42 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
+		/*
+		 * If there was error reading during epp/epb, then don't
+		 * set EPP/EPB values. In this case
+		 * cpu_data->epp_default will be set to -errno
+		 */
+		if (cpu_data->epp_default >= 0) {
+			int epp;
+
+			if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
+				epp = 0;
+			} else {
+				/*
+				 * If epp was non zero after policy switch to
+				 * powersave policy or already in powersave
+				 * policy, then EPP was never changed from
+				 * power on value or user manually changed via
+				 * some utilities. In this case don't set
+				 * EPP/EPB in this case.
+				 * Otherwise restore power on default EPP/EPB
+				 * after policy switch from performance.
+				 */
+				epp = intel_pstate_get_epp(cpu_data, value);
+				if (epp)
+					goto skip_epp;
+				else
+					epp = cpu_data->epp_default;
+			}
+
+			if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+				value &= ~GENMASK_ULL(31, 24);
+				value |= (u64)epp << 24;
+			} else {
+				intel_pstate_set_epb(cpu, epp);
+			}
+		}
+skip_epp:
 		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 	}
 }
@@ -818,6 +921,7 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
+	intel_pstate_update_epp(cpudata);
 }
 
 static int atom_get_min_pstate(void)
-- 
2.7.4

