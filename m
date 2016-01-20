From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Wed, 20 Jan 2016 21:22:14 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601202121490.3575@nanos>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org> <20160120190718.GS6357@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1601202050050.3575@nanos>
 <20160120202014.GK6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33574 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbcATUXS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 15:23:18 -0500
In-Reply-To: <20160120202014.GK6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Wed, 20 Jan 2016, Peter Zijlstra wrote:

> On Wed, Jan 20, 2016 at 08:57:06PM +0100, Thomas Gleixner wrote:
> > > Here too, ktime_get() is daft.
> > 
> > What's the problem? ktime_xxx() itself or just the clock monotonic variant?
> > 
> > On 99.9999% of the platforms ktime_get_mono_fast/raw_fast is not any slower
> > than sched_clock(). The only case where sched_clock is faster is if your TSC
> > is buggered and the box switches to HPET for timekeeping.
> 
> The HPET thing, I just don't want to have to explain why this is so much
> more expensive on some random weird machine, esp. since it really
> doesn't matter.

Fair enough.
