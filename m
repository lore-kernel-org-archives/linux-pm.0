From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4][resend] cpuidle : handle clockevent notify from the
 cpuidle framework
Date: Thu, 21 Mar 2013 20:22:21 +0530
Message-ID: <514B1EA5.20209@ti.com>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org> <514B0417.6020401@ti.com> <514B10AC.9090909@linaro.org> <514B1354.50506@ti.com> <514B1C06.6070401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33958 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3CUOvE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 10:51:04 -0400
In-Reply-To: <514B1C06.6070401@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

On Thursday 21 March 2013 08:11 PM, Daniel Lezcano wrote:
> On 03/21/2013 03:04 PM, Santosh Shilimkar wrote:
>> On Thursday 21 March 2013 07:22 PM, Daniel Lezcano wrote:
>>> On 03/21/2013 01:59 PM, Santosh Shilimkar wrote:
>>>> On Thursday 21 March 2013 05:51 PM, Daniel Lezcano wrote:
>>>>> When a cpu enters a deep idle state, the local timers are stopped and
>>>>> the time framework falls back to the timer device used as a broadcast
>>>>> timer.
>>>>>
>>>>> The different cpuidle drivers are calling clockevents_notify ENTER/EXIT
>>>>> when the idle state stops the local timer.
>>>>>
>>>>> Add a new flag CPUIDLE_FLAG_TIMER_STOP which can be set by the cpuidle
>>>>> drivers. If the flag is set, the cpuidle core code takes care of the
>>>>> notification on behalf of the driver to avoid pointless code duplication.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Len Brown <lenb@kernel.org>
>>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>> Cc: Rajendra Nayak <rnayak@ti.com>
>>>>> Cc: Sascha Hauer <kernel@pengutronix.de>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> ---
>>>>>  drivers/cpuidle/cpuidle.c |    9 +++++++++
>>>>>  include/linux/cpuidle.h   |    1 +
>>>>>  2 files changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>>>> index eba6929..c500370 100644
>>>>> --- a/drivers/cpuidle/cpuidle.c
>>>>> +++ b/drivers/cpuidle/cpuidle.c
>>>>> @@ -8,6 +8,7 @@
>>>>>   * This code is licenced under the GPL.
>>>>>   */
>>>>>  
>>>>> +#include <linux/clockchips.h>
>>>>>  #include <linux/kernel.h>
>>>>>  #include <linux/mutex.h>
>>>>>  #include <linux/sched.h>
>>>>> @@ -146,12 +147,20 @@ int cpuidle_idle_call(void)
>>>>>  
>>>>>  	trace_cpu_idle_rcuidle(next_state, dev->cpu);
>>>>>  
>>>>> +	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
>>>>> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>>>>> +				   &dev->cpu);
>>>>> +
>>>> Seems like good clean-up from drivers.
>>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>>> How about taking care of cpu_pm_notifiers() as well with some
>>>> additional flag for CPU and cluster power state. That can help
>>>> to reduce and consolidate the code. What you say ?
>>>
>>> Do you mean add a flag for different level of idle (idle, suspend, power
>>> off) and then use the cpu_pm_enter/cpu_cluster_pm_enter in all the
>>> drivers as a common framework ?
>>>
>> I mean only for CPUidle considering C-state already has the information
>> about CPU and cluster power state. For suspend, we by-default run the notifiers
>> so nothing needs to be done there.
>>
>> You may not even need a framework. Just like we know in a C-state, timer
>> stops, same lines, we can say CPU state is going to be say off and hence
>> cpu_pm_enter() notifier needs to be called. And same way for cluster.
>>
>> I still haven't given complete thought but thought crossed my mind
>> after looking at your patches.
> 
> Right, that could be interesting.
> 
> I see may be one issue with this approach: when we enter an idle state
> with power off, some checking are done before cpu_pm_enter and that
> could lead to abort the current idle routine.
> 
I see your point.

> By moving this to the cpuidle framework, we will invoke always
> cpu_pm_enter/exit even if the idle enter routine failed.
> 
If we at all decide to go on this path, we can always get around the
issues. The key is these notifiers have to be run very close to the
low power entry/exit since the saved context for CPU/CPU cluster
at wrong points would lead to many issues.

> But, IMO, the idea is good.
> 
> For example in cpuidle34xx:
> 
> static int __omap3_enter_idle(struct cpuidle_device *dev,
>                                 struct cpuidle_driver *drv,
>                                 int index)
> {
>         struct omap3_idle_statedata *cx = &omap3_idle_data[index];
> 
>         local_fiq_disable();
> 
>         if (omap_irq_pending() || need_resched())
>                 goto return_sleep_time;
> 
> 	...
> 
>         if (cx->mpu_state == PWRDM_POWER_OFF)
>                 cpu_pm_enter();
> 
> 	...
> }
> 
> The same for omap4 and tegra2/3.
> 
> With your knowledge of omap, do you think it is possible to move
> cpu_pm_enter before entering the idle routine ?
> 
I will get back on this topic after some experiments most likely
by next week.

Regards,
Santosh


