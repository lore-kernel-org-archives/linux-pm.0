From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 5/6] cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is set
Date: Mon,  4 May 2015 14:24:11 +0530
Message-ID: <1430729652-14813-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:55318 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbbEDJAf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 05:00:35 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Mon, 4 May 2015 19:00:32 +1000
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, preeti@linux.vnet.ibm.com, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

On a reset cycle of OCC, although the system retires from safe
frequency state the local pstate is not restored to Pmin or last
requested pstate. Now if the cpufreq governor initiates a pstate
change, the local pstate will be in Psafe and we will be reporting a
false positive when we are not throttled.

So in powernv_cpufreq_throttle_check() remove the condition which
checks if local pstate is less than Pmin while checking for Psafe
frequency. If the cpus are forced to Psafe then PMSR.psafe_mode_active
bit will be set. So, when OCCs become active this bit will be cleared.
Let us just rely on this bit for reporting throttling.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 9618813..0a59d5b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -39,7 +39,6 @@
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
-#define PMSR_LP(x)		((x >> 48) & 0xFF)
 #define OCC_RESET		0
 #define OCC_LOAD		1
 #define OCC_THROTTLE		2
@@ -316,7 +315,7 @@ static void powernv_cpufreq_throttle_check(void *data)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
-	int pmsr_pmax, pmsr_lp, i;
+	int pmsr_pmax, i;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
@@ -338,14 +337,9 @@ static void powernv_cpufreq_throttle_check(void *data)
 			chips[i].id, pmsr_pmax);
 	}
 
-	/*
-	 * Check for Psafe by reading LocalPstate
-	 * or check if Psafe_mode_active is set in PMSR.
-	 */
+	/* Check if Psafe_mode_active is set in PMSR. */
 next:
-	pmsr_lp = (s8)PMSR_LP(pmsr);
-	if ((pmsr_lp < powernv_pstate_info.min) ||
-				(pmsr & PMSR_PSAFE_ENABLE)) {
+	if (pmsr & PMSR_PSAFE_ENABLE) {
 		throttled = true;
 		pr_info("Pstate set to safe frequency\n");
 	}
-- 
1.9.3

