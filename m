From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [RFC PATCH v3 1/2] power/cpuidle: enhance the precision of state select
Date: Mon, 27 Jun 2016 15:42:15 +0800
Message-ID: <1467013336-19966-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35528 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcF0Hm1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 03:42:27 -0400
Received: by mail-pa0-f46.google.com with SMTP id hl6so56625807pac.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2016 00:42:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, zhaoyang.huang@spreadtrum.com, private-pmwg@lists.linaro.org, tglx@linutronix.de

In previous version, cpu_pm_enter is invoked after the governor
select the state, which cause the executing time of cpu_pm_enter
is included in the idle time. Moving it before the state selection.

Please refer to bellowing chart for detailed information

current approach:
static void cpu_idle_loop(void)
{
	while (1) {
		tick_nohz_idle_enter();
		--->__tick_nohz_idle_enter
		--->tick_nohz_stop_sched_tick
		    {
		    ...
		    	ts->sleep_length = ktime_sub(dev->next_event, now);          /*1*/
		    ...
		    }

		while (!need_resched()) {
			...
			local_irq_disable();
			arch_cpu_idle_enter();
			--->idle_notifier_call_chain(IDLE_START);                    /*2*/

			cpuidle_idle_call();
			--->next_state = cpuidle_select(drv, dev);                   /*3*/
			--->static int arm_enter_idle_state(...)
			{
			...
				ret = cpu_pm_enter();                                /*4*/
			}
}

---------|----------------------|----------------------------|------------------------------------|--------------------------------------------|--------------------
       1.now              2.IDLE_START             3.select idle state                     4.CPU_PM_ENTER                                 next_event
   (sleep_length)

modified approach:
static void cpu_idle_loop(void)
{
	while (1) {
		tick_nohz_idle_enter();
		--->__tick_nohz_idle_enter
		--->tick_nohz_stop_sched_tick
		    {
		    ...

		    ...
		    }

		while (!need_resched()) {
			...
			local_irq_disable();
			arch_cpu_idle_enter();
			--->idle_notifier_call_chain(IDLE_START);                            /*1*/

			cpuidle_idle_call();
			--->ret = cpu_pm_enter();                                            /*2*/
			--->tick_nohz_get_sleep_length
			{
				ts->sleep_length = ktime_sub(dev->next_event, now);          /*3*/
			}
			--->next_state = cpuidle_select(drv, dev);                           /*4*/
			--->static int arm_enter_idle_state(...)
}

----------------|---------------------------------------|---------------------|------------------|--------------------------------------------|--------------------
          1.IDLE_START                           2.CPU_PM_ENTER            3.now          4.select idle state                            next_event
                                                                        (sleep_length)
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 kernel/sched/idle.c | 18 ++++++++++++------
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
1.9.1

