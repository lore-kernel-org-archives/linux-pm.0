From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 20:49:43 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601201856040.3575@nanos>
References: <alpine.DEB.2.11.1601201634520.3575@nanos> <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33431 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbcATTur (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:50:47 -0500
In-Reply-To: <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, 20 Jan 2016, Daniel Lezcano wrote:
> +/*
> + * Per cpu and irq statistics. Each cpu receives interrupts and those
> + * ones can be distributed following an irq chip specific
> + * algorithm. Random irq distribution is the worst case to predict
> + * interruption behavior but usually that does not happen or could be
> + * fixed from userspace by setting the irq affinity.
> + */
> +static DEFINE_PER_CPU(struct wakeup, *wakeups[NR_IRQS]);

That does not work with sparse irqs. With sparse irqs NR_IRQS can be very
small and the core can expand up to NR_IRQS + 8196

> +static DECLARE_BITMAP(enabled_irq, NR_IRQS);

Ditto.

> +static void stats_add(struct stats *s, u32 value)
> +{
> +	/*
> +	 * This is a circular buffer, so the oldest value is the next
> +	 * one in the buffer. Let's compute the next pointer to
> +	 * retrieve the oldest value and re-use it to update the w_ptr
> +	 * after adding the new value.
> +	 */
> +	s->w_ptr = (s->w_ptr + 1) % STATS_NR_VALUES;

I rather have that an explicit '& STATS_NR_MASK' here and some enforcement
that STATS_NR_VALUES is a power of two.

> +/**
> + * stats_mean - compute the average
> + *
> + * @s: the statistics structure
> + *
> + * Returns an u32 corresponding to the mean value, or zero if there is
> + * no data
> + */
> +static inline u32 stats_mean(struct stats *s)
> +{
> +	/*
> +	 * gcc is smart enough to convert to a bits shift when the
> +	 * divisor is constant and multiple of 2^x.

Instead of adding those comments everywhere, you just could use a shift value,
which naturally enforces the power of 2 of STATS_NR_VALUES

> +	 *
> +	 * The number of values could have not reached STATS_NR_VALUES
> +	 * yet, but we can consider it acceptable as the situation is
> +	 * only at the beginning of the burst of irqs.
> +	 */
> +	return s->sum / STATS_NR_VALUES;
> +}

> +/**
> + * sched_idle_irq - irq timestamp callback

There is a way to actually compile KernelDoc ....

> + *
> + * @irq: the irq number
> + * @timestamp: when the interrupt occured
> + * @dev_id: device id for shared interrupt (not yet used)

What is it going to be used for?

> +	/*
> +	 * Microsec resolution is enough for our purpose.
> +	 */
> +	diff = ktime_us_delta(timestamp, w->timestamp);

You force a division by 1000 here. Storing the nsec values is way cheaper. If
you really need to make it smaller for computational reasons, then use a shift
value. There is no requirement for this to be precise.

> +static ktime_t next_irq_event(void)
> +{
> +	unsigned int irq, cpu = raw_smp_processor_id();
> +	ktime_t diff, next, min = ktime_set(KTIME_SEC_MAX, 0);
> +	ktime_t now = ktime_get();
> +	struct wakeup *w;
> +	u32 interval, mean;
> +	u64 variance;
> +
> +	/*
> +	 * Lookup the interrupt array for this cpu and search for the
> +	 * earlier expected interruption.
> +	 */
> +	for (irq = 0; irq < NR_IRQS; irq = find_next_bit(enabled_irq, NR_IRQS, irq)) {

Again. This cannot work. 

1) NR_IRQS is the wrong thing to look at.

2) It's racy against a concurrent teardown of interrupts.

> +		w = per_cpu(wakeups[irq], cpu);
> +
> +		/*
> +		 * The interrupt was not setup as a source of a wakeup
> +		 * or the wakeup source is not considered at this
> +		 * moment stable enough to do a prediction.
> +		 */
> +		if (!w)
> +			continue;

That comment makes no sense whatsoever. You look at the data which you
allocated from __setup_irq(). So how is that related?

> +/**
> + * sched_irq_timing_remove - disable the tracking of the specified irq
> + *
> + * Clear the irq table slot to stop tracking the interrupt.
> + *
> + * @irq: the irq number to stop tracking
> + * @dev_id: the device id for shared irq
> + *
> + * This function will remove from the wakeup source prediction table.
> + */
> +static void sched_irq_timing_remove(unsigned int irq, void *dev_id)
> +{
> +	clear_bit(irq, enabled_irq);
> +}
> +
> +/**
> + * sched_irq_timing_setup - enable the tracking of the specified irq
> + *
> + * Function is called with the corresponding irqdesc lock taken. It is
> + * not allowed to do any memory allocation or blocking call. Flag the
> + * irq table slot to be tracked in order to predict the next event.
> + *
> + * @irq: the interrupt numbe to be tracked
> + * @act: the new irq action to be set to this interrupt
> + *
> + * Returns zero on success, < 0 otherwise.
> + */
> +static int sched_irq_timing_setup(unsigned int irq, struct irqaction *act)
> +{
> +	/*
> +	 * No interrupt set for this descriptor or related to a timer.
> +	 * Timers are deterministic, so no need to try to do any
> +	 * prediction on them. No error for both cases, we are just not
> +	 * interested.
> +	 */
> +	if (!(act->flags & __IRQF_TIMER))
> +		return 0;

Well, you do not make any predicitions, but you allocate the data and do
sampling ...

> +
> +	set_bit(irq, enabled_irq);
> +
> +	return 0;
> +}

These two are required for what? The callsite is broken as well. You call
setup() for the first action of an irq and remove() for any action which gets
torn down. That does not make any sense at all.

> +/**
> + * sched_irq_timing_free - free memory previously allocated
> + *
> + * @irq: the interrupt number
> + */
> +static void sched_irq_timing_free(unsigned int irq)
> +{
> +	struct wakeup *w;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +
> +		w = per_cpu(wakeups[irq], cpu);
> +		if (!w)
> +			continue;
> +
> +		per_cpu(wakeups[irq], cpu) = NULL;
> +		kfree(w);

Your simple array does not work. You need a radix_tree to handle SPARSE_IRQ
and you need proper protection against teardown.

So we can avoid all that stuff and simply stick that data into irqdesc and let
the core handle it. That allows us to use proper percpu allocations and avoid
that for_each_possible_cpu() sillyness.

That leaves the iterator, but that's a solvable problem. We simply can have an
iterator function in the irq core, which gives you the next sample
structure. Something like this:

struct irqtiming_sample *irqtiming_get_next(int *irq)
{
	struct irq_desc *desc;
	int next;

	/* Do a racy lookup of the next allocated irq */
	next = irq_get_next_irq(*irq);
	if (next >= nr_irqs)
	   	 return NULL;

	*irq = next + 1;

	/* Now lookup the descriptor. It's RCU protected. */
	desc = irq_to_desc(next);
	if (!desc || !desc->irqtimings || !(desc->istate & IRQS_TIMING))
	   	 return NULL;

	return this_cpu_ptr(&desc->irqtimings);
}

And that needs to be called rcu protected;

    	 next = 0;
    	 rcu_read_lock();
	 sample = irqtiming_get_next(&next);
	 while (sample) {
	       ....
	       sample = irqtiming_get_next(&next);
	 }
    	 rcu_read_unlock();

So the interrupt part becomes:

         if (desc->istate & IRQS_TIMING)
	       	 irqtimings_handle(__this_cpu_ptr(&desc->irqtimings));

So now for the allocation/free of that data. We simply allocate/free it along
with the irq descriptor. That IRQS_TIMING bit gets set in __setup_irq() except
for timer interrupts. That's simple and avoid _all_ the issues.

Thanks,

	tglx
