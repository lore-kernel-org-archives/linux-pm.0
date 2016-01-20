From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 14:17:57 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1601201408430.2140@knanqh.ubzr>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org> <20160120190205.GR6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34169 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbcATTSA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 14:18:00 -0500
Received: by mail-qg0-f52.google.com with SMTP id 6so14175570qgy.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 11:18:00 -0800 (PST)
In-Reply-To: <20160120190205.GR6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Wed, 20 Jan 2016, Peter Zijlstra wrote:

> On Wed, Jan 20, 2016 at 05:00:33PM +0100, Daniel Lezcano wrote:
> > +static void sched_irq_timing_handler(unsigned int irq, ktime_t timestamp, void *dev_id)
> > +{
> > +	u32 diff;
> > +	unsigned int cpu = raw_smp_processor_id();
> > +	struct wakeup *w = per_cpu(wakeups[irq], cpu);
> > +
> > +	/*
> > +	 * It is the first time the interrupt occurs of the series, we
> > +	 * can't do any stats as we don't have an interval, just store
> > +	 * the timestamp and exit.
> > +	 */
> > +	if (ktime_equal(w->timestamp, ktime_set(0, 0))) {
> > +		w->timestamp = timestamp;
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Microsec resolution is enough for our purpose.
> > +	 */
> 
> It is also a friggin pointless /1000. The cpuidle code also loves to do
> this, and its silly, u64 add/sub are _way_ cheaper than u64 / 1000.

For the purpose of this code, nanoseconds simply provides too many bits 
for what we care.  Computing the variance implies squared values.

*However* we can simply do diff = (timestamp - w->timestamp) >> 10 
instead.  No need to have an exact microsecs base.

> > +	ktime_t now = ktime_get();
> 
> Why !?! do we care about NTP correct timestamps?

Not at all. Using sched_clock() instead would be more than good enough 
indeed.


Nicolas
