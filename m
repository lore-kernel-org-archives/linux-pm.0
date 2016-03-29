From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 03/10] intel_idle: Remove redundant initialization calls.
Date: Tue, 29 Mar 2016 15:15:55 +0200
Message-ID: <e8e984521effdfb95c0e25f96e2ba70b48127aa1.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The function, intel_idle_cpuidle_driver_init, makes calls on each CPU
to auto_demotion_disable() and c1e_promotion_disable().  These calls
are redundant, as intel_idle_cpu_init() does the same calls just a bit
later on.  They are also premature, as the driver registration may yet
fail.

This patch removes the redundant code.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index dfa9055..cb85c4c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1163,16 +1163,10 @@ static void __init intel_idle_cpuidle_driver_init(void)
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
2.1.4
