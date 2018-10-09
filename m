From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] cpufreq: intel_pstate: Add base_frequency attribute
Date: Tue,  9 Oct 2018 14:46:33 -0700
Message-ID: <20181009214633.16390-3-srinivas.pandruvada@linux.intel.com>
References: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com, viresh.kumar@linaro.org
Cc: pprakash@codeaurora.org, george.cherian@cavium.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, devel@acpica.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Present base_frequency to user space via cpufreq sysfs when HWP is in
use.

This HWP base frequency is read from HWP Capabilities MSR, if platform
doesn't have ACPI _CPC object. On most of the HWP platforms the _CPC
object will point to the HWP Capabilities MSR using address space id as
"Functional Fixed Hardware". But the address space id can be simply
ACPI_TYPE_INTEGER, where the platform firmware can modify this value
based on the system constraints.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b6a1aadaff9f..2a99e2fd9412 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -373,10 +373,28 @@ static void intel_pstate_set_itmt_prio(int cpu)
 		}
 	}
 }
+
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	struct cppc_perf_caps cppc_perf;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	return cppc_perf.guaranteed_perf;
+}
+
 #else
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 }
+
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
@@ -699,9 +717,29 @@ static ssize_t show_energy_performance_preference(
 
 cpufreq_freq_attr_rw(energy_performance_preference);
 
+static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
+{
+	struct cpudata *cpu;
+	u64 cap;
+	int ratio;
+
+	ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
+	if (ratio <= 0) {
+		rdmsrl_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
+		ratio = HWP_GUARANTEED_PERF(cap);
+	}
+
+	cpu = all_cpu_data[policy->cpu];
+
+	return sprintf(buf, "%d\n", ratio * cpu->pstate.scaling);
+}
+
+cpufreq_freq_attr_ro(base_frequency);
+
 static struct freq_attr *hwp_cpufreq_attrs[] = {
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
+	&base_frequency,
 	NULL,
 };
 
-- 
2.17.1
