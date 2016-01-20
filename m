From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Wed, 20 Jan 2016 15:04:55 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1601201502080.2140@knanqh.ubzr>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org> <20160120190718.GS6357@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1601202050050.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601202050050.3575@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Jan 2016, Thomas Gleixner wrote:

> On Wed, 20 Jan 2016, Peter Zijlstra wrote:
> 
> > On Wed, Jan 20, 2016 at 05:00:32PM +0100, Daniel Lezcano wrote:
> > > +++ b/kernel/irq/handle.c
> > > @@ -165,6 +165,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
> > >  			/* Fall through to add to randomness */
> > >  		case IRQ_HANDLED:
> > >  			flags |= action->flags;
> > > +			handle_irqtiming(irq, action->dev_id);
> > >  			break;
> > >  
> > >  		default:
> > 
> > > +++ b/kernel/irq/internals.h
> > 
> > > +static inline void handle_irqtiming(unsigned int irq, void *dev_id)
> > > +{
> > > +	if (__irqtimings->handler)
> > > +		__irqtimings->handler(irq, ktime_get(), dev_id);
> > > +}
> > 
> > Here too, ktime_get() is daft.
> 
> What's the problem? ktime_xxx() itself or just the clock monotonic variant?
> 
> On 99.9999% of the platforms ktime_get_mono_fast/raw_fast is not any slower
> than sched_clock(). The only case where sched_clock is faster is if your TSC
> is buggered and the box switches to HPET for timekeeping.
> 
> But I wonder, whether this couldn't do with jiffies in the first place. If the
> interrupt comes faster than a jiffie then you hardly go into some interesting
> power state, but I might be wrong as usual :)

Jiffies are not precise enough for some power states, even more so with 
HZ = 100 on many platforms.


Nicolas
