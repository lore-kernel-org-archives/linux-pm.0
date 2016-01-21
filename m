From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 10:26:44 +0100
Message-ID: <56A0A454.7020606@linaro.org>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
 <20160120190718.GS6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34683 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759171AbcAUJ0r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 04:26:47 -0500
Received: by mail-wm0-f51.google.com with SMTP id u188so217880249wmu.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2016 01:26:47 -0800 (PST)
In-Reply-To: <20160120190718.GS6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/20/2016 08:07 PM, Peter Zijlstra wrote:
> On Wed, Jan 20, 2016 at 05:00:32PM +0100, Daniel Lezcano wrote:
>> +++ b/kernel/irq/handle.c
>> @@ -165,6 +165,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_d=
esc *desc)
>>   			/* Fall through to add to randomness */
>>   		case IRQ_HANDLED:
>>   			flags |=3D action->flags;
>> +			handle_irqtiming(irq, action->dev_id);
>>   			break;
>>
>>   		default:
>
>> +++ b/kernel/irq/internals.h
>
>> +static inline void handle_irqtiming(unsigned int irq, void *dev_id)
>> +{
>> +	if (__irqtimings->handler)
>> +		__irqtimings->handler(irq, ktime_get(), dev_id);
>> +}
>
> Here too, ktime_get() is daft.
>
> Also, you really want to take the timestamp _before_ we call the
> handlers, not after, otherwise you mix in whatever variance exist in =
the
> handler duration.

Indeed.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

