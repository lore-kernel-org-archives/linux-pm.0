From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Improve IO performance
Date: Thu, 27 Jul 2017 23:44:52 -0700
Message-ID: <1501224292-45740-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11393 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751655AbdG1GpU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 02:45:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

In the current implementation the latency from SCHED_CPUFREQ_IOWAIT is
set to actual P-state adjustment can be upto 10ms. This can be improved
by reacting to SCHED_CPUFREQ_IOWAIT faster in a milli second. With this
trivial change the IO performance improves significantly.

With a simple "grep -r . linux" (Here linux is kernel source folder) with
dropped caches every time on a platform with per core P-states
(Broadwell and Haswell Xeon ), the performance difference is significant.
The user and kernel time improvement is more than 20%.

The same performance difference was not observed on clients and on a
IvyTown server. which don't have per core P-state support.
So the performance gain may not be apparent on all systems.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
The idea of this patch is to test if it brings in any significant
improvement on real world use cases.

 drivers/cpufreq/intel_pstate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8c67b77..639979c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -38,6 +38,7 @@
 #include <asm/intel-family.h>
 
 #define INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
+#define INTEL_PSTATE_IO_WAIT_SAMPLING_INTERVAL	(NSEC_PER_MSEC)
 #define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
@@ -287,6 +288,7 @@ static struct pstate_funcs pstate_funcs __read_mostly;
 
 static int hwp_active __read_mostly;
 static bool per_cpu_limits __read_mostly;
+static int current_sample_interval = INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
@@ -1527,15 +1529,18 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
 		cpu->iowait_boost = int_tofp(1);
+		current_sample_interval = INTEL_PSTATE_IO_WAIT_SAMPLING_INTERVAL;
 	} else if (cpu->iowait_boost) {
 		/* Clear iowait_boost if the CPU may have been idle. */
 		delta_ns = time - cpu->last_update;
-		if (delta_ns > TICK_NSEC)
+		if (delta_ns > TICK_NSEC) {
 			cpu->iowait_boost = 0;
+			current_sample_interval = INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL;
+		}
 	}
 	cpu->last_update = time;
 	delta_ns = time - cpu->sample.time;
-	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
+	if ((s64)delta_ns < current_sample_interval)
 		return;
 
 	if (intel_pstate_sample(cpu, time)) {
-- 
2.7.4
