From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Thu, 16 Nov 2017 14:47:45 -0800
Message-ID: <001f01d35f2c$edc11490$c9433db0$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net> <002c01d35d0f$8b0416f0$a10c44d0$@net> FMl8e97ZchCDuFMlDezTwJ
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:45299 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965567AbdKPWrw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Nov 2017 17:47:52 -0500
In-Reply-To: FMl8e97ZchCDuFMlDezTwJ
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: =?UTF-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>, 'Yu Chen' <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>


On 2017.11.16 08:11 Thomas Ilsche wrote:

>> Actually, the watchdog_timer_fn does set the "need_resched" condition, and will
>> cause the state 0 idle to exit normally.
>> 
>> But yes, tick_sched_timer and a few others (for example: sched_rt_period_timer,
>> clocksource_watchdog) do not set the "need_resched" condition, and, as you
>> mentioned, will not cause the state 0 idle to exit as it should.
>> 
>> Conclusion: Currently the exit condition in drivers/cpuidle/poll_state.c
>> is insufficient to guarantee proper operation.

Or: Any interrupt out of the idle loop must return with "need_resched" 

>> 
>> This:
>> 
>> while (!need_resched())
>> 
>> is not enough.
>
> I may very well have mistakenly included watchdog_timer_fn in the list,
> but as you describe it is inconsequential. If there are timers that do
> not set need_resched, and that itself is not considered a bug, then
> there should be another break condition.
> I suppose it is a good idea
> to differentiate between the need for rescheduling and the need to
> be able to go in another sleep state.

See patch below. I think both conditions are satisfied.

> What do you think about the idea to use idle_expires?
> Although on second thought that may have issues regarding accuracy /
> race conditions with the interrupt timer.

For a couples of days now, and with excellent results, I have
been testing variations on the following theme:

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 7416b16..4d17d3d 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -5,16 +5,31 @@
  */

 #include <linux/cpuidle.h>
+#include <linux/tick.h>
 #include <linux/sched.h>
 #include <linux/sched/idle.h>

 static int __cpuidle poll_idle(struct cpuidle_device *dev,
                               struct cpuidle_driver *drv, int index)
 {
+       unsigned int next_timer_us, i;
+
        local_irq_enable();
        if (!current_set_polling_and_test()) {
-               while (!need_resched())
+               while (!need_resched()){
                        cpu_relax();
+
+                       /* Occasionally check for a new and long expected residency time. */
+                       if (!(i++ % 1024)) {
+                               local_irq_disable();
+                               next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
+                               local_irq_enable();
+                               /* need a better way to get threshold, including large margin */
+                               /* We are only trying to catch really bad cases here.         */
+                               if (next_timer_us > 100)
+                               break;
+                       }
+               }
        }
        current_clr_polling();


Trace example 1:

       9 [005] d...  1749.232242: cpu_idle: state=4 cpu_id=5
 1055985 [005] d...  1750.288228: cpu_idle: state=4294967295 cpu_id=5
       3 [005] d.h.  1750.288231: local_timer_entry: vector=239
       1 [005] d.h.  1750.288233: local_timer_exit: vector=239
       5 [005] d...  1750.288238: cpu_idle: state=0 cpu_id=5
       0 [005] d.h.  1750.288238: local_timer_entry: vector=239
       0 [005] d.h.  1750.288239: hrtimer_expire_entry: hrtimer=ffff91ca5f354880 function=tick_sched_timer now=1749980002791
       3 [005] d.h.  1750.288242: hrtimer_expire_exit: hrtimer=ffff91ca5f354880
       0 [005] d.h.  1750.288243: local_timer_exit: vector=239
       1 [005] ..s.  1750.288244: timer_expire_entry: timer=ffffffffb4770ee0 function=__prandom_timer now=4295329792
       4 [005] ..s.  1750.288249: timer_expire_exit: timer=ffffffffb4770ee0
       5 [005] ....  1750.288254: cpu_idle: state=4294967295 cpu_id=5

"need_resched" is not set, but the next timer is far off, so poll_state.c with the above patch now exits.
And properly now decides to go into idle state 4, because nothing is going to happen for an eternity.

       1 [005] d...  1750.288256: cpu_idle: state=4 cpu_id=5
 2087982 [005] d...  1752.376239: cpu_idle: state=4294967295 cpu_id=5
       3 [005] d.h.  1752.376242: local_timer_entry: vector=239
       0 [005] d.h.  1752.376243: local_timer_exit: vector=239
       5 [005] d...  1752.376248: cpu_idle: state=1 cpu_id=5
      15 [005] d...  1752.376263: cpu_idle: state=4294967295 cpu_id=5
       0 [005] d.h.  1752.376263: local_timer_entry: vector=239
       0 [005] d.h.  1752.376264: hrtimer_expire_entry: hrtimer=ffff91ca5f354a00 function=watchdog_timer_fn now=1752068001621
       3 [005] dNh.  1752.376268: hrtimer_expire_exit: hrtimer=ffff91ca5f354a00


Trace example 2:

       4 [000] d...  1792.272757: cpu_idle: state=0 cpu_id=0
       1 [000] d.h.  1792.272758: local_timer_entry: vector=239
       0 [000] d.h.  1792.272759: hrtimer_expire_entry: hrtimer=ffff91ca5f214880 function=tick_sched_timer now=1791964002768
       3 [000] d.h.  1792.272762: hrtimer_expire_exit: hrtimer=ffff91ca5f214880
       0 [000] d.h.  1792.272762: local_timer_exit: vector=239

The next timer is very short, so the poll_state.c loop does not exit.
(even if it was going to exit, it might not have had time to. I didn't find a better example.)

       0 [000] ..s.  1792.272763: timer_expire_entry: timer=ffff91ca4cde8478 function=dev_watchdog now=4295340288
       3 [000] ..s.  1792.272766: timer_expire_exit: timer=ffff91ca4cde8478

The next timer is very short, so the poll_state.c loop does not exit.

       0 [000] d.s.  1792.272767: timer_expire_entry: timer=ffffffffc0997440 function=delayed_work_timer_fn now=4295340288
       5 [000] dNs.  1792.272772: timer_expire_exit: timer=ffffffffc0997440

This time "need_resched" is set. I assume it didn't have time to exit idle state 0 yet.

       0 [000] dNs.  1792.272772: timer_expire_entry: timer=ffffffffb46faa40 function=delayed_work_timer_fn now=4295340288
       0 [000] dNs.  1792.272773: timer_expire_exit: timer=ffffffffb46faa40

Now it exits idle state 0.

       7 [000] .N..  1792.272780: cpu_idle: state=4294967295 cpu_id=0
      29 [000] d...  1792.272810: cpu_idle: state=4 cpu_id=0

And properly now decides to go into idle state 4, because nothing is going to happen for awhile.

   91949 [000] d...  1792.364760: cpu_idle: state=4294967295 cpu_id=0
       3 [000] d.h.  1792.364763: local_timer_entry: vector=239
       0 [000] d.h.  1792.364764: hrtimer_expire_entry: hrtimer=ffff91ca5f214a00 function=watchdog_timer_fn now=1792056006926

... Doug
