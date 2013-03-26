From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4][resend] cpuidle : handle clockevent notify from the
 cpuidle framework
Date: Tue, 26 Mar 2013 14:11:11 +0530
Message-ID: <51515F27.3000303@ti.com>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org> <514B0417.6020401@ti.com> <514B10AC.9090909@linaro.org> <514B1354.50506@ti.com> <514B1C06.6070401@linaro.org> <514B1EA5.20209@ti.com> <20130321152502.GA7419@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33363 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881Ab3CZIjq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 04:39:46 -0400
In-Reply-To: <20130321152502.GA7419@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "patches@linaro.org" <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "rnayak@ti.com" <rnayak@ti.com>, "lenb@kernel.org" <lenb@kernel.org>

Lorenzo, Daniel,

On Thursday 21 March 2013 08:55 PM, Lorenzo Pieralisi wrote:
> On Thu, Mar 21, 2013 at 02:52:21PM +0000, Santosh Shilimkar wrote:
> 
> [...]
> 
>>>>>> How about taking care of cpu_pm_notifiers() as well with some
>>>>>> additional flag for CPU and cluster power state. That can help
>>>>>> to reduce and consolidate the code. What you say ?
>>>>>
>>>>> Do you mean add a flag for different level of idle (idle, suspend, power
>>>>> off) and then use the cpu_pm_enter/cpu_cluster_pm_enter in all the
>>>>> drivers as a common framework ?
>>>>>
>>>> I mean only for CPUidle considering C-state already has the information
>>>> about CPU and cluster power state. For suspend, we by-default run the notifiers
>>>> so nothing needs to be done there.
>>>>
>>>> You may not even need a framework. Just like we know in a C-state, timer
>>>> stops, same lines, we can say CPU state is going to be say off and hence
>>>> cpu_pm_enter() notifier needs to be called. And same way for cluster.
>>>>
>>>> I still haven't given complete thought but thought crossed my mind
>>>> after looking at your patches.
>>>
>>> Right, that could be interesting.
>>>
>>> I see may be one issue with this approach: when we enter an idle state
>>> with power off, some checking are done before cpu_pm_enter and that
>>> could lead to abort the current idle routine.
>>>
>> I see your point.
>>
>>> By moving this to the cpuidle framework, we will invoke always
>>> cpu_pm_enter/exit even if the idle enter routine failed.
>>>
>> If we at all decide to go on this path, we can always get around the
>> issues. The key is these notifiers have to be run very close to the
>> low power entry/exit since the saved context for CPU/CPU cluster
>> at wrong points would lead to many issues.
>>
>>> But, IMO, the idea is good.
>>>
>>> For example in cpuidle34xx:
>>>
>>> static int __omap3_enter_idle(struct cpuidle_device *dev,
>>>                                 struct cpuidle_driver *drv,
>>>                                 int index)
>>> {
>>>         struct omap3_idle_statedata *cx = &omap3_idle_data[index];
>>>
>>>         local_fiq_disable();
>>>
>>>         if (omap_irq_pending() || need_resched())
>>>                 goto return_sleep_time;
>>>
>>> 	...
>>>
>>>         if (cx->mpu_state == PWRDM_POWER_OFF)
>>>                 cpu_pm_enter();
>>>
>>> 	...
>>> }
>>>
>>> The same for omap4 and tegra2/3.
>>>
>>> With your knowledge of omap, do you think it is possible to move
>>> cpu_pm_enter before entering the idle routine ?
>>>
>> I will get back on this topic after some experiments most likely
>> by next week.
> 
> Looks like the way to go, we could enhance the notifiers to be able to
> save/restore specific subsystems with the C-state flags defining which
> ones.
> 
> Notifiers actions should not be disruptive so the only drawback in
> executing those before entering the idle routine could possibly be
> a waste of cycles in case the C-state entry fails but certainly something
> to verify on all platforms using them.
>
After spending few mins on the idea, I made few observations.

1. Since the cpu_pm_enter() involves in saving the context CPU
co-processors like VFP, debug subsystem, it should be called
after irq, preemption is disabled and we are on its way
into idle entry. It can be called from generic idle code
but we just need to take care of above.
 
2. cpu_cluster_pm_enter() actually is bit tricky since its use
is not consistent with couple idle entry and say smp_idle entry.
Clusters notifiers are called when the idle drivers finds that
all the CPUs in that cluster are at sleep and current CPU
can take down the cluster with it. This notifier as well
needs to be called late since the after the notifier call,
there shouldn't be any irq activity which might lead to
incorrect context save for say irq controller.

3. Same goes with exit notifiers which has to be called
before irq, preemption is enabled back again.

4. Couple idle overall needs special considerations to
manage these notifiers from generic code.

Overall it seems to be doable with the direction you
already started for timer broad-cast notifiers. You
can at least add this one in your queue of works :-)
I do not have much cycles left because of other pile
of work to carry out the changes but you can surely
count me on reviewing and testing the patches.

Regards,
Santosh


