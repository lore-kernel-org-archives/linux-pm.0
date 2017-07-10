From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix ratio setting for min_perf_pct
Date: Mon, 10 Jul 2017 16:23:52 -0700
Message-ID: <1499729032-22038-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754656AbdGJXYP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jul 2017 19:24:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When the minimum performance limit percentage is set to power-up default,
it is possible that minimum performance ratio is set to one more than the
desired.

During set_policy() callback the minimum ratio is calculated by applying
global.min_perf_pct to the turbo_ratio and rounding up. But the power-up
default global.min_perf_pct is already rounded up to next percent in the
function min_perf_pct_min(). So this will result in two round up
operations. So for the default min_perf_pct, one of the rounding up is
not required.

It is better to remove rounding up in min_perf_pct_min() as this matches
the displayed min_perf_pct prior to the
commit c5a2ee7dde89 ("cpufreq: intel_pstate: Active mode P-state limits
rework") in the kernel version 4,12. For example on a platform with
max turbo ratio of 37 and minimum ratio of 10, the min_perf_pct resulted
in 28 with the above commit. Before this commit it was 27 and same after
this change.

Fixes: 1a4fe38add8b ("cpufreq: intel_pstate: Remove max/min fractions to
limit performance")
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 48a98f11a84e..2a65bd313938 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -572,7 +572,7 @@ static int min_perf_pct_min(void)
 	int turbo_pstate = cpu->pstate.turbo_pstate;
 
 	return turbo_pstate ?
-		DIV_ROUND_UP(cpu->pstate.min_pstate * 100, turbo_pstate) : 0;
+		(cpu->pstate.min_pstate * 100 / turbo_pstate) : 0;
 }
 
 static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
-- 
2.11.0
