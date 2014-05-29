From: dirk.brandewie@gmail.com
Subject: [PATCH 4/4] intel_pstate: Improve initial busy calculation
Date: Thu, 29 May 2014 09:32:25 -0700
Message-ID: <1401381145-17745-5-git-send-email-dirk.j.brandewie@intel.com>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37993 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568AbaE2Qcn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 May 2014 12:32:43 -0400
In-Reply-To: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dirk.brandewie@gmail.com, rjw@rjwysocki.net, dsmythies@telus.net, stable@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Doug Smythies <dsmythies@telus.net>

This change makes the busy calculation using 64 bit math which prevents
overflow for large values of aperf/mperf.

Cc: <stable@vger.kernel.org> # 3.14.x
Signed-off-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c4dad16..774d277 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -556,16 +556,19 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 
 static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 {
-	struct sample *sample = &cpu->sample;
-	int32_t core_pct;
+	int64_t core_pct;
+	int32_t rem;
 
-	core_pct = div_fp(int_tofp(sample->aperf), int_tofp(sample->mperf));
-	core_pct = mul_fp(core_pct, int_tofp(100));
+	core_pct = int_tofp(sample->aperf) * int_tofp(100);
+	core_pct = div_u64_rem(core_pct, int_tofp(sample->mperf), &rem);
+
+	if ((rem << 1) >= int_tofp((sample->mperf)))
+		core_pct += 1;
 
 	sample->freq = fp_toint(
 		mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
 
-	sample->core_pct_busy = core_pct;
+	sample->core_pct_busy = (int32_t)core_pct;
 }
 
 static inline void intel_pstate_sample(struct cpudata *cpu)
-- 
1.9.0

