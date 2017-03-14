From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Correct frequency setting in the HWP mode
Date: Mon, 13 Mar 2017 18:30:12 -0700
Message-ID: <1489455012-21948-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56717 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751769AbdCNBaV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Mar 2017 21:30:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

In the functions intel_pstate_hwp_set(), min/max range from HWP capability
MSR along with max_perf_pct and min_perf_pct, is used to set the HWP
request MSR. In some cases this doesn't result in the correct HWP max/min
in HWP request.

For example: In the following case:

HWP capabilities from MSR 0x771
0x70a1220

Here cpufreq min/max frequencies from above MSR dump are 700MHz and 3.2GHz
respectively.

This will result in
hwp_min = 0x07
hwp_max = 0x20

To limit max frequency to 2GHz:

perf_limits->max_perf_pct = 63 (2GHz as a percent of 3.2GHz rounded up)

With the current calculation:
adj_range = max_perf_pct * range / 100;
adj_range = 63 * (32 - 7) / 100
adj_range = 15

max = hw_min + adj_range;
max = 7 + 15 = 22

This will result in HWP request of 0x160f, which will result in a
frequency cap of 2.2GHz not 2GHz.

The problem with the above calculation is that hwp_min of 7 is treated
as 0% in the range. But max_perf_pct is calculated with respect to minimum
as 0 and max as 3.2GHz or hwp_max, so adding hwp_min to it will result in
more than the desired.

Since the min_perf_pct and max_perf_pct is already a percent of max
frequency or hwp_max, this min/max HWP request value can be calculated
directly applying these percentage to hwp_max.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3d37219..118a1f8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -845,7 +845,7 @@ static struct freq_attr *hwp_cpufreq_attrs[] = {
 
 static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 {
-	int min, hw_min, max, hw_max, cpu, range, adj_range;
+	int min, hw_min, max, hw_max, cpu;
 	struct perf_limits *perf_limits = limits;
 	u64 value, cap;
 
@@ -863,20 +863,17 @@ static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 			hw_max = HWP_GUARANTEED_PERF(cap);
 		else
 			hw_max = HWP_HIGHEST_PERF(cap);
-		range = hw_max - hw_min;
 
 		max_perf_pct = perf_limits->max_perf_pct;
 		min_perf_pct = perf_limits->min_perf_pct;
+		min = hw_max * min_perf_pct / 100;
 
 		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
-		adj_range = min_perf_pct * range / 100;
-		min = hw_min + adj_range;
+
 		value &= ~HWP_MIN_PERF(~0L);
 		value |= HWP_MIN_PERF(min);
 
-		adj_range = max_perf_pct * range / 100;
-		max = hw_min + adj_range;
-
+		max = hw_max * max_perf_pct / 100;
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
 
-- 
2.7.4
