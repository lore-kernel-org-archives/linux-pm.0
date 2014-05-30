From: dirk.brandewie@gmail.com
Subject: [PATCH] intel_pstate: Improve initial busy calculation
Date: Fri, 30 May 2014 10:10:57 -0700
Message-ID: <1401469857-4908-1-git-send-email-dirk.j.brandewie@intel.com>
References: <1917099.8KOhsjZWCp@vostro.rjw.lan>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35944 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbaE3RLI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 13:11:08 -0400
In-Reply-To: <1917099.8KOhsjZWCp@vostro.rjw.lan>
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
index 032efe4f7..c034cde 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -563,16 +563,19 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 static inline void intel_pstate_calc_busy(struct cpudata *cpu,
 					struct sample *sample)
 {
-	int32_t core_pct;
+	int64_t core_pct;
+	int32_t rem;
 
-	core_pct = div_fp(int_tofp((sample->aperf)),
-			int_tofp((sample->mperf)));
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

