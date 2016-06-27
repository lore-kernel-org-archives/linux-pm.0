From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [RFC PATCH v3 2/2] power/idle: enhance the precision of sleep_length
Date: Mon, 27 Jun 2016 15:42:16 +0800
Message-ID: <1467013336-19966-2-git-send-email-zhaoyang.huang@spreadtrum.com>
References: <1467013336-19966-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467013336-19966-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, zhaoyang.huang@spreadtrum.com, private-pmwg@lists.linaro.org, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

As shown in bellowing chart, there should be a gap between
tick_nohz_idle_enter(step '1') and tick_nohz_get_sleep_length
(step '3') when idle, which comprise of the execution time of
the code behind step '1' and a series of notify call(step2,4).
Yes, for most of the scenarios, it would NOT be a problem.
However,all time consumed by the steps above will cause the
sleep_length is not very precised in the scenario where the
idle state is shallow(imagin an idle state last less than 500us
 under a 200Mhz's P-state). Change it in this series of patch.

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
 kernel/time/tick-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 536ada8..ee3be3d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -975,6 +975,11 @@ void tick_nohz_irq_exit(void)
 ktime_t tick_nohz_get_sleep_length(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
+	ktime_t now;
+
+	now = ktime_get();
+	ts->sleep_length = ktime_sub(dev->next_event, now);
 
 	return ts->sleep_length;
 }
-- 
1.9.1
