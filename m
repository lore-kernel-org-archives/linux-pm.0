From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
Date: Tue, 22 Nov 2016 21:47:30 -0800
Message-ID: <1479880050-186251-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20821 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbcKWFrh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Nov 2016 00:47:37 -0500
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
v3:
	Restore EPP=0 when in set in powersave mode after switch from
	performance

Some test scnerios
1. Switch from powersave->performance->powersave
# cat scaling_governor 
powersave
# rdmsr 0x774
80001c05
# echo performance > scaling_governor
# rdmsr 0x774
1c1c
# echo powersave > scaling_governor
# rdmsr 0x774
80001c05

2. Switch from powersave->manually change EPP->performance->powersave
# wrmsr 0x774 0xc0001c05
# rdmsr 0x774
c0001c05
# echo performance > scaling_governor
# rdmsr 0x774
1c1c
# echo powersave > scaling_governor
# rdmsr 0x774
c0001c05

3. Switch from powersave->manually change EPP to 0->performance->powersave
# wrmsr 0x774 0x1c05
# rdmsr 0x774
1c05
# echo performance > scaling_governor
# rdmsr 0x774
1c1c
# echo powersave > scaling_governor
# rdmsr 0x774
1c05

4. Switch from performance->manually change EPP->powersave
# cat scaling_governor 
performance
# wrmsr 0x774 0x40001c05
# rdmsr 0x774
40001c05
# echo powersave > scaling_governor
# rdmsr 0x774
40001c05

5. Switch from powersave->performance->change max scaling freq->powersave
# cat scaling_governor 
powersave
# rdmsr 0x774
80001c05
# echo performance > scaling_governor
# rdmsr 0x774
1c1c
# echo 2000000 > scaling_max_freq
# echo powersave > scaling_governor
# rdmsr 0x774
80001c05

v2:
        Save EPP/EPB when policy is switched to performance and restore
        on entering powersave policy, when EPP/EPB is still 0.

 drivers/cpufreq/intel_pstate.c | 100 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 72e8bbc..acf2ef8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -243,6 +243,8 @@ struct perf_limits {
  *			when per cpu controls are enforced
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
+ * @epp_saved:		Last saved HWP energy performance preference
+ *			or energy performance bias and policy information
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
@@ -568,6 +571,52 @@ static inline void update_turbo_state(void)
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
+
+#define EPP_POLICY_SHIFT	4
+#define EPP_POLICY_MASK		0xff
+
 static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
@@ -576,6 +625,8 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 	for_each_cpu(cpu, cpumask) {
 		int max_perf_pct, min_perf_pct;
+		struct cpudata *cpu_data = all_cpu_data[cpu];
+		int epp;
 
 		if (per_cpu_limits)
 			perf_limits = all_cpu_data[cpu]->perf_limits;
@@ -604,6 +655,55 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
+		if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
+			epp = intel_pstate_get_epp(cpu_data, value);
+			/* If EPP read was failed, then don't try to write */
+			if (epp < 0) {
+				cpu_data->epp_saved = epp;
+				goto skip_epp;
+			}
+
+			/*
+			 * Don't store 0 to epp_saved, when there is no policy
+			 * switch, so that last powersave EPP can be restored.
+			 * The actual EPP is stored from the offset
+			 * EPP_POLICY_SHIFT.
+			 */
+			if ((cpu_data->epp_saved & EPP_POLICY_MASK) !=
+							cpu_data->policy)
+				cpu_data->epp_saved =
+						(epp << EPP_POLICY_SHIFT) |
+						cpu_data->policy;
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
+			if (epp) {
+				cpu_data->epp_saved = 0;
+				goto skip_epp;
+			}
+
+			epp = cpu_data->epp_saved >> EPP_POLICY_SHIFT;
+
+			cpu_data->epp_saved = 0;
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

