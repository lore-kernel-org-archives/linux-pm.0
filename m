From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 15:52:42 +0100
Message-ID: <5695133A.8090301@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601081631380.3575@nanos> <5694F490.3040300@linaro.org>
 <alpine.DEB.2.11.1601121441330.3575@nanos> <56950ACC.4090001@linaro.org>
 <alpine.DEB.2.11.1601121523070.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36419 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbcALOwp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 09:52:45 -0500
Received: by mail-wm0-f54.google.com with SMTP id l65so255211566wmf.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 06:52:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601121523070.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/12/2016 03:26 PM, Thomas Gleixner wrote:
> On Tue, 12 Jan 2016, Daniel Lezcano wrote:
>> On 01/12/2016 02:42 PM, Thomas Gleixner wrote:
>>> On Tue, 12 Jan 2016, Daniel Lezcano wrote:
>>>> On 01/08/2016 04:43 PM, Thomas Gleixner wrote:
>>>>>> +	/*
>>>>>> +	 * Register the setup/free irq callbacks, so new interrupt or
>>>>>> +	 * freed interrupt will update their tracking.
>>>>>> +	 */
>>>>>> +	ret =3D register_irq_timings(&irqt_ops);
>>>>>> +	if (ret) {
>>>>>> +		pr_err("Failed to register timings ops\n");
>>>>>> +		return ret;
>>>>>> +	}
>>>>>
>>>>> So that stuff is installed unconditionally. Is it used unconditio=
nally
>>>>> as
>>>>> well?
>>>>
>>>> Sorry, I am not sure to understand your question. If the kernel is
>>>> compiled
>>>> with CONFIG_CPU_IDLE_GOV_SCHED=3Dy, this code is enabled and use t=
he irq
>>>> timings. The condition comes from the compilation option.
>>>
>>> The question is whether the option also activates that thing or is =
there
>>> still
>>> some /sys/whatever/idlegov magic where you can (de)select it.
>>
>> Yes, in the next patches of the series I did not send, we can switch=
 to the
>> cpuidle's governor framework or idle-sched. I will look at how to di=
sable it
>> when switching to the cpuidle's governors.
>
> You better implement the switching part in the cpuidle core first, i.=
e. proper
> callbacks when a governor is switched in/out. Then make use of this s=
witcheroo
> right away. Doing it the other way round is just wrong.

The problem is this code is not another governor but a 'predictor' wher=
e=20
the scheduler will use the information to ask the cpuidle to go to a=20
specific idle state without going through the governor code, so into th=
e=20
governor's callbacks. It is on top of cpuidle. The scheduler will becom=
e=20
the governor.

The current straightforward code, does the switch in the cpu_idle_loop=20
idle_task's function:

[ ... ]

if (cpu_idle_force_poll || tick_check_broadcast_expired())
	cpu_idle_poll();
else {
	if (sched_idle_enabled()) {
		int latency =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
		s64 duration =3D sched_idle_next_wakeup();
		sched_idle(duration, latency);
	} else {
		cpuidle_idle_call();
	}
}

Due to the complexity of the code, this first step introduce a mechanis=
m=20
to predict the next event and re-use it trivially in the idle task.

Perhaps, it would be acceptable to have cpuidle_idle_call() to be=20
replaced by a callback and the switch acts at this level ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

