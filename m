From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v8 8/8] cpufreq: intel_pstate: Use CPPC to get max performance
Date: Tue, 22 Nov 2016 12:24:00 -0800
Message-ID: <0998b98943bcdec7d1ddd4ff27358da555ea8e92.1479844244.git.tim.c.chen@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479844244.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1479844244.git.tim.c.chen@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

This change uses acpi cppc_lib interface to get CPPC performance limits
and calls scheduler interface to update per cpu highest priority. If
there is a difference in highest performance of each CPUs, call scheduler
interface to enable ITMT feature for only one time.

Here sched_set_itmt_core_prio() is called to set priorities and
sched_set_itmt_support() is called to enable ITMT feature.

Co-developed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 drivers/cpufreq/Kconfig.x86    |  1 +
 drivers/cpufreq/intel_pstate.c | 56 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index adbd1de..c6d273b 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -6,6 +6,7 @@ config X86_INTEL_PSTATE
        bool "Intel P state control"
        depends on X86
        select ACPI_PROCESSOR if ACPI
+       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_ITMT
        help
           This driver provides a P state for Intel core processors.
 	  The driver implements an internal governor and will become
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4737520..e8dc42f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -44,6 +44,7 @@
 
 #ifdef CONFIG_ACPI
 #include <acpi/processor.h>
+#include <acpi/cppc_acpi.h>
 #endif
 
 #define FRAC_BITS 8
@@ -379,14 +380,67 @@ static bool intel_pstate_get_ppc_enable_status(void)
 	return acpi_ppc;
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+
+/* The work item is needed to avoid CPU hotplug locking issues */
+static void intel_pstste_sched_itmt_work_fn(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+
+static DECLARE_WORK(sched_itmt_work, intel_pstste_sched_itmt_work_fn);
+
+static void intel_pstate_set_itmt_prio(int cpu)
+{
+	struct cppc_perf_caps cppc_perf;
+	static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpu, &cppc_perf);
+	if (ret)
+		return;
+
+	/*
+	 * The priorities can be set regardless of whether or not
+	 * sched_set_itmt_support(true) has been called and it is valid to
+	 * update them at any time after it has been called.
+	 */
+	sched_set_itmt_core_prio(cppc_perf.highest_perf, cpu);
+
+	if (max_highest_perf <= min_highest_perf) {
+		if (cppc_perf.highest_perf > max_highest_perf)
+			max_highest_perf = cppc_perf.highest_perf;
+
+		if (cppc_perf.highest_perf < min_highest_perf)
+			min_highest_perf = cppc_perf.highest_perf;
+
+		if (max_highest_perf > min_highest_perf) {
+			/*
+			 * This code can be run during CPU online under the
+			 * CPU hotplug locks, so sched_set_itmt_support()
+			 * cannot be called from here.  Queue up a work item
+			 * to invoke it.
+			 */
+			schedule_work(&sched_itmt_work);
+		}
+	}
+}
+#else
+static void intel_pstate_set_itmt_prio(int cpu)
+{
+}
+#endif
+
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
 	int ret;
 	int i;
 
-	if (hwp_active)
+	if (hwp_active) {
+		intel_pstate_set_itmt_prio(policy->cpu);
 		return;
+	}
 
 	if (!intel_pstate_get_ppc_enable_status())
 		return;
-- 
2.5.5
