From: dirk.brandewie@gmail.com
Subject: [PATCH 08/11] cpufreq: intel_pstate: Disable interrupts during MSRs reading
Date: Fri, 18 Jul 2014 08:37:24 -0700
Message-ID: <1405697848-13546-9-git-send-email-dirk.j.brandewie@intel.com>
References: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52275 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422773AbaGRPhv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 11:37:51 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so5589987pad.7
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 08:37:51 -0700 (PDT)
In-Reply-To: <1405697848-13546-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Stratos Karafotis <stratosk@semaphore.gr>

According to Intel 64 and IA-32 Architectures SDM, Volume 3,
Chapter 14.2, "Software needs to exercise care to avoid delays
between the two RDMSRs (for example interrupts)".

So, disable interrupts during reading MSRs IA32_APERF and IA32_MPERF.
This should increase the accuracy of the calculations.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9d75bd6..ff3c562 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -577,9 +577,12 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
 static inline void intel_pstate_sample(struct cpudata *cpu)
 {
 	u64 aperf, mperf;
+	unsigned long flags;
 
+	local_irq_save(flags);
 	rdmsrl(MSR_IA32_APERF, aperf);
 	rdmsrl(MSR_IA32_MPERF, mperf);
+	local_irq_restore(flags);
 
 	aperf = aperf >> FRAC_BITS;
 	mperf = mperf >> FRAC_BITS;
-- 
1.9.3

