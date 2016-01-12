From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 1/2] irq: Add a framework to measure interrupt timings
Date: Tue, 12 Jan 2016 12:42:15 +0100
Message-ID: <5694E697.6020306@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-2-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601081616530.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37745 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbcALLmS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 06:42:18 -0500
Received: by mail-wm0-f41.google.com with SMTP id f206so315522714wmf.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 03:42:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601081616530.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org



Hi Thomas,

thanks for taking some time to review the patches.

On 01/08/2016 04:31 PM, Thomas Gleixner wrote:
> On Wed, 6 Jan 2016, Daniel Lezcano wrote:
>> +#ifdef CONFIG_IRQ_TIMINGS
>> +/**
>> + * timing handler to be called when an interrupt happens
>> + */
>> +typedef void (*irqt_handler_t)(unsigned int, ktime_t, void *, void =
*);
>> +
>> +/**
>> + * struct irqtimings - per interrupt irq timings descriptor
>> + * @handler:   interrupt handler timings function
>> + * @data:      pointer to the private data to be passed to the hand=
ler
>> + * @timestamp: latest interruption occurence
>
> There is no timestamp member.
>
>> + */
>> +struct irqtimings {
>> +	irqt_handler_t	  handler;
>> +	void              *data;
>
> What's that data thingy for. The proposed user does not use it at all=
 and I
> have no idea why any user would want it. All it does is provide anoth=
er level
> of indirection in the hotpath.

Yes, I agree. I added this private_data field for future use in case it=
=20
would be needed but it does not make sense now.

>> +} ____cacheline_internodealigned_in_smp;
>
>> +/**
>> + * struct irqt_ops - structure to be used by the subsystem to call =
the
>> + * register and unregister ops when an irq is setup or freed.
>> + * @setup: registering callback
>> + * @free: unregistering callback
>> + *
>> + * The callbacks assumes the lock is held on the irq desc
>
> Crap. It's called outside of the locked region and the proposed user =
locks the
> descriptor itself, but that's a different story.
>
>> +static inline void free_irq_timings(unsigned int irq, void *dev_id)
>> +{
>> +	;
>
> What's the purpose of this semicolon?

Bah, old habit. I will remove it.

>> +#ifdef CONFIG_IRQ_TIMINGS
>> +void handle_irqt_event(struct irqtimings *irqt, struct irqaction *a=
ction)
>
> static ?
>
>> +{
>> +	if (irqt)
>
> This want's to use a static key.

Ok, I will look at that. I already used static keys to disable a portio=
n=20
of code from sysfs but never this way.

>> +		irqt->handler(action->irq, ktime_get(),
>> +			      action->dev_id, irqt->data);
>> +}
>> +#else
>> +#define handle_irqt_event(a, b)
>
> static inline stub if at all.

ok.

>> +#ifdef CONFIG_IRQ_TIMINGS
>> +/*
>> + * Global variable, only used by accessor functions, currently only
>> + * one user is allowed ...
>
> That variable is static not global. And what the heck means:
>
>>                          ... and it is up to the caller to make sure=
 to
>> + * setup the irq timings which are already setup.
>
> -ENOPARSE.

hmm , yes ... it is not clear :)

I should have say:

"... and it is up to the caller to register the irq timing callback for=
=20
the interrupts which are already setup."

>> + */
>> +static struct irqtimings_ops *irqtimings_ops;
>> +
>> +/**
>> + * register_irq_timings - register the ops when an irq is setup or =
freed
>> + *
>> + * @ops: the register/unregister ops to be called when at setup or
>> + * free time
>> + *
>> + * Returns -EBUSY if the slot is already in use, zero on success.
>> + */
>> +int register_irq_timings(struct irqtimings_ops *ops)
>> +{
>> +	if (irqtimings_ops)
>> +		return -EBUSY;
>> +
>> +	irqtimings_ops =3D ops;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * setup_irq_timings - call the timing register callback
>> + *
>> + * @desc: an irq desc structure
>
> The argument list tells a different story.
>
>> + *
>> + * Returns -EINVAL in case of error, zero on success.
>> + */
>> +int setup_irq_timings(unsigned int irq, struct irqaction *act)
>
> static is not in your book, right? These functions are only used in t=
his file,
> so no point for having them global visible and the stubs should be lo=
cal as
> well.

Ok.

>> +{
>> +	if (irqtimings_ops && irqtimings_ops->setup)
>> +		return irqtimings_ops->setup(irq, act);
>> +	return 0;
>> +}
>
> ...
>
>> @@ -1408,6 +1469,8 @@ static struct irqaction *__free_irq(unsigned i=
nt irq, void *dev_id)
>>
>>   	unregister_handler_proc(irq, action);
>>
>> +	free_irq_timings(irq, dev_id);
>
> This needs to go to the point where the interrupt is already synchron=
ized and
> the action about to be destroyed.

Ok, noted.

Thanks !

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

