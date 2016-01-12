From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 17:04:36 +0100
Message-ID: <56952414.2000800@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601081631380.3575@nanos> <5694F490.3040300@linaro.org>
 <alpine.DEB.2.11.1601121441330.3575@nanos> <56950ACC.4090001@linaro.org>
 <alpine.DEB.2.11.1601121523070.3575@nanos> <5695133A.8090301@linaro.org>
 <alpine.DEB.2.11.1601121609460.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38677 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761190AbcALQEj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 11:04:39 -0500
Received: by mail-wm0-f54.google.com with SMTP id b14so327957518wmb.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 08:04:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601121609460.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/12/2016 04:12 PM, Thomas Gleixner wrote:
> On Tue, 12 Jan 2016, Daniel Lezcano wrote:
>> On 01/12/2016 03:26 PM, Thomas Gleixner wrote:
>>> You better implement the switching part in the cpuidle core first, =
i.e.
>>> proper
>>> callbacks when a governor is switched in/out. Then make use of this
>>> switcheroo
>>> right away. Doing it the other way round is just wrong.
>>
>> The problem is this code is not another governor but a 'predictor' w=
here the
>> scheduler will use the information to ask the cpuidle to go to a spe=
cific idle
>> state without going through the governor code, so into the governor'=
s
>> callbacks. It is on top of cpuidle. The scheduler will become the go=
vernor.
>>
>> The current straightforward code, does the switch in the cpu_idle_lo=
op
>> idle_task's function:
>>
>> [ ... ]
>>
>> if (cpu_idle_force_poll || tick_check_broadcast_expired())
>> 	cpu_idle_poll();
>> else {
>> 	if (sched_idle_enabled()) {
>> 		int latency =3D pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
>> 		s64 duration =3D sched_idle_next_wakeup();
>> 		sched_idle(duration, latency);
>> 	} else {
>> 		cpuidle_idle_call();
>> 	}
>> }
>>
>> Due to the complexity of the code, this first step introduce a mecha=
nism to
>> predict the next event and re-use it trivially in the idle task.
>
> This looks really wrong. Why on earth don't you implement a proper go=
vernor
> and just get rid of this extra hackery?

That is part of the ongoing work where we are integrating the different=
=20
PM subsystems with the scheduler in order have them collaborating=20
together as asked by Ingo [1].

The idea is to get rid of the governors and let the scheduler to tell=20
the Cpuidle framework : "I expect to sleep <x> nsec and I have a <y>
nsec latency requirement" as stated by Peter Zijlstra [2].

The code above could be not nice but I think it begins to do what is=20
expecting Peter. It is an embryonic code and in order to prevent too=20
much different topics for a single series, I posted the two first=20
patches which provide the next event API as the foundations for the nex=
t=20
changes. How we integrate the 'next event' is a question I wanted to=20
postpone in a different series of RFC patches.

   -- Daniel

[1] http://lwn.net/Articles/552885/
[2] https://lkml.org/lkml/2013/11/11/353 (broken here is another archiv=
e [3]
[3] http://lkml.iu.edu/hypermail/linux/kernel/1311.1/01360.html


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

