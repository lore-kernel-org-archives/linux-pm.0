From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [RFC PATCH] power/cpuidle: enhance the precision of state select
Date: Thu,  9 Jun 2016 11:08:40 +0800
Message-ID: <1465441720-5527-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34856 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933858AbcFIDJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 23:09:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id c2so8690696pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2016 20:09:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, zhaoyang.huang@spreadtrum.com

In previous version, cpu_pm_enter is invoked after the governor
select the state, which cause the executing time of cpu_pm_enter
is included in the idle time. Moving it before the state selection.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 kernel/sched/idle.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index bd12c6c..929da2e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -5,6 +5,7 @@
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_pm.h>
 #include <linux/tick.h>
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
@@ -130,6 +131,7 @@ static void cpuidle_idle_call(void)
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int next_state, entered_state;
+	int ret;
 
 	/*
 	 * Check if the idle task must be rescheduled. If it is the
@@ -174,12 +176,16 @@ static void cpuidle_idle_call(void)
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
-		next_state = cpuidle_select(drv, dev);
-		entered_state = call_cpuidle(drv, dev, next_state);
-		/*
-		 * Give the governor an opportunity to reflect on the outcome
-		 */
-		cpuidle_reflect(dev, entered_state);
+		ret = cpu_pm_enter();
+		if (!ret) {
+			next_state = cpuidle_select(drv, dev);
+			entered_state = call_cpuidle(drv, dev, next_state);
+			cpu_pm_exit();
+			/*
+			 * Give the governor an opportunity to reflect on the outcome
+			 */
+			cpuidle_reflect(dev, entered_state);
+		}
 	}
 
 exit_idle:
-- 
1.7.9.5

