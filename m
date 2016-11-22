From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
Date: Tue, 22 Nov 2016 15:44:29 -0800
Message-ID: <1479858269-175501-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:27358 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934427AbcKVXoe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 18:44:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When user has selected performance policy, then set the EPP (Energy
Performance Preference) or EPB (Energy Performance Bias) to maximum
performance mode.
Also when user switch back to powersave, then restore EPP/EPB to last
EPP/EPB value before entering performance mode. If user has not changed
EPP/EPB manually then it will be power on default value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
	Save EPP/EPB when policy is switched to performance and restore
	on entering powersave policy, when EPP/EPB is still 0.

 drivers/cpufreq/intel_pstate.c | 82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 72e8bbc..8e7ceef 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -243,6 +243,8 @@ struct perf_limits {
  *			when per cpu controls are enforced
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
+ * @epp_saved:		Last saved HWP energy performance preference
+ *			or energy performance bias
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -270,6 +272,7 @@ struct cpudata {
 	bool valid_pss_table;
 #endif
 	unsigned int iowait_boost;
+	int epp_saved;
 };
 
 static struct cpudata **all_cpu_data;
@@ -568,6 +571,48 @@ static inline void update_turbo_state(void)
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
+	if (static_cpu_has(X86_FEATURE_HWP_EPP))
+		epp = (hwp_req_data >> 24) & 0xff;
+	else
+		/* When there is no EPP present, HWP uses EPB settings */
+		epp = intel_pstate_get_epb(cpu_data);
+
+	return epp;
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
@@ -576,6 +621,8 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 	for_each_cpu(cpu, cpumask) {
 		int max_perf_pct, min_perf_pct;
+		struct cpudata *cpu_data = all_cpu_data[cpu];
+		int epp;
 
 		if (per_cpu_limits)
 			perf_limits = all_cpu_data[cpu]->perf_limits;
@@ -604,6 +651,41 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
+		if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
+			epp = intel_pstate_get_epp(cpu_data, value);
+			if (epp)
+				cpu_data->epp_saved = epp;
+
+			/* If EPP read was failed, then don't try to write */
+			if (epp < 0)
+				goto skip_epp;
+
+			epp = 0;
+		} else {
+			/* skip setting EPP, when saved value is invalid */
+			if (cpu_data->epp_saved < 0)
+				goto skip_epp;
+
+			/*
+			 * No need to restore EPP when it is not zero. This
+			 * means:
+			 *  - Policy is not changed
+			 *  - user has manually changed
+			 *  - Error reading EPB
+			 */
+			epp = intel_pstate_get_epp(cpu_data, value);
+			if (epp)
+				goto skip_epp;
+			else
+				epp = cpu_data->epp_saved;
+		}
+		if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+			value &= ~GENMASK_ULL(31, 24);
+			value |= (u64)epp << 24;
+		} else {
+			intel_pstate_set_epb(cpu, epp);
+		}
+skip_epp:
 		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 	}
 }
-- 
2.7.4

