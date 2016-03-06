From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V5 2/4] Optimize calculation for max/min_perf_adj
Date: Sun,  6 Mar 2016 08:34:04 +0100
Message-ID: <1457249646-23072-3-git-send-email-philippe.longepe@linux.intel.com>
References: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46499 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbcCFHdB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 6 Mar 2016 02:33:01 -0500
In-Reply-To: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
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

