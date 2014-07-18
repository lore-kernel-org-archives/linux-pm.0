From: dirk.brandewie@gmail.com
Subject: [PATCH 09/17] cpufreq: intel_pstate: Keep values in aperf/mperf in full precision
Date: Fri, 18 Jul 2014 08:37:25 -0700
Message-ID: <1405697848-13546-10-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34211 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422813AbaGRPhx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:53 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so3725589pdi.6
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:52 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

Currently we shift right aperf and mperf variables by FRAC_BITS
to prevent overflow when we convert them to fix point numbers
(shift left by FRAC_BITS).

But this is not necessary, because we actually use delta aperf and mperf
which are much less than APERF and MPERF values.

So, use the unmodified APERF and MPERF values in calculation.
This also adds 8 bits in precision, although the gain is insignificant.
Also, use div64_u64 instead of div_u64 in calc_busy() to avoid
overflow of sample->mperf as divisor.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ff3c562..129ffb2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -584,9 +584,6 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
 	rdmsrl(MSR_IA32_MPERF, mperf);
 	local_irq_restore(flags);
 
-	aperf = aperf >> FRAC_BITS;
-	mperf = mperf >> FRAC_BITS;
-
 	cpu->last_sample_time = cpu->sample.time;
 	cpu->sample.time = ktime_get();
 	cpu->sample.aperf = aperf;
-- 
1.9.3

