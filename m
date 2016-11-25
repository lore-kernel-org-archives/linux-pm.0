From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
Date: Thu, 24 Nov 2016 16:07:10 -0800
Message-ID: <1480032430-63134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53009 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750698AbcKYAHO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Nov 2016 19:07:14 -0500
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
v4:
	While in performance mode user change EPP manually and for some
	reason set_policy() is called or changes max/min limits.
	the EPP shouldn't be reset to 0.
	Also removed masks to store policy and EPP together.

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
 drivers/cpufreq/intel_pstate.c | 106 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 72e8bbc..108ce9c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -243,6 +243,9 @@ struct perf_limits {
  *			when per cpu controls are enforced
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
+ * @epp_saved:		Last saved HWP energy performance preference
+ *			(EPP) or energy performance bias (EPB)
+ * @epp_policy:		Last saved policy used to set EPP/EPB
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -270,6 +273,8 @@ struct cpudata {
 	bool valid_pss_table;
 #endif
 	unsigned int iowait_boost;
+	s16 epp_saved;
+	s16 epp_policy;
 };
 
 static struct cpudata **all_cpu_data;
@@ -568,6 +573,48 @@ static inline void update_turbo_state(void)
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
 
+static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
+{
+	u64 epb;
+	int ret;
+
+	if (!static_cpu_has(X86_FEATURE_EPB))
+		return -ENXIO;
+
+	ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	if (ret)
+		return (s16)ret;
+
+	return (s16)(epb & 0x0f);
+}
+
+static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
+{
+	s16 epp;
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
+static void intel_pstate_set_epb(int cpu, s16 pref)
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
@@ -576,6 +623,8 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 	for_each_cpu(cpu, cpumask) {
 		int max_perf_pct, min_perf_pct;
+		struct cpudata *cpu_data = all_cpu_data[cpu];
+		s16 epp;
 
 		if (per_cpu_limits)
 			perf_limits = all_cpu_data[cpu]->perf_limits;
@@ -604,6 +653,48 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
+
+		if (cpu_data->epp_policy == cpu_data->policy)
+			goto skip_epp;
+
+		cpu_data->epp_policy = cpu_data->policy;
+
+		if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
+			epp = intel_pstate_get_epp(cpu_data, value);
+			/* If EPP read was failed, then don't try to write */
+			if (epp < 0) {
+				cpu_data->epp_saved = epp;
+				goto skip_epp;
+			}
+
+			cpu_data->epp_saved = epp;
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
+
+			epp = cpu_data->epp_saved;
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
@@ -616,6 +707,17 @@ static int intel_pstate_hwp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int intel_pstate_resume(struct cpufreq_policy *policy)
+{
+	if (!hwp_active)
+		return 0;
+
+	all_cpu_data[policy->cpu]->epp_policy = 0;
+	all_cpu_data[policy->cpu]->epp_saved = -EINVAL;
+
+	return intel_pstate_hwp_set_policy(policy);
+}
+
 static void intel_pstate_hwp_set_online_cpus(void)
 {
 	get_online_cpus();
@@ -866,6 +968,8 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
+	cpudata->epp_policy = 0;
+	cpudata->epp_saved = -EINVAL;
 }
 
 static int atom_get_min_pstate(void)
@@ -1740,7 +1844,7 @@ static struct cpufreq_driver intel_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_pstate_verify_policy,
 	.setpolicy	= intel_pstate_set_policy,
-	.resume		= intel_pstate_hwp_set_policy,
+	.resume		= intel_pstate_resume,
 	.get		= intel_pstate_get,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-- 
2.7.4

