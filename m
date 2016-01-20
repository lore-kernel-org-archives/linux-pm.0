From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Wed, 20 Jan 2016 18:55:48 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601201847050.3575@nanos>
References: <alpine.DEB.2.11.1601201634520.3575@nanos> <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:32925 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934556AbcATR4w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 12:56:52 -0500
In-Reply-To: <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, 20 Jan 2016, Daniel Lezcano wrote:
> +#ifdef CONFIG_IRQ_TIMINGS
> +/**
> + * struct irqt_ops - structure to be used by the subsystem to track
> + *                   irq timings
> + * @alloc:    called when an irqdesc is allocated
> + * @free:     called when an irqdesc is free
> + * @setup:    called when an irq is setup, this is called under lock
> + * @remove:   called when an irq is removed
> + * @handler:  called when an interrupt is handled
> + */
> +struct irqtimings_ops {
> +	int (*alloc)(unsigned int);
> +	void (*free)(unsigned int);
> +	int (*setup)(unsigned int, struct irqaction *act);
> +	void (*remove)(unsigned int, void *dev_id);
> +	irqt_handler_t handler;
> +};
> +
> +/**
> + * This macro *must* be used by the subsystem interested by the irq
> + * timing information.
> + */
> +#define DECLARE_IRQ_TIMINGS(__ops)				\
> +	const struct irqtimings_ops *__irqtimings = __ops;
> +#endif

> @@ -20,6 +20,49 @@ extern bool noirqdebug;
>  
>  extern struct irqaction chained_action;
>  
> +#ifdef CONFIG_IRQ_TIMINGS
> +
> +extern const struct irqtimings_ops *__irqtimings;
> +
> +static inline int alloc_irqtiming(unsigned int irq)
> +{
> +	if (__irqtimings->alloc)
> +		return __irqtimings->alloc(irq);

I really have a hard time to understand that indirection. __irqtimings is
statically allocated and compiled in. There can be only one user for this in
the system ever and that user has all callbacks populated.

Why can't you spare all that pointer muck and simply have:

#ifdef CONFIG_IRQ_TIMINGS
int irqtiming_alloc(usigned int irq);
....
#else
static int irqtiming_alloc(usigned int irq) { return 0; }
...
#endif

and implement those functions in your idle thingy?

Thanks,

	tglx
