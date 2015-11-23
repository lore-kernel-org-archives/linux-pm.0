From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH v1 2/5] cpufreq: intel_pstate: Rename current busy calculation function
Date: Mon, 23 Nov 2015 14:06:40 +0100
Message-ID: <1448284006-13596-6-git-send-email-philippe.longepe@linux.intel.com>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14848 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907AbbKWNGU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 08:06:20 -0500
In-Reply-To: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, Philippe Longepe <philippe.longepe@intel.com>

From: Philippe Longepe <philippe.longepe@intel.com>

The current busy calculation estimate idle time using experimented
3X idle period, not using delta mperf/ delta tsc. So rename this
function.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Philippe Longepe <philippe.longepe@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 423a12a..fa27ec5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -922,7 +922,7 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
 	mod_timer_pinned(&cpu->timer, jiffies + delay);
 }
 
-static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
+static inline int32_t intel_pstate_get_scaled_busy_estimate(struct cpudata *cpu)
 {
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
 	s64 duration_us;
@@ -974,7 +974,7 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 	from = cpu->pstate.current_pstate;
 
 	pid = &cpu->pid;
-	busy_scaled = intel_pstate_get_scaled_busy(cpu);
+	busy_scaled = intel_pstate_get_scaled_busy_estimate(cpu);
 
 	ctl = pid_calc(pid, busy_scaled);
 
-- 
1.9.1

