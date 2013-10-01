From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Intel Pstate driver: fix no turbo
Date: Tue,  1 Oct 2013 10:28:41 -0700
Message-ID: <1380648521-17849-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52363 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab3JAR3A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Oct 2013 13:29:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When sysfs for no_turbo is set, then also some p states in turbo regions
are observed. This patch will set IDA Engage bit when no_turbo is set to
explicitly disengage turbo.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9733f29..32b3479 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -394,7 +394,10 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 	trace_cpu_frequency(pstate * 100000, cpu->cpu);
 
 	cpu->pstate.current_pstate = pstate;
-	wrmsrl(MSR_IA32_PERF_CTL, pstate << 8);
+	if (limits.no_turbo)
+		wrmsrl(MSR_IA32_PERF_CTL, BIT(32) | (pstate << 8));
+	else
+		wrmsrl(MSR_IA32_PERF_CTL, pstate << 8);
 
 }
 
-- 
1.7.11.7

