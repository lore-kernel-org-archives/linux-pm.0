From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 6 Jan 2016 12:40:17 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35975 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbcAFRkV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 12:40:21 -0500
Received: by mail-qg0-f45.google.com with SMTP id e32so217835609qgf.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2016 09:40:20 -0800 (PST)
In-Reply-To: <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Wed, 6 Jan 2016, Daniel Lezcano wrote:

> Many IRQs are quiet most of the time, or they tend to come in bursts of
> fairly equal time intervals within each burst. It is therefore possible
> to detect those IRQs with stable intervals and guestimate when the next
> IRQ event is most likely to happen.
> 
> Examples of such IRQs may include audio related IRQs where the FIFO size
> and/or DMA descriptor size with the sample rate create stable intervals,
> block devices during large data transfers, etc.  Even network streaming
> of multimedia content creates patterns of periodic network interface IRQs
> in some cases.
> 
> This patch adds code to track the mean interval and variance for each IRQ
> over a window of time intervals between IRQ events. Those statistics can
> be used to assist cpuidle in selecting the most appropriate sleep state
> by predicting the most likely time for the next interrupt.
> 
> Because the stats are gathered in interrupt context, the core computation
> is as light as possible.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

There are still a few problems with this patch.

Please see comments below.

> ---
>  drivers/cpuidle/Kconfig   |   5 +
>  kernel/irq/Kconfig        |   1 -
>  kernel/sched/Makefile     |   1 +
>  kernel/sched/idle-sched.c | 549 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 555 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/sched/idle-sched.c
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 8c7930b..dd17215 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -25,6 +25,11 @@ config CPU_IDLE_GOV_MENU
>  	bool "Menu governor (for tickless system)"
>  	default y
>  
> +config CPU_IDLE_GOV_SCHED
> +	bool "Sched idle governor"
> +	select IRQ_TIMINGS
> +	default y
> +
>  config DT_IDLE_STATES
>  	bool
>  
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 1275fd1..81557ae 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -75,7 +75,6 @@ config HANDLE_DOMAIN_IRQ
>  
>  config IRQ_TIMINGS
>          bool
> -	default y
>  
>  config IRQ_DOMAIN_DEBUG
>  	bool "Expose hardware/virtual IRQ mapping via debugfs"
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index 6768797..f7d5a35 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
>  obj-$(CONFIG_SCHEDSTATS) += stats.o
>  obj-$(CONFIG_SCHED_DEBUG) += debug.o
>  obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
> +obj-$(CONFIG_CPU_IDLE_GOV_SCHED) += idle-sched.o
> diff --git a/kernel/sched/idle-sched.c b/kernel/sched/idle-sched.c
> new file mode 100644
> index 0000000..a8e7557
> --- /dev/null
> +++ b/kernel/sched/idle-sched.c
> @@ -0,0 +1,549 @@
> +/*
> + *  Copyright (C) 2016 Linaro Ltd, Daniel Lezcano <daniel.lezcano@linaro.org>
> + *                                 Nicolas Pitre <nicolas.pitre@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/cpuidle.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdesc.h>
> +#include <linux/ktime.h>
> +#include <linux/slab.h>
> +#include <linux/tick.h>
> +#include <linux/time64.h>
> +
> +/*
> + * Define the number of samples over which the average and variance
> + * are computed. A power of 2 is preferred so to let the compiler
> + * optimize divisions by that number with simple arithmetic shifts.
> + */
> +#define STATS_NR_VALUES 4
> +
> +/**
> + * struct stats - internal structure to encapsulate stats informations
> + *
> + * @sum: sum of the values
> + * @values: array of values to do stats on
> + * @n: current number of values
> + * @w_ptr: current buffer pointer
> + */
> +struct stats {
> +	u64          sum;                     /* sum of values */
> +	u32          values[STATS_NR_VALUES]; /* array of values */
> +	unsigned int w_ptr;                   /* current window pointer */
> +};
> +
> +/**
> + * struct wakeup - internal structure describing a source of wakeup
> + *
> + * @stats: the stats structure on the different event intervals
> + * @timestamp: latest update timestamp
> + */
> +struct wakeup {
> +	struct stats stats;
> +	ktime_t timestamp;
> +};
> +
> +/*
> + * Per cpu and irq statistics. Each cpu receives interrupts and those
> + * ones can be distributed following an irq chip specific
> + * algorithm. Random irq distribution is the worst case to predict
> + * interruption behavior but usually that does not happen or could be
> + * fixed from userspace by setting the irq affinity.
> + */
> +static DEFINE_PER_CPU(struct wakeup, *wakeups[NR_IRQS]);
> +
> +/**
> + * stats_add - add a new value in the statistic structure
> + *
> + * @s: the statistic structure
> + * @value: the new value to be added
> + *
> + * Adds the value to the array, if the array is full, the oldest value
> + * is replaced.
> + */
> +static void stats_add(int irq, struct stats *s, u32 value)
> +{
> +	/*
> +	 * This is a circular buffer, so the oldest value is
> +	 * the next one in the buffer. Let's compute the next
> +	 * pointer to retrieve the oldest value and re-use it
> +	 * to update the w_ptr after adding the new value.
> +	 */
> +	unsigned int w_ptr = s->w_ptr;
> +
> +	/*
> +	 * Remove the oldest value from the summing. If this is the
> +	 * first time we go through this array slot, the previous
> +	 * value will be zero and we won't substract anything from the
> +	 * current sum.  Hence this code relies on a zero-ed stat
> +	 * structure at init time via memset or kzalloc.
> +	 */
> +	s->sum -= s->values[w_ptr];
> +	s->values[w_ptr] = value;
> +	s->w_ptr = (w_ptr + 1) % STATS_NR_VALUES;
> +
> +        /*
> +	 * In order to reduce the overhead and to prevent value
> +	 * derivation due to the integer computation, we just sum the
> +	 * value and do the division when the average and the variance
> +	 * are requested.
> +         */
> +	s->sum += value;
> +}
> +
> +/**
> + * stats_reset - reset the stats
> + *
> + * @s: the statistic structure
> + *
> + * Reset the statistics and reset the values
> + */
> +static inline void stats_reset(struct stats *s)
> +{
> +	memset(s, 0, sizeof(*s));
> +}
> +
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
> +	 *
> +	 * The number of values could have not reached STATS_NR_VALUES
> +	 * yet, but we can consider it acceptable as the situation is
> +	 * only at the very first beginning in the system life cycle.
> +	 */
> +	return s->sum / STATS_NR_VALUES;
> +}
> +
> +/**
> + * stats_variance - compute the variance
> + *
> + * @s: the statistic structure
> + *
> + * Returns an u64 corresponding to the variance, or zero if there is
> + * no data
> + */
> +static u64 stats_variance(struct stats *s, u32 mean)
> +{
> +	int i;
> +	u64 variance = 0;
> +
> +	/*
> +	 * The variance is the sum of the squared difference to the
> +	 * average divided by the number of elements.
> +	 */
> +	for (i = 0; i < STATS_NR_VALUES; i++) {
> +		s32 diff = s->values[i] - mean;
> +		variance += (u64)diff * diff;

Strictly speaking, diff should be casted to s64 as it is a signed value 
that may actually be negative.  Because of the strange C type promotion 
rules, the generated code appears correct (at least on ARM), but it 
would be clearer to use s64 anyway.

The product will end up being positive in all cases of course so 
variance may remain as a u64.

> +	}
> +
> +	return variance / STATS_NR_VALUES;
> +}
> +
> +/**
> + * sched_idle_irq - irq timestamp callback
> + *
> + * @irq: the irq number
> + * @timestamp: when the interrupt occured
> + * @dev_id: device id for shared interrupt (not yet used)
> + * @data: private data given when registering this callback
> + *
> + * Interrupt callback called when an interrupt happens. This function
> + * is critical as it is called under an interrupt section: minimum
> + * operations as possible are done here:
> + */
> +static void sched_idle_irq(unsigned int irq, ktime_t timestamp,
> +			   void *dev_id, void *data)
> +{
> +	u32 diff;
> +	unsigned int cpu = raw_smp_processor_id();
> +	struct wakeup *w = per_cpu(wakeups[irq], cpu);
> +
> +	if (!w)
> +		return;
> +
> +	/*
> +	 * It is the first time the interrupt occurs of the series, we
> +	 * can't do any stats as we don't have an interval, just store
> +	 * the timestamp and exit.
> +	 */
> +	if (ktime_equal(w->timestamp, ktime_set(0, 0))) {
> +		w->timestamp = timestamp;
> +		return;
> +	}
> +
> +	/*
> +	 * Microsec resolution is enough for our purpose.
> +	 */
> +	diff = ktime_us_delta(timestamp, w->timestamp);
> +	w->timestamp = timestamp;
> +	stats_add(irq, &w->stats, diff);
> +}
> +
> +/*
> + * Callback to be called when an interrupt happens.
> + */
> +static struct irqtimings irq_timings = {
> +	.handler = sched_idle_irq,
> +};
> +
> +static ktime_t next_irq_event(void)
> +{
> +	unsigned int irq, cpu = raw_smp_processor_id();
> +	ktime_t diff, next, min = { .tv64 = KTIME_MAX };

To avoid exposing the ktime_t definition, you should use 
ktime_set(KTIME_SEC_MAX, 0) instead of { .tv64 = KTIME_MAX }.

> +	struct wakeup *w;
> +	u32 interval, mean;
> +	u64 variance;
> +
> +	/*
> +	 * Lookup the interrupt array for this cpu and search for the
> +	 * earlier expected interruption.
> +	 */
> +        for (irq = 0; irq < NR_IRQS; irq++) {
> +
> +		ktime_t now = ktime_get();

ktime_get() is potentially non-trivial. It should be plenty good enough 
to call it only once outside the loop.

> +		w = per_cpu(wakeups[irq], cpu);
> +
> +		/*
> +		 * The interrupt was not setup as a source of a wakeup
> +		 * or the wakeup source is not considered at this
> +		 * moment stable enough to do a prediction.
> +		 */
> +		if (!w)
> +			continue;
> +
> +		/*
> +		 * No statistics available yet.
> +		 */
> +		if (ktime_equal(w->timestamp, ktime_set(0, 0)))
> +			continue;
> +
> +		diff = ktime_sub(now, w->timestamp);
> +
> +		/*
> +		 * There is no point attempting predictions on interrupts more
> +		 * than 1 second apart. This has no benefit for sleep state
> +		 * selection and increases the risk of overflowing our variance
> +		 * computation. Reset all stats in that case.
> +		 */
> +		if (unlikely(ktime_after(diff, ktime_set(1, 0)))) {
> +			stats_reset(&w->stats);
> +			continue;
> +		}

The above is wrong. It is not computing the interval between successive 
interruts but rather the interval between the last interrupt occurrence 
and the present time (i.e. when we're about to go idle).  This won't 
prevent interrupt intervals greater than one second from being summed 
and potentially overflowing the variance if this code is executed less 
than a second after one such IRQ interval.  This test should rather be 
performed in sched_idle_irq().

> +		 * If the mean value is null, just ignore this wakeup
> +		 * source.
> +		 */
> +		mean = stats_mean(&w->stats);
> +		if (!mean)
> +			continue;
> +
> +		variance = stats_variance(&w->stats, mean);
> +		/*
> +		 * We want to check the last interval is:
> +		 *
> +		 *  mean - stddev < interval < mean + stddev
> +		 *
> +		 * That simplifies to:
> +		 *
> +		 * -stddev < interval - mean < stddev
> +		 *
> +		 * abs(interval - mean) < stddev
> +		 *
> +		 * The standard deviation is the sqrt of the variance:
> +		 *
> +		 * abs(interval - mean) < sqrt(variance)
> +		 *
> +		 * and we want to prevent to do an sqrt, so we square
> +		 * the equation:
> +		 *
> +		 * (interval - mean)^2 < variance
> +		 *
> +		 * So if the latest value of the stats complies with
> +		 * this condition, then the wakeup source is
> +		 * considered predictable and can be used to predict
> +		 * the next event.
> +		 */
> +		interval = w->stats.values[(w->stats.w_ptr + 1) % STATS_NR_VALUES];

But here (w->stats.w_ptr + 1) % STATS_NR_VALUES does not point at the 
last interval. It rather points at the second oldest.

To make things simpler, you should rather pre-increment the pointer 
before updating the array in stats_add(), and here the value you want 
will directly be accessible with w->stats.values[w->stats.w_ptr].

> +		if ((u64)((interval - mean) * (interval - mean)) > variance)
> +			continue;

Same comment as in stats_variance(): this should be s64.

> +		/*
> +		 * Let's compute the next event: the wakeup source is
> +		 * considered predictable, we add the average interval
> +		 * time added to the latest interruption event time.
> +		 */
> +		next = ktime_add_us(w->timestamp, stats_mean(&w->stats));
> +
> +		/*
> +		 * If the interrupt is supposed to happen before the
> +		 * minimum time, then it becomes the minimum.
> +		 */
> +		if (ktime_before(next, min))
> +			min = next;
> +	}
> +
> +	/*
> +	 * At this point, we have our prediction but the caller is
> +	 * expecting the remaining time before the next event, so
> +	 * compute the expected sleep length.
> +	 */
> +	diff = ktime_sub(min, ktime_get());

You should use the variable 'now' rather than asking for the current 
time again.

> +	/*
> +	 * The result could be negative for different reasons:
> +	 *  - the prediction is incorrect
> +	 *  - the prediction was too near now and expired while we were
> +	 *    in this function
> +	 *
> +	 * In both cases, we return KTIME_MAX as a failure to do a
> +	 * prediction
> +	 */
> +	if (ktime_compare(diff, ktime_set(0, 0)) <= 0)
> +		return (ktime_t){ .tv64 = KTIME_MAX };

See my comment about ktime_t internals at the beginning of this 
function.

> +
> +	return diff;
> +}
> +
> +/**
> + * sched_idle_next_wakeup - Predict the next wakeup on the current cpu
> + *
> + * The next event on the cpu is based on a statistic approach of the
> + * interrupt events and the timer deterministic value. From the timer
> + * or the irqs, we return the one expected to occur first.
> + *
> + * Returns the expected remaining idle time before being woken up by
> + * an interruption.
> + */
> +s64 sched_idle_next_wakeup(void)
> +{
> +	s64 next_timer = ktime_to_us(tick_nohz_get_sleep_length());
> +	s64 next_irq = ktime_to_us(next_irq_event());
> +
> +	return min(next_irq, next_timer);
> +}
> +
> +/**
> + * sched_idle - go to idle for a specified amount of time
> + *
> + * @duration: the idle duration time
> + * @latency: the latency constraint
> + *
> + * Returns 0 on success, < 0 otherwise.
> + */
> +int sched_idle(s64 duration, unsigned int latency)
> +{
> +	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
> +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +	struct cpuidle_state_usage *su;
> +	struct cpuidle_state *s;
> +	int i, ret = 0, index = -1;
> +
> +	rcu_idle_enter();
> +
> +	/*
> +	 * No cpuidle driver is available, let's use the default arch
> +	 * idle function.
> +	 */
> +	if (cpuidle_not_available(drv, dev))
> +		goto default_idle;
> +
> +	/*
> +	 * Find the idle state with the lowest power while satisfying
> +	 * our constraints. We will save energy if the duration of the
> +	 * idle time is bigger than the target residency which is the
> +	 * break even point. The choice will be modulated by the
> +	 * latency.
> +	 */
> +	for (i = 0; i < drv->state_count; i++) {
> +
> +		s = &drv->states[i];
> +
> +		su = &dev->states_usage[i];
> +
> +		if (s->disabled || su->disable)
> +			continue;
> +		if (s->target_residency > duration)
> +			continue;
> +		if (s->exit_latency > latency)
> +			continue;
> +
> +		index = i;
> +	}
> +
> +	/*
> +	 * The idle task must be scheduled, it is pointless to go to
> +	 * idle, just re-enable the interrupt and return.
> +	 */
> +	if (current_clr_polling_and_test()) {
> +		local_irq_enable();
> +		goto out;
> +	}
> +
> +	if (index < 0) {
> +		/*
> +		 * No idle callbacks fulfilled the constraints, jump
> +		 * to the default function like there wasn't any
> +		 * cpuidle driver.
> +		 */
> +		goto default_idle;
> +	} else {
> +		/*
> +		 * Enter the idle state previously returned by the
> +		 * governor decision.  This function will block until
> +		 * an interrupt occurs and will take care of
> +		 * re-enabling the local interrupts
> +		 */
> +		return cpuidle_enter(drv, dev, index);
> +	}
> +
> +default_idle:
> +	default_idle_call();
> +out:
> +	rcu_idle_exit();
> +	return ret;
> +}
> +
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
> +	struct wakeup *w;
> +	unsigned int cpu;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +	desc->timings = NULL;
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +
> +	for_each_possible_cpu(cpu) {
> +		w = per_cpu(wakeups[irq], cpu);
> +		if (!w)
> +			continue;
> +
> +		per_cpu(wakeups[irq], cpu) = NULL;
> +		kfree(w);
> +	}
> +}
> +
> +/**
> + * sched_irq_timing_setup - setup_irq callback
> + *
> + * @irq: the interrupt numbe to be tracked
> + * @act: the new irq action to be set to this interrupt
> + *
> + * Update the irq table to be tracked in order to predict the next event.
> + *
> + * Returns zero on success. On error it returns -ENOMEM.
> + */
> +static int sched_irq_timing_setup(unsigned int irq, struct irqaction *act)
> +{
> +	struct irq_desc *desc = irq_to_desc(irq);
> +	struct wakeup *w;
> +	unsigned int cpu;
> +	unsigned long flags;
> +	int ret = -ENOMEM;
> +
> +	/*
> +	 * No interrupt set for this descriptor or related to a timer.
> +	 * Timers are deterministic, so no need to try to do any
> +	 * prediction on them. No error for both cases, we are just not
> +	 * interested.
> +	 */
> +	if (!act || (act->flags & __IRQF_TIMER))
> +		return 0;
> +
> +	/*
> +	 * Allocates the wakeup structure and the stats structure. As
> +	 * the interrupt can occur on any cpu, allocate the wakeup
> +	 * structure per cpu basis.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +
> +		w = kzalloc(sizeof(*w), GFP_KERNEL);
> +		if (!w)
> +			goto undo;
> +
> +		per_cpu(wakeups[irq], cpu) = w;
> +	}
> +
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +	desc->timings = &irq_timings;
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +
> +	ret = 0;
> +undo:
> +	/*
> +	 * Rollback all allocations on failure
> +	 */
> +	if (ret)
> +		sched_irq_timing_free(irq, act->dev_id);
> +
> +	return ret;
> +}
> +
> +/*
> + * Setup/free irq callbacks
> + */
> +static struct irqtimings_ops irqt_ops = {
> +	.setup = sched_irq_timing_setup,
> +	.free = sched_irq_timing_free,
> +};
> +
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
> +
> +	/*
> +	 * For all the irq already setup, assign the timing callback.
> +	 * All interrupts with their desc NULL will be discarded.
> +	 */
> +	for_each_irq_desc(irq, desc)
> +		sched_irq_timing_setup(irq, desc->action);
> +
> +	return 0;
> +}
> +late_initcall(sched_idle_init);
> -- 
> 1.9.1
> 
> 
