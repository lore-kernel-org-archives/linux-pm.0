From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 10:50:27 +0100
Message-ID: <56A0A9E3.2070306@linaro.org>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
 <20160120190718.GS6357@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1601202050050.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37157 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759067AbcAUJua (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 04:50:30 -0500
Received: by mail-wm0-f48.google.com with SMTP id n5so71239804wmn.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2016 01:50:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601202050050.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/20/2016 08:57 PM, Thomas Gleixner wrote:
> On Wed, 20 Jan 2016, Peter Zijlstra wrote:
>
>> On Wed, Jan 20, 2016 at 05:00:32PM +0100, Daniel Lezcano wrote:
>>> +++ b/kernel/irq/handle.c
>>> @@ -165,6 +165,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_=
desc *desc)
>>>   			/* Fall through to add to randomness */
>>>   		case IRQ_HANDLED:
>>>   			flags |=3D action->flags;
>>> +			handle_irqtiming(irq, action->dev_id);
>>>   			break;
>>>
>>>   		default:
>>
>>> +++ b/kernel/irq/internals.h
>>
>>> +static inline void handle_irqtiming(unsigned int irq, void *dev_id=
)
>>> +{
>>> +	if (__irqtimings->handler)
>>> +		__irqtimings->handler(irq, ktime_get(), dev_id);
>>> +}
>>
>> Here too, ktime_get() is daft.
>
> What's the problem? ktime_xxx() itself or just the clock monotonic va=
riant?
>
> On 99.9999% of the platforms ktime_get_mono_fast/raw_fast is not any =
slower
> than sched_clock(). The only case where sched_clock is faster is if y=
our TSC
> is buggered and the box switches to HPET for timekeeping.
>
> But I wonder, whether this couldn't do with jiffies in the first plac=
e. If the
> interrupt comes faster than a jiffie then you hardly go into some int=
eresting
> power state, but I might be wrong as usual :)
>
>> Also, you really want to take the timestamp _before_ we call the
>> handlers, not after, otherwise you mix in whatever variance exist in=
 the
>> handler duration.
>
> That and we don't want to call it for each handler which returned han=
dled. The
> called code would do two samples in a row for the same interrupt in c=
ase of
> two shared handlers which get raised at the same time. Not very likel=
y, but
> possible.

Actually, the handle passes dev_id in order to let the irqtimings to=20
sort out a shared interrupt and prevent double sampling. In other words=
,=20
for shared interrupts, statistics should be per t-uple(irq , dev_id) bu=
t=20
that is something I did not implemented ATM.

IMO, the handler is at the right place. The prediction code does not=20
take care of the shared interrupts yet.

I tried to find a platform with shared interrupts in the ones I have=20
available around me but I did not find any. Are the shared interrupts=20
something used nowadays or coming from legacy hardware ? What is the=20
priority to handle the shared interrupts in the prediction code ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

