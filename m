From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V6 2/4] intel_pstate: Optimize calculation for max/min_perf_adj
Date: Tue,  8 Mar 2016 10:31:16 +0100
Message-ID: <1457429481-13283-5-git-send-email-philippe.longepe@linux.intel.com>
References: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43546 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbcCHJaS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 04:30:18 -0500
In-Reply-To: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org

mul_fp(int_tofp(A), B) expands to:
((A << FRAC_BITS) * B) >> FRAC_BITS, so the same result can be obtained
via simple multiplication A * B.  Apply this observation to
max_perf * limits->max_perf and max_perf * limits->min_perf in
intel_pstate_get_min_max()."

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 114e4e0..c46d23a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -828,11 +828,11 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
 	 * policy, or by cpu specific default values determined through
 	 * experimentation.
 	 */
-	max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf), limits->max_perf));
+	max_perf_adj = fp_toint(max_perf * limits->max_perf);
 	*max = clamp_t(int, max_perf_adj,
 			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
 
-	min_perf = fp_toint(mul_fp(int_tofp(max_perf), limits->min_perf));
+	min_perf = fp_toint(max_perf * limits->min_perf);
 	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
 }
 
-- 
1.9.1

