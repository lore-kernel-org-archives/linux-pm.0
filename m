From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] cpufreq: intel_pstate: Make HWP limits compatible with legacy
Date: Wed, 18 Jan 2017 10:48:24 -0800
Message-ID: <1484765305-185352-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1484765305-185352-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484765305-185352-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Under HWP the performance limits are calculated using max_perf_pct
and min_perf_pct using possible performance, not available performance.
The available performance can be reduced by no_turbo setting. To make
compatible with legacy mode, use max/min performance percentage with
respect to available performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a5f1a04..095bcaf 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -873,7 +873,10 @@ static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 
 		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
 		hw_min = HWP_LOWEST_PERF(cap);
-		hw_max = HWP_HIGHEST_PERF(cap);
+		if (limits->no_turbo)
+			hw_max = HWP_GUARANTEED_PERF(cap);
+		else
+			hw_max = HWP_HIGHEST_PERF(cap);
 		range = hw_max - hw_min;
 
 		max_perf_pct = perf_limits->max_perf_pct;
@@ -887,11 +890,6 @@ static void intel_pstate_hwp_set(struct cpufreq_policy *policy)
 
 		adj_range = max_perf_pct * range / 100;
 		max = hw_min + adj_range;
-		if (limits->no_turbo) {
-			hw_max = HWP_GUARANTEED_PERF(cap);
-			if (hw_max < max)
-				max = hw_max;
-		}
 
 		value &= ~HWP_MAX_PERF(~0L);
 		value |= HWP_MAX_PERF(max);
-- 
2.7.4
