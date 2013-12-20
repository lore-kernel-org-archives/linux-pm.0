From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 7/9] intel_idle: remove superfluous dev->state_count
 initialization
Date: Fri, 20 Dec 2013 19:47:29 +0100
Message-ID: <1387565251-7051-8-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

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
index 38da3fb..524d07b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -639,39 +639,10 @@ static int __init intel_idle_cpuidle_driver_init(void)
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
-			break;
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
