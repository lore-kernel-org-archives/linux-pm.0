From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 10/14] cpufreq: intel_pstate: Use different utilization update callbacks
Date: Sun, 12 Mar 2017 18:21:34 +0100
Message-ID: <2161373.4axtrAjXJ1@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52866 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934645AbdCLRcj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:39 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that some overhead in the utilization update callbacks
registered by intel_pstate in the active mode can be avoided if
those callbacks are tailored to specific configurations of the
driver.  For example, the utilization update callback for the HWP
enabled case only needs to update the average CPU performance
periodically whereas the utilization update callback for the
PID-based algorithm does not need to take IO-wait boosting into
account and so on.

With that in mind, define three utilization update callbacks for
three different use cases: HWP enabled, the CPU load "powersave"
P-state selection algorithm and the PID-based "powersave" P-state
selection algorithm and modify the driver initialization to
choose the callback matching its current configuration.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   77 ++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -37,6 +37,9 @@
 #include <asm/cpufeature.h>
 #include <asm/intel-family.h>
 
+#define INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
+#define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 * NSEC_PER_MSEC)
+
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
 
 #define ATOM_RATIOS		0x66a
@@ -1732,7 +1735,11 @@ static inline bool intel_pstate_sample(s
 	 * that sample.time will always be reset before setting the utilization
 	 * update hook and make the caller skip the sample then.
 	 */
-	return !!cpu->last_sample_time;
+	if (cpu->last_sample_time) {
+		intel_pstate_calc_avg_perf(cpu);
+		return true;
+	}
+	return false;
 }
 
 static inline int32_t get_avg_frequency(struct cpudata *cpu)
@@ -1839,7 +1846,7 @@ static void intel_pstate_update_pstate(s
 	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
 }
 
-static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
+static void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 {
 	int from, target_pstate;
 	struct sample *sample;
@@ -1867,36 +1874,56 @@ static inline void intel_pstate_adjust_b
 		fp_toint(cpu->iowait_boost * 100));
 }
 
+static void intel_pstate_update_util_hwp(struct update_util_data *data,
+					 u64 time, unsigned int flags)
+{
+	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
+	u64 delta_ns = time - cpu->sample.time;
+
+	if ((s64)delta_ns >= INTEL_PSTATE_HWP_SAMPLING_INTERVAL)
+		intel_pstate_sample(cpu, time);
+}
+
+static void intel_pstate_update_util_pid(struct update_util_data *data,
+					 u64 time, unsigned int flags)
+{
+	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
+	u64 delta_ns = time - cpu->sample.time;
+
+	if ((s64)delta_ns < pid_params.sample_rate_ns)
+		return;
+
+	if (intel_pstate_sample(cpu, time))
+		intel_pstate_adjust_busy_pstate(cpu);
+}
+
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 				     unsigned int flags)
 {
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns;
 
-	if (pstate_funcs.get_target_pstate == get_target_pstate_use_cpu_load) {
-		if (flags & SCHED_CPUFREQ_IOWAIT) {
-			cpu->iowait_boost = int_tofp(1);
-		} else if (cpu->iowait_boost) {
-			/* Clear iowait_boost if the CPU may have been idle. */
-			delta_ns = time - cpu->last_update;
-			if (delta_ns > TICK_NSEC)
-				cpu->iowait_boost = 0;
-		}
-		cpu->last_update = time;
+	if (flags & SCHED_CPUFREQ_IOWAIT) {
+		cpu->iowait_boost = int_tofp(1);
+	} else if (cpu->iowait_boost) {
+		/* Clear iowait_boost if the CPU may have been idle. */
+		delta_ns = time - cpu->last_update;
+		if (delta_ns > TICK_NSEC)
+			cpu->iowait_boost = 0;
 	}
-
+	cpu->last_update = time;
 	delta_ns = time - cpu->sample.time;
-	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
-		bool sample_taken = intel_pstate_sample(cpu, time);
+	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
+		return;
 
-		if (sample_taken) {
-			intel_pstate_calc_avg_perf(cpu);
-			if (!hwp_active)
-				intel_pstate_adjust_busy_pstate(cpu);
-		}
-	}
+	if (intel_pstate_sample(cpu, time))
+		intel_pstate_adjust_busy_pstate(cpu);
 }
 
+/* Utilization update callback to register in the active mode. */
+static void (*update_util_cb)(struct update_util_data *data, u64 time,
+			      unsigned int flags) = intel_pstate_update_util;
+
 #define ICPU(model, policy) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
 			(unsigned long)&policy }
@@ -2001,8 +2028,7 @@ static void intel_pstate_set_update_util
 
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
-	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
-				     intel_pstate_update_util);
+	cpufreq_add_update_util_hook(cpu_num, &cpu->update_util, update_util_cb);
 	cpu->update_util_set = true;
 }
 
@@ -2493,6 +2519,9 @@ static void __init copy_cpu_funcs(struct
 	pstate_funcs.get_target_pstate = funcs->get_target_pstate;
 
 	intel_pstate_use_acpi_profile();
+
+	if (pstate_funcs.get_target_pstate == get_target_pstate_use_performance)
+		update_util_cb = intel_pstate_update_util_pid;
 }
 
 #ifdef CONFIG_ACPI
@@ -2640,7 +2669,7 @@ static int __init intel_pstate_init(void
 		copy_cpu_funcs(&core_params.funcs);
 		hwp_active++;
 		intel_pstate.attr = hwp_cpufreq_attrs;
-		pid_params.sample_rate_ns = 50 * NSEC_PER_MSEC;
+		update_util_cb = intel_pstate_update_util_hwp;
 		goto hwp_cpu_matched;
 	}
 
