From: dirk.brandewie@gmail.com
Subject: [PATCH 10/11] cpufreq: intel_pstate: Remove core_pct rounding
Date: Fri, 18 Jul 2014 08:37:27 -0700
Message-ID: <1405697848-13546-12-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60502 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422813AbaGRPh4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:56 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so5647526pad.35
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:55 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

The specific rounding adds conditionally only 1/256 to fractional
part of core_pct.

We can safely remove it without any noticeable impact in
calculations.

Use div64_u64 instead of div_u64 to avoid possible overflow of
sample->mperf as divisor

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 33a09da..dc6e6bf 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -545,13 +545,9 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
 	int64_t core_pct;
-	int32_t rem;
 
 	core_pct = int_tofp(sample->aperf) * int_tofp(100);
-	core_pct = div_u64_rem(core_pct, int_tofp(sample->mperf), &rem);
-
-	if ((rem << 1) >= int_tofp(sample->mperf))
-		core_pct += 1;
+	core_pct = div64_u64(core_pct, int_tofp(sample->mperf));
 
 	sample->freq = fp_toint(
 		mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
-- 
1.9.3

