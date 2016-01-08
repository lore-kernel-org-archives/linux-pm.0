From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Fri, 8 Jan 2016 16:43:57 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601081631380.3575@nanos>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38668 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147AbcAHPox (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 10:44:53 -0500
In-Reply-To: <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, 6 Jan 2016, Daniel Lezcano wrote:
> +/**
> + * sched_irq_timing_free - free_irq callback
> + *
> + * @irq: the irq number to stop tracking
> + * @dev_id: not used at the moment
> + *
> + * This function will remove from the wakeup source prediction table.
> + */
> +static void sched_irq_timing_free(unsigned int irq, void *dev_id)
> +{
> +	struct irq_desc *desc = irq_to_desc(irq);

What has this code to fiddle with irq_desc? Nothing!

> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +	desc->timings = &irq_timings;
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);

Bah, no. This belongs into the core code. Add that handler - and yes, that's
all you need - to your timing_ops and let the core code do it in a proper way.

> +/**
> + * sched_idle_init - setup the interrupt tracking table
> + *
> + * At init time, some interrupts could have been setup and in the
> + * system life time, some devices could be setup. In order to track
> + * all interrupts we are interested in, we first register a couple of
> + * callback to keep up-to-date the interrupt tracking table and then
> + * we setup the table with the interrupt which were already set up.
> + */
> +int __init sched_idle_init(void)
> +{
> +	struct irq_desc *desc;
> +	unsigned int irq;
> +	int ret;
> +
> +	/*
> +	 * Register the setup/free irq callbacks, so new interrupt or
> +	 * freed interrupt will update their tracking.
> +	 */
> +	ret = register_irq_timings(&irqt_ops);
> +	if (ret) {
> +		pr_err("Failed to register timings ops\n");
> +		return ret;
> +	}

So that stuff is installed unconditionally. Is it used unconditionally as
well?

> +	/*
> +	 * For all the irq already setup, assign the timing callback.
> +	 * All interrupts with their desc NULL will be discarded.
> +	 */
> +	for_each_irq_desc(irq, desc)
> +		sched_irq_timing_setup(irq, desc->action);

No, no, no. This belongs into the core code register_irq_timings() function
which installs the handler into the irq descs with the proper protections and
once it has done that enables the static key.

The above is completely unprotected against interrupts being setup or even
freed concurrently.

Aside of that, you call that setup function in setup_irq for each action() and
here you call it only for the first one.

Thanks,

	tglx
