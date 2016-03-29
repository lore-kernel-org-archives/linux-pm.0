From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 02/10] intel_idle: Fix a helper function's return value.
Date: Tue, 29 Mar 2016 15:15:54 +0200
Message-ID: <f6a47473f1d0ff7312511fd42063db2130d46e99.1459257096.git.rcochran@linutronix.de>
References: <cover.1459257096.git.rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459257096.git.rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The function, intel_idle_cpuidle_driver_init, delivers no error codes
at all.  This patch changes the function to return 'void' instead of
returning zero.

Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/idle/intel_idle.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9d5ed32..dfa9055 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1111,7 +1111,7 @@ static void intel_idle_state_table_update(void)
  * intel_idle_cpuidle_driver_init()
  * allocate, initialize cpuidle_states
  */
-static int __init intel_idle_cpuidle_driver_init(void)
+static void __init intel_idle_cpuidle_driver_init(void)
 {
 	int cstate;
 	struct cpuidle_driver *drv = &intel_idle_driver;
@@ -1173,8 +1173,6 @@ static int __init intel_idle_cpuidle_driver_init(void)
 
 	if (icpu->disable_promotion_to_c1e)	/* each-cpu is redundant */
 		on_each_cpu(c1e_promotion_disable, NULL, 1);
-
-	return 0;
 }
 
 
-- 
2.1.4
