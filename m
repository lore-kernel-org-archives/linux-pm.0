From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: divide by zero on Knights Landing (KNL)
Date: Thu, 15 Oct 2015 11:32:48 -0700
Message-ID: <1444933968-5431-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34606 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855AbbJOSde (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 14:33:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This is a workaround for KNL platform, where in some cases MPERF counter
will not have updated value before next read of MSR_IA32_MPERF. In this
case divide by zero will occur. This change ignores current sample for
busy calculation in this case.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3af9dd7..d4126e1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -776,6 +776,9 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
 	local_irq_save(flags);
 	rdmsrl(MSR_IA32_APERF, aperf);
 	rdmsrl(MSR_IA32_MPERF, mperf);
+	if (cpu->prev_mperf == mperf)
+		return;
+
 	tsc = rdtsc();
 	local_irq_restore(flags);
 
-- 
1.9.3

