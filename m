From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Mon, 13 Nov 2017 22:12:22 -0800
Message-ID: <002c01d35d0f$8b0416f0$a10c44d0$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net> CCuzeI4ZRt1L5CCv4eEEwJ CTB2e0cXiQTuKCTB3eazVD
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:52858 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdKNGM2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Nov 2017 01:12:28 -0500
In-Reply-To: CTB2e0cXiQTuKCTB3eazVD
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: =?UTF-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>, 'Yu Chen' <yu.c.chen@intel.com>, 'Doug Smythies' <dsmythies@telus.net>

Hi Thomas,

I am revising and expanding one of my previous replies:

On 2017.11.08 08:26 Doug Smythies wrote:
> On 2017.11.07 15:04 Thomas Ilsche wrote:

>> This immediate (usually 1-3 us) timer can be both tick_sched_timer and
>> watchdog_timer_fn. The timers actually do happen and run, however poll_idle
>> directly resumes after the interrupt - there is no need_resched(). The menu
>> governor assumes that a timer will trigger another menu_select, but it does not.
>> Neither does our fallback timer - so the mitigation.

> Agreed.

Revised: Mostly agree.

Actually, the watchdog_timer_fn does set the "need_resched" condition, and will
cause the state 0 idle to exit normally.

But yes, tick_sched_timer and a few others (for example: sched_rt_period_timer,
clocksource_watchdog) do not set the "need_resched" condition, and, as you
mentioned, will not cause the state 0 idle to exit as it should.

Conclusion: Currently the exit condition in drivers/cpuidle/poll_state.c
is insufficient to guarantee proper operation.

This:

while (!need_resched())

is not enough.

I was thinking that maybe the number of interrupts could also
be a condition:

while(!need_resched() | interrupt count has not changed)

However, I haven't yet figured out how to code it, or even if there
is a interrupt count per CPU that can be used.

Supporting trace data, reprocessed so that delta microseconds is on
the left (the 1 uSec uncertainty is because I am only using doubles
instead of long doubles for the math):
 
       4 [006] d... 93455.518023: cpu_idle: state=0 cpu_id=6
       1 [006] d.h. 93455.518024: local_timer_entry: vector=239
       0 [006] d.h. 93455.518025: hrtimer_expire_entry: hrtimer=ffff97329f394880 function=tick_sched_timer now=93453436001688
       3 [006] d.h. 93455.518028: hrtimer_expire_exit: hrtimer=ffff97329f394880
       0 [006] d.h. 93455.518028: local_timer_exit: vector=239
       0 [006] ..s. 93455.518029: timer_expire_entry: timer=ffffffffa378f260 function=clocksource_watchdog now=4318255656
       3 [006] ..s. 93455.518032: timer_expire_exit: timer=ffffffffa378f260
 1375991 [006] d.h. 93456.894024: local_timer_entry: vector=239
       1 [006] d.h. 93456.894025: local_timer_exit: vector=239
      29 [006] d.h. 93456.894055: local_timer_entry: vector=239
       0 [006] d.h. 93456.894055: hrtimer_expire_entry: hrtimer=ffff97329f394880 function=tick_sched_timer now=93454812001797
       2 [006] d.h. 93456.894057: hrtimer_expire_exit: hrtimer=ffff97329f394880
       0 [006] d.h. 93456.894057: local_timer_exit: vector=239
       1 [006] d.s. 93456.894058: timer_expire_entry: timer=ffff97328c8dd200 function=delayed_work_timer_fn now=4318256000
       2 [006] dNs. 93456.894061: timer_expire_exit: timer=ffff97328c8dd200
       4 [006] .N.. 93456.894065: cpu_idle: state=4294967295 cpu_id=6

       4 [006] d... 93470.150347: cpu_idle: state=0 cpu_id=6
       0 [006] d.h. 93470.150348: local_timer_entry: vector=239
       1 [006] d.h. 93470.150349: hrtimer_expire_entry: hrtimer=ffff97329f394a00 function=watchdog_timer_fn now=93468068002439
       2 [006] dNh. 93470.150352: hrtimer_expire_exit: hrtimer=ffff97329f394a00
       1 [006] dNh. 93470.150353: local_timer_exit: vector=239
       0 [006] .N.. 93470.150354: cpu_idle: state=4294967295 cpu_id=6  <<<< This one is O.K.

       2 [001] d... 93447.137840: cpu_idle: state=0 cpu_id=1
       2 [001] d.h. 93447.137842: local_timer_entry: vector=239
       1 [001] d.h. 93447.137843: hrtimer_expire_entry: hrtimer=ffffffffa3739998 function=sched_rt_period_timer now=93445056004391
       2 [001] d.h. 93447.137845: hrtimer_expire_exit: hrtimer=ffffffffa3739998
       0 [001] d.h. 93447.137845: local_timer_exit: vector=239
 1372029 [001] .N.. 93448.509875: cpu_idle: state=4294967295 cpu_id=1  <<<<<< I don't know the exit cause for this one.

       4 [001] d... 93489.022764: cpu_idle: state=0 cpu_id=1
       0 [001] d.h. 93489.022764: local_timer_entry: vector=239
       1 [001] d.h. 93489.022765: hrtimer_expire_entry: hrtimer=ffff97329f254880 function=tick_sched_timer now=93486940002114
       2 [001] d.h. 93489.022768: hrtimer_expire_exit: hrtimer=ffff97329f254880
       1 [001] d.h. 93489.022769: local_timer_exit: vector=239
       0 [001] ..s. 93489.022770: timer_expire_entry: timer=ffffffffa378f260 function=clocksource_watchdog now=4318264032
       3 [001] ..s. 93489.022773: timer_expire_exit: timer=ffffffffa378f260
 1115989 [001] d.h. 93490.138763: local_timer_entry: vector=239
       1 [001] d.h. 93490.138764: local_timer_exit: vector=239
      25 [001] d.h. 93490.138789: local_timer_entry: vector=239
       0 [001] d.h. 93490.138790: hrtimer_expire_entry: hrtimer=ffff97329f254a00 function=watchdog_timer_fn now=93488056002228
       3 [001] dNh. 93490.138793: hrtimer_expire_exit: hrtimer=ffff97329f254a00
       0 [001] dNh. 93490.138794: local_timer_exit: vector=239
       1 [001] .N.. 93490.138795: cpu_idle: state=4294967295 cpu_id=1

Legend (copied):

# tracer: nop
#
#                              _-----=> irqs-off
#                             / _----=> need-resched  <<<<<<< Important flag.
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [005] d... 93446.826313: cpu_idle: state=4294967295 cpu_id=5

... Doug
