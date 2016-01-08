From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/2] irq: Add a framework to measure interrupt
 timings
Date: Fri, 8 Jan 2016 16:31:22 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601081616530.3575@nanos>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38570 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbcAHPcT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 10:32:19 -0500
In-Reply-To: <1452093774-17831-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, 6 Jan 2016, Daniel Lezcano wrote:
> +#ifdef CONFIG_IRQ_TIMINGS
> +/**
> + * timing handler to be called when an interrupt happens
> + */
> +typedef void (*irqt_handler_t)(unsigned int, ktime_t, void *, void *);
> +
> +/**
> + * struct irqtimings - per interrupt irq timings descriptor
> + * @handler:   interrupt handler timings function
> + * @data:      pointer to the private data to be passed to the handler
> + * @timestamp: latest interruption occurence

There is no timestamp member.

> + */
> +struct irqtimings {
> +	irqt_handler_t	  handler;
> +	void              *data;

What's that data thingy for. The proposed user does not use it at all and I
have no idea why any user would want it. All it does is provide another level
of indirection in the hotpath.

> +} ____cacheline_internodealigned_in_smp;

> +/**
> + * struct irqt_ops - structure to be used by the subsystem to call the
> + * register and unregister ops when an irq is setup or freed.
> + * @setup: registering callback
> + * @free: unregistering callback
> + *
> + * The callbacks assumes the lock is held on the irq desc

Crap. It's called outside of the locked region and the proposed user locks the
descriptor itself, but that's a different story.

> +static inline void free_irq_timings(unsigned int irq, void *dev_id)
> +{
> +	;

What's the purpose of this semicolon?

> +#ifdef CONFIG_IRQ_TIMINGS
> +void handle_irqt_event(struct irqtimings *irqt, struct irqaction *action)

static ?

> +{
> +	if (irqt)

This want's to use a static key.

> +		irqt->handler(action->irq, ktime_get(),
> +			      action->dev_id, irqt->data);
> +}
> +#else
> +#define handle_irqt_event(a, b)

static inline stub if at all.

> +#ifdef CONFIG_IRQ_TIMINGS
> +/*
> + * Global variable, only used by accessor functions, currently only
> + * one user is allowed ...

That variable is static not global. And what the heck means:

>                         ... and it is up to the caller to make sure to
> + * setup the irq timings which are already setup.

-ENOPARSE.

> + */
> +static struct irqtimings_ops *irqtimings_ops;
> +
> +/**
> + * register_irq_timings - register the ops when an irq is setup or freed
> + *
> + * @ops: the register/unregister ops to be called when at setup or
> + * free time
> + *
> + * Returns -EBUSY if the slot is already in use, zero on success.
> + */
> +int register_irq_timings(struct irqtimings_ops *ops)
> +{
> +	if (irqtimings_ops)
> +		return -EBUSY;
> +
> +	irqtimings_ops = ops;
> +
> +	return 0;
> +}
> +
> +/**
> + * setup_irq_timings - call the timing register callback
> + *
> + * @desc: an irq desc structure

The argument list tells a different story.

> + *
> + * Returns -EINVAL in case of error, zero on success.
> + */
> +int setup_irq_timings(unsigned int irq, struct irqaction *act)

static is not in your book, right? These functions are only used in this file,
so no point for having them global visible and the stubs should be local as
well.

> +{
> +	if (irqtimings_ops && irqtimings_ops->setup)
> +		return irqtimings_ops->setup(irq, act);
> +	return 0;
> +}

...

> @@ -1408,6 +1469,8 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
>  
>  	unregister_handler_proc(irq, action);
>  
> +	free_irq_timings(irq, dev_id);

This needs to go to the point where the interrupt is already synchronized and
the action about to be destroyed.

Thanks,

	tglx
