From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Improve IO performance
Date: Tue,  1 Aug 2017 20:45:06 -0700
Message-ID: <1501645506-29398-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:6510 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbdHBDp2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Aug 2017 23:45:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

In the current implementation the latency from SCHED_CPUFREQ_IOWAIT is
set to actual P-state adjustment can be upto 10ms. This can be improved
by reacting to SCHED_CPUFREQ_IOWAIT by jumping to max P-state immediately
. With this change the IO performance improves significantly.

With a simple "grep -r . linux" (Here linux is kernel source folder) with
dropped caches every time on a platform with per core P-states on a
Broadwell Xeon workstation, the user and system time improves as much as
30% to 40%.

The same performance difference was not observed on clients, which don't
have per core P-state support.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8c67b77..7762255 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1527,6 +1527,15 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
 		cpu->iowait_boost = int_tofp(1);
+		/*
+		 * The last time the busy was 100% so P-state was max anyway
+		 * so avoid overhead of computation.
+		 */
+		if (fp_toint(cpu->sample.busy_scaled) == 100) {
+			cpu->last_update = time;
+			return;
+		}
+		goto set_pstate;
 	} else if (cpu->iowait_boost) {
 		/* Clear iowait_boost if the CPU may have been idle. */
 		delta_ns = time - cpu->last_update;
@@ -1538,6 +1547,7 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 	if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
 		return;
 
+set_pstate:
 	if (intel_pstate_sample(cpu, time)) {
 		int target_pstate;
 
-- 
2.7.4
