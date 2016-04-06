From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/13] intel_idle: Remove redundant initialization calls.
Date: Wed,  6 Apr 2016 17:00:50 -0400
Message-ID: <9a82e7196c346cb0428f37d652048ac577322c39.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Richard Cochran <rcochran@linutronix.de>

The function, intel_idle_cpuidle_driver_init, makes calls on each CPU
to auto_demotion_disable() and c1e_promotion_disable().  These calls
are redundant, as intel_idle_cpu_init() does the same calls just a bit
later on.  They are also premature, as the driver registration may yet
fail.

This patch removes the redundant code.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d2e7baf..c50859d 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1300,16 +1300,10 @@ static void __init intel_idle_cpuidle_driver_init(void)
 		drv->state_count += 1;
 	}
 
-	if (icpu->auto_demotion_disable_flags)
-		on_each_cpu(auto_demotion_disable, NULL, 1);
-
 	if (icpu->byt_auto_demotion_disable_flag) {
 		wrmsrl(MSR_CC6_DEMOTION_POLICY_CONFIG, 0);
 		wrmsrl(MSR_MC6_DEMOTION_POLICY_CONFIG, 0);
 	}
-
-	if (icpu->disable_promotion_to_c1e)	/* each-cpu is redundant */
-		on_each_cpu(c1e_promotion_disable, NULL, 1);
 }
 
 
-- 
2.8.0.rc4.16.g56331f8
