From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: fix PCT_TO_HWP macro
Date: Wed,  9 Sep 2015 11:41:22 -0700
Message-ID: <1441824082-15403-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29975 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbbIISlY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 14:41:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

PCT_TO_HWP does not take the actual range of pstates exported
by HWP_CAPABILITIES in account, and is broken on most platforms.
Remove the macro and set the min and max pstate for hwp by
determining the range and adjusting by the min and max percent
limits values.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fcb929e..c4bf8d8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -260,24 +260,31 @@ static inline void update_turbo_state(void)
 		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
 }
 
-#define PCT_TO_HWP(x) (x * 255 / 100)
 static void intel_pstate_hwp_set(void)
 {
-	int min, max, cpu;
-	u64 value, freq;
+	int min, hw_min, max, hw_max, cpu, range, adj_range;
+	u64 value, cap;
+
+	rdmsrl(MSR_HWP_CAPABILITIES, cap);
+	hw_min = HWP_LOWEST_PERF(cap);
+	hw_max = HWP_HIGHEST_PERF(cap);
+	range = hw_max - hw_min;
 
 	get_online_cpus();
 
 	for_each_online_cpu(cpu) {
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
-		min = PCT_TO_HWP(limits.min_perf_pct);
+		adj_range = limits.min_perf_pct * range / 100;
+		min = hw_min + adj_range;
 		value &= ~HWP_MIN_PERF(~0L);
 		value |= HWP_MIN_PERF(min);
 
-		max = PCT_TO_HWP(limits.max_perf_pct);
+		adj_range = limits.max_perf_pct * range / 100;
+		max = hw_min + adj_range;
 		if (limits.no_turbo) {
-			rdmsrl( MSR_HWP_CAPABILITIES, freq);
-			max = HWP_GUARANTEED_PERF(freq);
+			hw_max = HWP_GUARANTEED_PERF(cap);
+			if (hw_max < max)
+				max = hw_max;
 		}
 
 		value &= ~HWP_MAX_PERF(~0L);
-- 
2.4.3

