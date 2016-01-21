From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 10:25:56 +0100
Message-ID: <56A0A424.80306@linaro.org>
References: <alpine.DEB.2.11.1601201634520.3575@nanos>
 <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601201847050.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34995 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757467AbcAUJZ7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 04:25:59 -0500
Received: by mail-wm0-f53.google.com with SMTP id r129so163735232wmr.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2016 01:25:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601201847050.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/20/2016 06:55 PM, Thomas Gleixner wrote:
> On Wed, 20 Jan 2016, Daniel Lezcano wrote:
>> +#ifdef CONFIG_IRQ_TIMINGS
>> +/**
>> + * struct irqt_ops - structure to be used by the subsystem to track
>> + *                   irq timings
>> + * @alloc:    called when an irqdesc is allocated
>> + * @free:     called when an irqdesc is free
>> + * @setup:    called when an irq is setup, this is called under loc=
k
>> + * @remove:   called when an irq is removed
>> + * @handler:  called when an interrupt is handled
>> + */
>> +struct irqtimings_ops {
>> +	int (*alloc)(unsigned int);
>> +	void (*free)(unsigned int);
>> +	int (*setup)(unsigned int, struct irqaction *act);
>> +	void (*remove)(unsigned int, void *dev_id);
>> +	irqt_handler_t handler;
>> +};
>> +
>> +/**
>> + * This macro *must* be used by the subsystem interested by the irq
>> + * timing information.
>> + */
>> +#define DECLARE_IRQ_TIMINGS(__ops)				\
>> +	const struct irqtimings_ops *__irqtimings =3D __ops;
>> +#endif
>
>> @@ -20,6 +20,49 @@ extern bool noirqdebug;
>>
>>   extern struct irqaction chained_action;
>>
>> +#ifdef CONFIG_IRQ_TIMINGS
>> +
>> +extern const struct irqtimings_ops *__irqtimings;
>> +
>> +static inline int alloc_irqtiming(unsigned int irq)
>> +{
>> +	if (__irqtimings->alloc)
>> +		return __irqtimings->alloc(irq);
>
> I really have a hard time to understand that indirection. __irqtiming=
s is
> statically allocated and compiled in. There can be only one user for =
this in
> the system ever and that user has all callbacks populated.
>
> Why can't you spare all that pointer muck and simply have:
>
> #ifdef CONFIG_IRQ_TIMINGS
> int irqtiming_alloc(usigned int irq);
> ....
> #else
> static int irqtiming_alloc(usigned int irq) { return 0; }
> ...
> #endif
>
> and implement those functions in your idle thingy?

Hi Thomas,

yes sure, I can do something simpler.

Just to be sure, do you suggest to put the function declaration in=20
kernel/irq/internal.h and the function definition in=20
kernel/sched/idle-sched.c ?

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

