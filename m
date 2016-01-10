From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Sun, 10 Jan 2016 18:13:10 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1601101805270.7882@knanqh.ubzr>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr> <5692DD19.4010808@linaro.org> <alpine.LFD.2.20.1601101739270.7882@knanqh.ubzr>
 <5692E222.6060905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33872 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757375AbcAJXNN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2016 18:13:13 -0500
Received: by mail-qg0-f48.google.com with SMTP id 6so313251674qgy.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2016 15:13:13 -0800 (PST)
In-Reply-To: <5692E222.6060905@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Sun, 10 Jan 2016, Daniel Lezcano wrote:

> On 01/10/2016 11:46 PM, Nicolas Pitre wrote:
> > On Sun, 10 Jan 2016, Daniel Lezcano wrote:
> >
> > > On 01/06/2016 06:40 PM, Nicolas Pitre wrote:
> > > > On Wed, 6 Jan 2016, Daniel Lezcano wrote:
> > > >
> > > > > Many IRQs are quiet most of the time, or they tend to come in bursts
> > > > > of
> > > > > fairly equal time intervals within each burst. It is therefore
> > > > > possible
> > > > > to detect those IRQs with stable intervals and guestimate when the
> > > > > next
> > > > > IRQ event is most likely to happen.
> > > > >
> > > > > Examples of such IRQs may include audio related IRQs where the FIFO
> > > > > size
> > > > > and/or DMA descriptor size with the sample rate create stable
> > > > > intervals,
> > > > > block devices during large data transfers, etc.  Even network
> > > > > streaming
> > > > > of multimedia content creates patterns of periodic network interface
> > > > > IRQs
> > > > > in some cases.
> > > > >
> > > > > This patch adds code to track the mean interval and variance for each
> > > > > IRQ
> > > > > over a window of time intervals between IRQ events. Those statistics
> > > > > can
> > > > > be used to assist cpuidle in selecting the most appropriate sleep
> > > > > state
> > > > > by predicting the most likely time for the next interrupt.
> > > > >
> > > > > Because the stats are gathered in interrupt context, the core
> > > > > computation
> > > > > is as light as possible.
> > > > >
> > > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >
> > > [ ... ]
> > >
> > > > > +
> > > > > +		diff = ktime_sub(now, w->timestamp);
> > > > > +
> > > > > +		/*
> > > > > +		 * There is no point attempting predictions on
> > > > > interrupts more
> > > > > +		 * than 1 second apart. This has no benefit for sleep
> > > > > state
> > > > > +		 * selection and increases the risk of overflowing our
> > > > > variance
> > > > > +		 * computation. Reset all stats in that case.
> > > > > +		 */
> > > > > +		if (unlikely(ktime_after(diff, ktime_set(1, 0)))) {
> > > > > +			stats_reset(&w->stats);
> > > > > +			continue;
> > > > > +		}
> > > >
> > > > The above is wrong. It is not computing the interval between successive
> > > > interruts but rather the interval between the last interrupt occurrence
> > > > and the present time (i.e. when we're about to go idle).  This won't
> > > > prevent interrupt intervals greater than one second from being summed
> > > > and potentially overflowing the variance if this code is executed less
> > > > than a second after one such IRQ interval.  This test should rather be
> > > > performed in sched_idle_irq().
> > >
> > > Hi Nico,
> > >
> > > I have been through here again and think we should duplicate the test
> > > because
> > > there are two cases:
> > >
> > > 1. We did not go idle and the interval measured in sched_idle_irq is more
> > > than
> > > one second, then the stats are reset. I suggest to use an approximation of
> > > one
> > > second: (diff < (1 << 20)) as we are in the fast
> > > path.
> > >
> > > 2. We are going idle and the latest interrupt happened one second apart
> > > from
> > > now. So we keep the current test.
> >
> > You don't need the current test if the interval is already limited
> > earlier on.  Predictions that would otherwise trip that test will target
> > a time in the past and be discarded.
> 
> Yes, but that wake up source should be discarded in the process of the
> selection, so ignored in the loop, otherwise it can end up as the next event
> (which is obviously wrong) and discarded at the end by returning KTIME_MAX,
> instead of giving the opportunity to find another interrupt as the next event
> with a greater value.

The loop should always discard any prediction for a past time and move 
to the next, not only at the end.

If interrupt stats are not gathered if an interval is greater than one 
second, that means no prediction will ever be more than one second away 
from the last IRQ occurrence.  If you ask for a prediction one second 
after the last IRQ then those predictions will all be in the past.


Nicolas
