From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] cpufreq: intel_pstate: Support of energy performance hint using HWP
Date: Thu,  1 Dec 2016 15:39:07 -0800
Message-ID: <1480635549-43518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:36786 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758631AbcLAXjN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Dec 2016 18:39:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

It is possible to provide hints to the HWP algorithms in the processor
to be more performance centric to more energy centric. These hints are
provided by using HWP energy performance preference (EPP) or energy
performance bias (EPB) settings.

The scope of these settings is per logical processor, which means that
each of the logical processors in the package can be programmed with a
different value.

This change provides cpufreq sysfs interface to provide hint. For each
policy, two additional attributes will be available to check and provide
hint. These attributes will only be present when the intel_pstate driver
is using HWP mode.

These attributes are:
- energy_performance_available_preferences
- energy_performance_preference

To get list of supported hints:
$ cat energy_performance_available_preferences
default performance balance_performance balance_power power

The current preference can be read or changed via cpufreq sysfs
attribute "energy_performance_preference". Reading from this attribute
will display current effective setting changed via any method. User can
write any of the valid preference string to this attribute. User can
always restore to power-on default by writing "default".

Implementation
Since these hints can be provided by direct MSR write or using some tools
like x86_energy_perf_policy, the driver internally doesn't maintain any
state. The user operation will result in direct read/write of MSR: 0x774
(HWP_REQUEST_MSR). Also driver use read modify write to update other
fields in this MSR.

Summary of changes:
- struct cpudata field epp_saved is renamed to epp_powersave, as this
stores the value to restore once policy is switched from performance
to powersave to restore original powersave EPP value.
- A new struct cpudata field epp_saved is used to store the raw MSR
EPP/EPB value when a CPU goes offline or on suspend and restore on
online/resume. This ensures that EPP value is restored to correct value
irrespective of the means used to set.
- EPP/EPB value ranges are fixed for each preference, which can be
set for the cpufreq sysfs, so user request is mapped to/from this
range.
- New attributes are only added when HWP is present.
- Since EPP value of 0 is valid the fields are initialized to
-EINVAL when not valid. The field epp_default is read only once after
powerup to avoid reading on subsequent CPU online operation
- New suspend callback to store epp on suspend operation
- Don't invalidate old epp_saved field on resume and online as now
we can restore last epp value on suspend and this field can still have
old EPP value sampled during switch to performance from powersave.
- While here optimized setting of cpu_data->epp_powersave = epp in
intel_pstate_hwp_set() as this was done in both true and false paths.
- epp/epb set function returns error to caller on failure to pass
on to user space for display.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 242 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 224 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c20da85..4fbe366f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -249,9 +249,14 @@ struct perf_limits {
  *			when per cpu controls are enforced
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
- * @epp_saved:		Last saved HWP energy performance preference
- *			(EPP) or energy performance bias (EPB)
+ * @epp_powersave:	Last saved HWP energy performance preference
+ *			(EPP) or energy performance bias (EPB),
+ *			when policy switched to performance
  * @epp_policy:		Last saved policy used to set EPP/EPB
+ * @epp_default:	Power on default HWP energy performance
+ *			preference/bias
+ * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
+ *			operation
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -279,8 +284,10 @@ struct cpudata {
 	bool valid_pss_table;
 #endif
 	unsigned int iowait_boost;
-	s16 epp_saved;
+	s16 epp_powersave;
 	s16 epp_policy;
+	s16 epp_default;
+	s16 epp_saved;
 };
 
 static struct cpudata **all_cpu_data;
@@ -598,29 +605,204 @@ static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
 {
 	s16 epp;
 
-	if (static_cpu_has(X86_FEATURE_HWP_EPP))
+	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+		/*
+		 * When hwp_req_data is 0, means that caller didn't read
+		 * MSR_HWP_REQUEST, so need to read and get EPP.
+		 */
+		if (!hwp_req_data) {
+			epp = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST,
+					    &hwp_req_data);
+			if (epp)
+				return epp;
+		}
 		epp = (hwp_req_data >> 24) & 0xff;
-	else
+	} else {
 		/* When there is no EPP present, HWP uses EPB settings */
 		epp = intel_pstate_get_epb(cpu_data);
+	}
 
 	return epp;
 }
 
-static void intel_pstate_set_epb(int cpu, s16 pref)
+static int intel_pstate_set_epb(int cpu, s16 pref)
 {
 	u64 epb;
+	int ret;
 
 	if (!static_cpu_has(X86_FEATURE_EPB))
-		return;
+		return -ENXIO;
 
-	if (rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb))
-		return;
+	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	if (ret)
+		return ret;
 
 	epb = (epb & ~0x0f) | pref;
 	wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
+
+	return 0;
 }
 
+/*
+ * EPP/EPB display strings corresponding to EPP index in the
+ * energy_perf_strings[]
+ *	index		String
+ *-------------------------------------
+ *	0		default
+ *	1		performance
+ *	2		balance_performance
+ *	3		balance_power
+ *	4		power
+ */
+static const char * const energy_perf_strings[] = {
+	"default",
+	"performance",
+	"balance_performance",
+	"balance_power",
+	"power",
+	NULL
+};
+
+static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data)
+{
+	s16 epp;
+	int index = -EINVAL;
+
+	epp = intel_pstate_get_epp(cpu_data, 0);
+	if (epp < 0)
+		return epp;
+
+	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+		/*
+		 * Range:
+		 *	0x00-0x3F	:	Performance
+		 *	0x40-0x7F	:	Balance performance
+		 *	0x80-0xBF	:	Balance power
+		 *	0xC0-0xFF	:	Power
+		 * The EPP is a 8 bit value, but our ranges restrict the
+		 * value which can be set. Here only using top two bits
+		 * effectively.
+		 */
+		index = (epp >> 6) + 1;
+	} else if (static_cpu_has(X86_FEATURE_EPB)) {
+		/*
+		 * Range:
+		 *	0x00-0x03	:	Performance
+		 *	0x04-0x07	:	Balance performance
+		 *	0x08-0x0B	:	Balance power
+		 *	0x0C-0x0F	:	Power
+		 * The EPB is a 4 bit value, but our ranges restrict the
+		 * value which can be set. Here only using top two bits
+		 * effectively.
+		 */
+		index = (epp >> 2) + 1;
+	}
+
+	return index;
+}
+
+static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
+					      int pref_index)
+{
+	int epp = -EINVAL;
+	int ret;
+
+	if (!pref_index)
+		epp = cpu_data->epp_default;
+
+	mutex_lock(&intel_pstate_limits_lock);
+
+	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+		u64 value;
+
+		ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &value);
+		if (ret)
+			goto return_pref;
+
+		value &= ~GENMASK_ULL(31, 24);
+
+		/*
+		 * If epp is not default, convert from index into
+		 * energy_perf_strings to epp value, by shifting 6
+		 * bits left to use only top two bits in epp.
+		 * The resultant epp need to shifted by 24 bits to
+		 * epp position in MSR_HWP_REQUEST.
+		 */
+		if (epp == -EINVAL)
+			epp = (pref_index - 1) << 6;
+
+		value |= (u64)epp << 24;
+		ret = wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
+	} else {
+		if (epp == -EINVAL)
+			epp = (pref_index - 1) << 2;
+		ret = intel_pstate_set_epb(cpu_data->cpu, epp);
+	}
+return_pref:
+	mutex_unlock(&intel_pstate_limits_lock);
+
+	return ret;
+}
+
+static ssize_t show_energy_performance_available_preferences(
+				struct cpufreq_policy *policy, char *buf)
+{
+	int i = 0;
+	int ret = 0;
+
+	while (energy_perf_strings[i] != NULL)
+		ret += sprintf(&buf[ret], "%s ", energy_perf_strings[i++]);
+
+	ret += sprintf(&buf[ret], "\n");
+
+	return ret;
+}
+
+cpufreq_freq_attr_ro(energy_performance_available_preferences);
+
+static ssize_t store_energy_performance_preference(
+		struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
+	char str_preference[21];
+	int ret, i = 0;
+
+	ret = sscanf(buf, "%20s", str_preference);
+	if (ret != 1)
+		return -EINVAL;
+
+	while (energy_perf_strings[i] != NULL) {
+		if (!strcmp(str_preference, energy_perf_strings[i])) {
+			intel_pstate_set_energy_pref_index(cpu_data, i);
+			return count;
+		}
+		++i;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t show_energy_performance_preference(
+				struct cpufreq_policy *policy, char *buf)
+{
+	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
+	int preference;
+
+	preference = intel_pstate_get_energy_pref_index(cpu_data);
+	if (preference < 0)
+		return preference;
+
+	return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
+}
+
+cpufreq_freq_attr_rw(energy_performance_preference);
+
+static struct freq_attr *hwp_cpufreq_attrs[] = {
+	&energy_performance_preference,
+	&energy_performance_available_preferences,
+	NULL,
+};
+
 static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 {
 	int min, hw_min, max, hw_max, cpu, range, adj_range;
@@ -665,20 +847,24 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 		cpu_data->epp_policy = cpu_data->policy;
 
+		if (cpu_data->epp_saved >= 0) {
+			epp = cpu_data->epp_saved;
+			cpu_data->epp_saved = -EINVAL;
+			goto update_epp;
+		}
+
 		if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
 			epp = intel_pstate_get_epp(cpu_data, value);
+			cpu_data->epp_powersave = epp;
 			/* If EPP read was failed, then don't try to write */
-			if (epp < 0) {
-				cpu_data->epp_saved = epp;
+			if (epp < 0)
 				goto skip_epp;
-			}
 
-			cpu_data->epp_saved = epp;
 
 			epp = 0;
 		} else {
 			/* skip setting EPP, when saved value is invalid */
-			if (cpu_data->epp_saved < 0)
+			if (cpu_data->epp_powersave < 0)
 				goto skip_epp;
 
 			/*
@@ -692,8 +878,9 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 			if (epp)
 				goto skip_epp;
 
-			epp = cpu_data->epp_saved;
+			epp = cpu_data->epp_powersave;
 		}
+update_epp:
 		if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
 			value &= ~GENMASK_ULL(31, 24);
 			value |= (u64)epp << 24;
@@ -713,13 +900,24 @@ static int intel_pstate_hwp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
+
+	if (!hwp_active)
+		return 0;
+
+	cpu_data->epp_saved = intel_pstate_get_epp(cpu_data, 0);
+
+	return 0;
+}
+
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
 	if (!hwp_active)
 		return 0;
 
 	all_cpu_data[policy->cpu]->epp_policy = 0;
-	all_cpu_data[policy->cpu]->epp_saved = -EINVAL;
 
 	return intel_pstate_hwp_set_policy(policy);
 }
@@ -975,7 +1173,8 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 	cpudata->epp_policy = 0;
-	cpudata->epp_saved = -EINVAL;
+	if (cpudata->epp_default == -EINVAL)
+		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 }
 
 static int atom_get_min_pstate(void)
@@ -1607,6 +1806,9 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		if (per_cpu_limits)
 			cpu->perf_limits = (struct perf_limits *)(cpu + 1);
 
+		cpu->epp_default = -EINVAL;
+		cpu->epp_powersave = -EINVAL;
+		cpu->epp_saved = -EINVAL;
 	}
 
 	cpu = all_cpu_data[cpunum];
@@ -1801,7 +2003,9 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 	pr_debug("CPU %d exiting\n", policy->cpu);
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
-	if (!hwp_active)
+	if (hwp_active)
+		intel_pstate_hwp_save_state(policy);
+	else
 		intel_cpufreq_stop_cpu(policy);
 }
 
@@ -1871,6 +2075,7 @@ static struct cpufreq_driver intel_pstate = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_pstate_verify_policy,
 	.setpolicy	= intel_pstate_set_policy,
+	.suspend	= intel_pstate_hwp_save_state,
 	.resume		= intel_pstate_resume,
 	.get		= intel_pstate_get,
 	.init		= intel_pstate_cpu_init,
@@ -2188,6 +2393,7 @@ static int __init intel_pstate_init(void)
 	if (x86_match_cpu(hwp_support_ids) && !no_hwp) {
 		copy_cpu_funcs(&core_params.funcs);
 		hwp_active++;
+		intel_pstate.attr = hwp_cpufreq_attrs;
 		goto hwp_cpu_matched;
 	}
 
-- 
2.7.4

