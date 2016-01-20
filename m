From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Wed, 20 Jan 2016 20:57:06 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601202050050.3575@nanos>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org> <20160120190718.GS6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33462 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbcATT6J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:58:09 -0500
In-Reply-To: <20160120190718.GS6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, 20 Jan 2016, Peter Zijlstra wrote:

> On Wed, Jan 20, 2016 at 05:00:32PM +0100, Daniel Lezcano wrote:
> > +++ b/kernel/irq/handle.c
> > @@ -165,6 +165,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
> >  			/* Fall through to add to randomness */
> >  		case IRQ_HANDLED:
> >  			flags |= action->flags;
> > +			handle_irqtiming(irq, action->dev_id);
> >  			break;
> >  
> >  		default:
> 
> > +++ b/kernel/irq/internals.h
> 
> > +static inline void handle_irqtiming(unsigned int irq, void *dev_id)
> > +{
> > +	if (__irqtimings->handler)
> > +		__irqtimings->handler(irq, ktime_get(), dev_id);
> > +}
> 
> Here too, ktime_get() is daft.

What's the problem? ktime_xxx() itself or just the clock monotonic variant?

On 99.9999% of the platforms ktime_get_mono_fast/raw_fast is not any slower
than sched_clock(). The only case where sched_clock is faster is if your TSC
is buggered and the box switches to HPET for timekeeping.

But I wonder, whether this couldn't do with jiffies in the first place. If the
interrupt comes faster than a jiffie then you hardly go into some interesting
power state, but I might be wrong as usual :)

> Also, you really want to take the timestamp _before_ we call the
> handlers, not after, otherwise you mix in whatever variance exist in the
> handler duration.

That and we don't want to call it for each handler which returned handled. The
called code would do two samples in a row for the same interrupt in case of
two shared handlers which get raised at the same time. Not very likely, but
possible.

Thanks,

	tglx

 
