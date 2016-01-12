From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 13:41:52 +0100
Message-ID: <5694F490.3040300@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
 <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.11.1601081631380.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34069 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbcALMlz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 07:41:55 -0500
Received: by mail-wm0-f48.google.com with SMTP id u188so254129755wmu.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 04:41:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601081631380.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 01/08/2016 04:43 PM, Thomas Gleixner wrote:
> On Wed, 6 Jan 2016, Daniel Lezcano wrote:
>> +/**
>> + * sched_irq_timing_free - free_irq callback
>> + *
>> + * @irq: the irq number to stop tracking
>> + * @dev_id: not used at the moment
>> + *
>> + * This function will remove from the wakeup source prediction tabl=
e.
>> + */
>> +static void sched_irq_timing_free(unsigned int irq, void *dev_id)
>> +{
>> +	struct irq_desc *desc =3D irq_to_desc(irq);
>
> What has this code to fiddle with irq_desc? Nothing!
>
>> +	raw_spin_lock_irqsave(&desc->lock, flags);
>> +	desc->timings =3D &irq_timings;
>> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
>
> Bah, no. This belongs into the core code. Add that handler - and yes,=
 that's
> all you need - to your timing_ops and let the core code do it in a pr=
oper way.

Ah, yes, you are right. That will be much more cleaner.

>> +/**
>> + * sched_idle_init - setup the interrupt tracking table
>> + *
>> + * At init time, some interrupts could have been setup and in the
>> + * system life time, some devices could be setup. In order to track
>> + * all interrupts we are interested in, we first register a couple =
of
>> + * callback to keep up-to-date the interrupt tracking table and the=
n
>> + * we setup the table with the interrupt which were already set up.
>> + */
>> +int __init sched_idle_init(void)
>> +{
>> +	struct irq_desc *desc;
>> +	unsigned int irq;
>> +	int ret;
>> +
>> +	/*
>> +	 * Register the setup/free irq callbacks, so new interrupt or
>> +	 * freed interrupt will update their tracking.
>> +	 */
>> +	ret =3D register_irq_timings(&irqt_ops);
>> +	if (ret) {
>> +		pr_err("Failed to register timings ops\n");
>> +		return ret;
>> +	}
>
> So that stuff is installed unconditionally. Is it used unconditionall=
y as
> well?

Sorry, I am not sure to understand your question. If the kernel is=20
compiled with CONFIG_CPU_IDLE_GOV_SCHED=3Dy, this code is enabled and u=
se=20
the irq timings. The condition comes from the compilation option.

Is that your question ?

>> +	/*
>> +	 * For all the irq already setup, assign the timing callback.
>> +	 * All interrupts with their desc NULL will be discarded.
>> +	 */
>> +	for_each_irq_desc(irq, desc)
>> +		sched_irq_timing_setup(irq, desc->action);
>
> No, no, no. This belongs into the core code register_irq_timings() fu=
nction
> which installs the handler into the irq descs with the proper protect=
ions and
> once it has done that enables the static key.

Ok.

> The above is completely unprotected against interrupts being setup or=
 even
> freed concurrently.

Ok, I will do the change.

> Aside of that, you call that setup function in setup_irq for each act=
ion() and
> here you call it only for the first one.

Ah, right.

Thanks for the review.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

