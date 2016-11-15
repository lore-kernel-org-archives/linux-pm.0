From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH] cpufreq: intel_pstate: Support of energy performance hint using HWP
Date: Tue, 15 Nov 2016 14:59:43 -0800
Message-ID: <1479250783-74336-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1479250783-74336-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479250783-74336-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, morten.rasmussen@arm.com, Juri.Lelli@arm.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

It is possible to provide hints to the HWP algorithms in the processor
to be more performance centric to more energy centric.

The scope of these settings is per logical processor, which means that
each of the logical processors in the package can be programmed with a
different value. One of the use case as described in the Intel SDM
(Intel IA 64 and IA-32 Architecture Software Developer's manual) is
under virtualization scenarios, where the performance/energy
requirements of one logical processor may differ from the other.

There are multiple methods to provide this hint:
- Use direct read/write of IA32_HWP_REQUEST/IA32_ENERGY_PERF_BIAS MSRs
- Via x86_energy_perf_policy utility
- Via cpufreq sysfs method implemented with this change

While first two methods provide more granularity, user should make sure
that they are updated after cpu offline/online, suspend/resume or changing
HWP performance limits.

Available EPP settings via cpufreq sysfs attribute
"energy_performance_available_preferences":

default
performance
balance_performance
balance_power
power

The current preference can be read or changed via cpufreq sysfs
attribute "energy_performance_preference". Reading from this attribute
will display current effective setting changed via any method. User can
write any of the valid preference string to this attribute.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 194 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index febf1de..a5ffe3a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -241,6 +241,9 @@ struct perf_limits {
  *			when per cpu controls are enforced
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
+ * @energy_perf_pref:	Current HWP energy performance preference/bias
+ * @energy_perf_pref_default: Power on default HWP energy performance
+ *			preference/bias
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -268,6 +271,8 @@ struct cpudata {
 	bool valid_pss_table;
 #endif
 	unsigned int iowait_boost;
+	u64 energy_perf_pref;
+	u64 energy_perf_pref_default;
 };
 
 static struct cpudata **all_cpu_data;
@@ -568,6 +573,123 @@ static inline void update_turbo_state(void)
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
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
+	int index = -EINVAL;
+
+	if (cpu_data->energy_perf_pref_default == cpu_data->energy_perf_pref)
+		return 0; /* Default: no change from power on value */
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
+		index = (cpu_data->energy_perf_pref >> 6) + 1;
+	} else if (static_cpu_has(X86_FEATURE_EPB)) {
+		/*
+		 * Range:
+		 *	0-3 :	Performance
+		 *	4-7 :	Balance performance
+		 *	8-11:	Balance power
+		 *	12-15:	Power
+		 * The EPB is a 4 bit value, but our ranges restrict the
+		 * value which can be set. Here only using top two bits
+		 * effectively.
+		 */
+		index = (cpu_data->energy_perf_pref >> 2) + 1;
+	}
+
+	return index;
+}
+
+static void intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
+					      int index)
+{
+	if (!index)
+		cpu_data->energy_perf_pref =
+			cpu_data->energy_perf_pref_default;
+	else if (static_cpu_has(X86_FEATURE_HWP_EPP))
+		cpu_data->energy_perf_pref = (index - 1) << 6;
+	else if (static_cpu_has(X86_FEATURE_EPB))
+		cpu_data->energy_perf_pref = (index - 1) << 2;
+}
+
+static void intel_pstate_update_epb(struct cpudata *cpu_data)
+{
+	u64 epb;
+	int ret;
+
+	if (!static_cpu_has(X86_FEATURE_EPB))
+		return;
+
+	ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	if (ret)
+		return;
+
+	cpu_data->energy_perf_pref = epb & 0x0f;
+}
+
+static void intel_pstate_update_epp(struct cpudata *cpu_data)
+{
+	if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+		u64 epp;
+		int ret;
+
+		ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, &epp);
+		if (ret)
+			return;
+
+		cpu_data->energy_perf_pref = (epp >> 24) & 0xff;
+	} else {
+		/* When there is no EPP present, HWP uses EPB settings */
+		intel_pstate_update_epb(cpu_data);
+	}
+
+	if (!cpu_data->energy_perf_pref_default)
+		cpu_data->energy_perf_pref_default = cpu_data->energy_perf_pref;
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
@@ -604,6 +726,15 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
 
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
+
+		if (static_cpu_has(X86_FEATURE_HWP_EPP)) {
+			value &= ~0xff000000;
+			value |= all_cpu_data[cpu]->energy_perf_pref << 24;
+		} else {
+			intel_pstate_set_epb(cpu,
+					all_cpu_data[cpu]->energy_perf_pref);
+		}
+
 		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 	}
 }
@@ -879,6 +1010,7 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
+	intel_pstate_update_epp(cpudata);
 }
 
 static int atom_get_min_pstate(void)
@@ -1749,6 +1881,67 @@ static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
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
+			intel_pstate_hwp_set(policy->cpus);
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
+	intel_pstate_update_epp(cpu_data);
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
 static struct cpufreq_driver intel_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_pstate_verify_policy,
@@ -1955,6 +2148,7 @@ static int __init intel_pstate_init(void)
 	if (x86_match_cpu(hwp_support_ids) && !no_hwp) {
 		copy_cpu_funcs(&core_params.funcs);
 		hwp_active++;
+		intel_pstate_driver.attr = hwp_cpufreq_attrs;
 		goto hwp_cpu_matched;
 	}
 
-- 
2.7.4
