From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 20:02:05 +0100
Message-ID: <20160120190205.GR6357@twins.programming.kicks-ass.net>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59025 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbcATTCL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:02:11 -0500
Content-Disposition: inline
In-Reply-To: <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, Jan 20, 2016 at 05:00:33PM +0100, Daniel Lezcano wrote:
> +static void sched_irq_timing_handler(unsigned int irq, ktime_t timestamp, void *dev_id)
> +{
> +	u32 diff;
> +	unsigned int cpu = raw_smp_processor_id();
> +	struct wakeup *w = per_cpu(wakeups[irq], cpu);
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

It is also a friggin pointless /1000. The cpuidle code also loves to do
this, and its silly, u64 add/sub are _way_ cheaper than u64 / 1000.

> +	diff = ktime_us_delta(timestamp, w->timestamp);
> +	w->timestamp = timestamp;
> +
> +	/*
> +	 * There is no point attempting predictions on interrupts more
> +	 * than ~1 second apart. This has no benefit for sleep state
> +	 * selection and increases the risk of overflowing our variance
> +	 * computation. Reset all stats in that case.
> +	 */
> +	if (diff > (1 << 20)) {
> +		stats_reset(&w->stats);
> +		return;
> +	}
> +
> +	stats_add(&w->stats, diff);
> +}
> +
> +static ktime_t next_irq_event(void)
> +{
> +	unsigned int irq, cpu = raw_smp_processor_id();
> +	ktime_t diff, next, min = ktime_set(KTIME_SEC_MAX, 0);
> +	ktime_t now = ktime_get();

Why !?! do we care about NTP correct timestamps?

ktime_get() can be horrendously slow, don't use it for statistics.

> +		next = ktime_add_us(w->timestamp, stats_mean(&w->stats));
> +	s64 next_timer = ktime_to_us(tick_nohz_get_sleep_length());
> +	s64 next_irq = ktime_to_us(next_irq_event());

more nonsense, just say no.
