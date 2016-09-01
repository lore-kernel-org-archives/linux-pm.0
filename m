From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 8/8] cpufreq: intel_pstate: Use CPPC to get max performance
Date: Thu,  1 Sep 2016 13:33:44 -0700
Message-ID: <1472762024-88771-9-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This change uses acpi cppc_lib interface to get CPPC performance limits.
Once CPPC limits of all online cores are read, first check if there is
difference in max performance. If there is a difference, then the
scheduler interface is called to update per cpu priority. After updating
priority of all current cpus, the itmt feature is enabled.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/Kconfig.x86    |  1 +
 drivers/cpufreq/intel_pstate.c | 75 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index adbd1de..3328c6b 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -6,6 +6,7 @@ config X86_INTEL_PSTATE
        bool "Intel P state control"
        depends on X86
        select ACPI_PROCESSOR if ACPI
+       select ACPI_CPPC_LIB if X86_64 && ACPI
        help
           This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bdbe936..a0bf244 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -44,6 +44,7 @@
 
 #ifdef CONFIG_ACPI
 #include <acpi/processor.h>
+#include <acpi/cppc_acpi.h>
 #endif
 
 #define FRAC_BITS 8
@@ -193,6 +194,8 @@ struct _pid {
  * @sample:		Storage for storing last Sample data
  * @acpi_perf_data:	Stores ACPI perf information read from _PSS
  * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
+ * @cppc_data:		Stores CPPC information for HWP capable CPUs
+ * @valid_cppc_table:	Set to true for valid CPPC entries are found
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -215,6 +218,8 @@ struct cpudata {
 #ifdef CONFIG_ACPI
 	struct acpi_processor_performance acpi_perf_data;
 	bool valid_pss_table;
+	struct cppc_cpudata *cppc_data;
+	bool valid_cppc_table;
 #endif
 };
 
@@ -361,6 +366,15 @@ static struct perf_limits *limits = &powersave_limits;
 #endif
 
 #ifdef CONFIG_ACPI
+static cpumask_t cppc_rd_cpu_mask;
+
+/* Call set_sched_itmt from a work function to be able to use hotplug locks */
+static void intel_pstste_sched_itmt_work_fn(struct work_struct *work)
+{
+	set_sched_itmt(true);
+}
+
+static DECLARE_WORK(sched_itmt_work, intel_pstste_sched_itmt_work_fn);
 
 static bool intel_pstate_get_ppc_enable_status(void)
 {
@@ -377,14 +391,63 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 	int ret;
 	int i;
 
-	if (hwp_active)
+	cpu = all_cpu_data[policy->cpu];
+
+	if (hwp_active) {
+		struct cppc_perf_caps *perf_caps;
+
+		cpu->cppc_data = kzalloc(sizeof(struct cppc_cpudata),
+					 GFP_KERNEL);
+		if (!cpu->cppc_data)
+			return;
+
+		perf_caps = &cpu->cppc_data->perf_caps;
+		ret = cppc_get_perf_caps(policy->cpu, perf_caps);
+		if (ret) {
+			kfree(cpu->cppc_data);
+			return;
+		}
+
+		cpu->valid_cppc_table = true;
+		pr_debug("cpu:%d H:0x%x N:0x%x L:0x%x\n", policy->cpu,
+			 perf_caps->highest_perf, perf_caps->nominal_perf,
+			 perf_caps->lowest_perf);
+
+		cpumask_set_cpu(policy->cpu, &cppc_rd_cpu_mask);
+		if (cpumask_subset(topology_core_cpumask(policy->cpu),
+				   &cppc_rd_cpu_mask)) {
+			int cpu_index;
+			int max_prio;
+			bool itmt_support = false;
+
+			cpu = all_cpu_data[0];
+			max_prio = cpu->cppc_data->perf_caps.highest_perf;
+			for_each_cpu(cpu_index, &cppc_rd_cpu_mask) {
+				cpu = all_cpu_data[cpu_index];
+				perf_caps = &cpu->cppc_data->perf_caps;
+				if (max_prio != perf_caps->highest_perf) {
+					itmt_support = true;
+					break;
+				}
+			}
+
+			if (!itmt_support)
+				return;
+
+			for_each_cpu(cpu_index, &cppc_rd_cpu_mask) {
+				cpu = all_cpu_data[cpu_index];
+				perf_caps = &cpu->cppc_data->perf_caps;
+				sched_set_itmt_core_prio(
+					perf_caps->highest_perf, cpu_index);
+			}
+			schedule_work(&sched_itmt_work);
+		}
 		return;
+	}
 
 	if (!intel_pstate_get_ppc_enable_status())
 		return;
 
-	cpu = all_cpu_data[policy->cpu];
-
 	ret = acpi_processor_register_performance(&cpu->acpi_perf_data,
 						  policy->cpu);
 	if (ret)
@@ -444,6 +507,12 @@ static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 	struct cpudata *cpu;
 
 	cpu = all_cpu_data[policy->cpu];
+
+	if (cpu->valid_cppc_table) {
+		cpumask_clear_cpu(policy->cpu, &cppc_rd_cpu_mask);
+		kfree(cpu->cppc_data);
+	}
+
 	if (!cpu->valid_pss_table)
 		return;
 
-- 
2.7.4

