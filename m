From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 7/9] intel_idle: remove superfluous dev->state_count
 initialization
Date: Tue, 20 Aug 2013 16:23:45 +0200
Message-ID: <1377008627-32691-8-git-send-email-b.zolnierkie@samsung.com>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59189 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab3HTO01 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:26:27 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU000D32RPTMI0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:26:26 +0900 (KST)
In-reply-to: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Len Brown <lenb@kernel.org>

intel_idle driver sets dev->state_count to drv->state_count so
the default dev->state_count initialization in cpuidle_enable_device()
(called from cpuidle_register_device()) can be used instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3d0e11f..012a28a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -617,39 +617,10 @@ static int intel_idle_cpuidle_driver_init(void)
  */
 static int intel_idle_cpu_init(int cpu)
 {
-	int cstate;
 	struct cpuidle_device *dev;
 
 	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
 
-	dev->state_count = 1;
-
-	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
-		int num_substates, mwait_hint, mwait_cstate, mwait_substate;
-
-		if (cpuidle_state_table[cstate].enter == NULL)
-			continue;
-
-		if (cstate + 1 > max_cstate) {
-			printk(PREFIX "max_cstate %d reached\n", max_cstate);
-			break;
-		}
-
-		mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
-		mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint);
-		mwait_substate = MWAIT_HINT2SUBSTATE(mwait_hint);
-
-		/* does the state exist in CPUID.MWAIT? */
-		num_substates = (mwait_substates >> ((mwait_cstate + 1) * 4))
-					& MWAIT_SUBSTATE_MASK;
-
-		/* if sub-state in table is not enumerated by CPUID */
-		if ((mwait_substate + 1) > num_substates)
-			continue;
-
-		dev->state_count += 1;
-	}
-
 	dev->cpu = cpu;
 
 	if (cpuidle_register_device(dev)) {
-- 
1.8.2.3

