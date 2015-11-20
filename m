From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/2] cpufreq, intel_pstate, fix limits->max_perf rounding error
Date: Fri, 20 Nov 2015 07:32:37 -0500
Message-ID: <1448022757-7856-3-git-send-email-prarit@redhat.com>
References: <1448022757-7856-1-git-send-email-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448022757-7856-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

A rounding error was found in the calculation of limits->max_perf
in intel_pstate_set_policy(), which is used to calculate the max and min
pstate values in intel_pstate_get_min_max().  In that code,
limits->max_perf is truncated to 2 hex digits such that, for example,
0x169 was incorrectly calculated to 0x16 instead of 0x17.  This resulted in
the pstate being set one level too low.  This patch rounds the value of
limits->max_perf up instead of down so that the correct max pstate can
be reached.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Alexandra Yates <alexandra.yates@intel.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6b63374..8b8e331 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1122,6 +1122,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 				   limits->max_sysfs_pct);
 	limits->max_perf_pct = max(limits->min_policy_pct,
 				   limits->max_perf_pct);
+	limits->max_perf = round_up(limits->max_perf, 8);
 
 	/* Make sure min_perf_pct <= max_perf_pct */
 	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
-- 
1.8.3.1
