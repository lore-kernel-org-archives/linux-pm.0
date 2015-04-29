From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control
 function
Date: Wed, 29 Apr 2015 11:44:30 +0200
Message-ID: <5540A7FE.4030301@linaro.org>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <553F920D.6090404@arm.com> <2361707.7eGhMTvCz6@vostro.rjw.lan> <6185796.9I7OmaAAcQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38790 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966129AbbD2Jof (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 05:44:35 -0400
Received: by wiun10 with SMTP id n10so59066851wiu.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2015 02:44:33 -0700 (PDT)
In-Reply-To: <6185796.9I7OmaAAcQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 04/29/2015 03:04 AM, Rafael J. Wysocki wrote:
> On Wednesday, April 29, 2015 02:50:22 AM Rafael J. Wysocki wrote:
>> On Tuesday, April 28, 2015 02:58:37 PM Sudeep Holla wrote:
>>>
>>> On 28/04/15 15:14, Rafael J. Wysocki wrote:
>>>> On Tuesday, April 28, 2015 03:37:44 PM Rafael J. Wysocki wrote:
>>>>> On Tuesday, April 28, 2015 03:31:54 PM Rafael J. Wysocki wrote:
>>>>>> On Tuesday, April 28, 2015 02:37:10 PM Linus Walleij wrote:
>>>>>>> On Tue, Apr 28, 2015 at 2:19 PM, Rafael J. Wysocki <rafael@kern=
el.org> wrote:
>>>>>>>> Sudeep:
>>>>>>>>> At-least I observed issue only when I am using hardware broad=
cast timer.
>>>>>>>>> It doesn't hang when I am using hrtimer as broadcast timer in=
 which case
>>>>>>>>> one of the cpu will be not enter deeper idle states that lose=
 timer.
>>>>>>>>> I will rerun on v4.1-rc1 and post the complete log.
>>>>>>>>
>>>>>>>> So the bug here is that cpuidle_enter() enables interrupts, so=
 the
>>>>>>>> assumption about them being not enabled made by
>>>>>>>> tick_broadcast_oneshot_control() is actually not valid.
>>>>>>>>
>>>>>>>> It looks like we need to acquire the clockevents_lock at least=
 in this
>>>>>>>> particular case.  Let me see where to put it and I'll send a p=
atch for
>>>>>>>> testing.
>>>>>>>
>>>>>>> Aha that looks very much like it. Put me on the patch and I'll
>>>>>>> take it for a spin.
>>>>>>
>>>>>> OK, so something like the below for starters (the _irqsave varia=
nt is used to
>>>>>> avoid adding one more WARN_ON(irqs_disabled()) in there).
>>>>>>
>>>>>> I haven't tested it, but then I can't reproduce the original iss=
ue in the
>>>>>> first place.
>>>>>
>>>>> Of course, the whole "broadcast" thing could be done from cpuidle=
_enter()
>>>>> in the first place, but then we could not avoid the problem with =
the cpuidle
>>>>> *callback* enabling interrupts possibly in there anyway (not to m=
ention the
>>>>> "coupled" stuff).
>>>>
>>>> That said, if the given state is marked with CPUIDLE_FLAG_TIMER_ST=
OP, I really
>>>> wouldn't expect it to re-enable interrupts on exit and the "couple=
d" thing
>>>> seems to be fundamentally at odds with that flag either.
>>>>
>>>> So it should be possible to move the "broadcast" logic into the cp=
uidle layer,
>>>> which I'm going to try to do.
>>>>
>>>
>>> Makes sense.
>>>
>>>> Please test the patch I've sent, though, as it should bring the co=
de back to
>>>> where it was before the clockevents_notify() removal and it'd be g=
ood to verify
>>>> that.
>>>>
>>>
>>> I tested your patch and it works now. Anyways I am continuing to ru=
n
>>> stress tests on my board. I will report if I find any issues.
>>
>> Great, thanks!
>>
>> Below is the patch I came up with in the meantime.
>>
>> This moves the "switch to broadcast" timer logic into
>> cpuidle_enter_state() which allows tick_broadcast_exit() to be
>> called directly with interrupts disabled (as required), but
>> it also adds a fallback branch reflecting the 4.0 and earlier
>> behavior for idle states that enable interrupts on exit
>> from their ->enter callbacks.
>>
>> I'm not aware of any valid cases when CPUIDLE_FLAG_TIMER_STOP can be
>> set for such states, but people may try to add stuff like that in th=
e
>> future, so it's better to catch that (hence the WARN_ON_ONCE) and do
>> our best to handle it gracefully anyway, IMO.
>>
>> The "if (entered_state =3D=3D -EBUSY)" check is conservative.  It ma=
y
>> be better to do "if (entered_state < 0)" and fall back to the defaul=
t
>> on all errors, but that's not what we do today (I guess the concern
>> would be "what if the state ->enter returns an error after entering
>> and exiting the idle state, in which case we may miss a wakeup event
>> if we fall back to the default").
>
> Actually, if my understanding of things is correct (the local clock e=
vent
> device cannot go away from under code executed with interrupts disabl=
ed
> on the local CPU), the simplified one below should be sufficient.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle.c |   16 ++++++++++++++++
>   kernel/sched/idle.c       |   16 ++--------------
>   2 files changed, 18 insertions(+), 14 deletions(-)
>
> Index: linux-pm/kernel/sched/idle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -81,7 +81,6 @@ static void cpuidle_idle_call(void)
>   	struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
>   	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
>   	int next_state, entered_state;
> -	unsigned int broadcast;
>   	bool reflect;
>
>   	/*
> @@ -150,17 +149,6 @@ static void cpuidle_idle_call(void)
>   		goto exit_idle;
>   	}
>
> -	broadcast =3D drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_ST=
OP;
> -
> -	/*
> -	 * Tell the time framework to switch to a broadcast timer
> -	 * because our local timer will be shutdown. If a local timer
> -	 * is used from another cpu as a broadcast timer, this call may
> -	 * fail if it is not available
> -	 */
> -	if (broadcast && tick_broadcast_enter())
> -		goto use_default;
> -
>   	/* Take note of the planned idle state. */
>   	idle_set_state(this_rq(), &drv->states[next_state]);
>
> @@ -174,8 +162,8 @@ static void cpuidle_idle_call(void)
>   	/* The cpu is no longer idle or about to enter idle. */
>   	idle_set_state(this_rq(), NULL);
>
> -	if (broadcast)
> -		tick_broadcast_exit();
> +	if (entered_state =3D=3D -EBUSY)
> +		goto use_default;
>
>   	/*
>   	 * Give the governor an opportunity to reflect on the outcome
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -158,9 +158,18 @@ int cpuidle_enter_state(struct cpuidle_d
>   	int entered_state;
>
>   	struct cpuidle_state *target_state =3D &drv->states[index];
> +	bool broadcast =3D !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP=
);
>   	ktime_t time_start, time_end;
>   	s64 diff;
>
> +	/*
> +	 * Tell the time framework to switch to a broadcast timer because o=
ur
> +	 * local timer will be shut down.  If a local timer is used from an=
other
> +	 * CPU as a broadcast timer, this call may fail if it is not availa=
ble.
> +	 */
> +	if (broadcast && tick_broadcast_enter())
> +		return -EBUSY;
> +
>   	trace_cpu_idle_rcuidle(index, dev->cpu);
>   	time_start =3D ktime_get();
>
> @@ -169,6 +178,13 @@ int cpuidle_enter_state(struct cpuidle_d
>   	time_end =3D ktime_get();
>   	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>
> +	if (broadcast) {
> +		if (WARN_ON_ONCE(!irqs_disabled()))
> +			local_irq_disable();
> +
> +		tick_broadcast_exit();
> +	}
> +
>   	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
>   		local_irq_enable();
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

