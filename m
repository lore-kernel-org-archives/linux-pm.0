From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: divide by zero on Knights Landing (KNL)
Date: Fri, 23 Oct 2015 11:34:05 -0700
Message-ID: <1445625245-7768-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8376 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbbJWSfF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Oct 2015 14:35:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 8e601a9f97a00bab031980de34f9a81891c1f82f ("cpufreq: intel_pstate:
Fix divide by zero on Knights Landing (KNL)") from mainline kernel
Backport to 4.1-stable tree

This is a workaround for KNL platform, where in some cases MPERF counter
will not have updated value before next read of MSR_IA32_MPERF. In this
case divide by zero will occur. This change ignores current sample for
busy calculation in this case.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e8d1699..1ee2ab5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -761,6 +761,11 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
 	local_irq_save(flags);
 	rdmsrl(MSR_IA32_APERF, aperf);
 	rdmsrl(MSR_IA32_MPERF, mperf);
+	if (cpu->prev_mperf == mperf) {
+		local_irq_restore(flags);
+		return;
+	}
+
 	local_irq_restore(flags);
 
 	cpu->last_sample_time = cpu->sample.time;
-- 
1.9.3

