From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 14:27:32 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1601121410250.7882@knanqh.ubzr>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.20.1601061156120.1652@knanqh.ubzr> <568E8782.9020401@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:32954 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbcALT1g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 14:27:36 -0500
Received: by mail-qg0-f45.google.com with SMTP id b35so307019974qge.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 11:27:35 -0800 (PST)
In-Reply-To: <568E8782.9020401@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Thu, 7 Jan 2016, Daniel Lezcano wrote:

> On 01/06/2016 06:40 PM, Nicolas Pitre wrote:
> > On Wed, 6 Jan 2016, Daniel Lezcano wrote:
> >
> > > Many IRQs are quiet most of the time, or they tend to come in bursts of
> > > fairly equal time intervals within each burst. It is therefore possible
> > > to detect those IRQs with stable intervals and guestimate when the next
> > > IRQ event is most likely to happen.
> > >
> > > Examples of such IRQs may include audio related IRQs where the FIFO size
> > > and/or DMA descriptor size with the sample rate create stable intervals,
> > > block devices during large data transfers, etc.  Even network streaming
> > > of multimedia content creates patterns of periodic network interface IRQs
> > > in some cases.
> > >
> > > This patch adds code to track the mean interval and variance for each IRQ
> > > over a window of time intervals between IRQ events. Those statistics can
> > > be used to assist cpuidle in selecting the most appropriate sleep state
> > > by predicting the most likely time for the next interrupt.
> > >
> > > Because the stats are gathered in interrupt context, the core computation
> > > is as light as possible.
> > >
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > There are still a few problems with this patch.
> >
> > Please see comments below.
> 
> [ ... ]
> 
> > > +/**
> > > + * stats_variance - compute the variance
> > > + *
> > > + * @s: the statistic structure
> > > + *
> > > + * Returns an u64 corresponding to the variance, or zero if there is
> > > + * no data
> > > + */
> > > +static u64 stats_variance(struct stats *s, u32 mean)
> > > +{
> > > +	int i;
> > > +	u64 variance = 0;
> > > +
> > > +	/*
> > > +	 * The variance is the sum of the squared difference to the
> > > +	 * average divided by the number of elements.
> > > +	 */
> > > +	for (i = 0; i < STATS_NR_VALUES; i++) {
> > > +		s32 diff = s->values[i] - mean;
> > > +		variance += (u64)diff * diff;
> >
> > Strictly speaking, diff should be casted to s64 as it is a signed value
> > that may actually be negative.  Because of the strange C type promotion
> > rules, the generated code appears correct (at least on ARM), but it
> > would be clearer to use s64 anyway.
> 
> I don't get the connection in your explanation of why it should be a s64. It
> is already a signed s32, s->values[] are s32 and mean is u32.
> 
> What would be the benefit to convert diff to s64 ?

Suppose diff ends up being -1. Normally, -1 * -1 = 1.

Now you cast the first term to a 64-bit value so the result of the 
product becomes a 64-bit value to avoid overflows.  However you cast it 
to an _unsigned_ 64-bit value.  Therefore you could expect something 
like 0x00000000ffffffff * -1 would take place and that wouldn't produce 
1 for result at all.

Yet, the C standard is weird and completely unintuitive sometimes.  
Here is an example of such a time.  Even though you cast the first term 
to an unsigned value, the compiler is performing sign extension 
nevertheless.  So casting to u64 or s64 doesn't change anything in 
practice.  But for a human reading the code, using s64 will be more 
intuitive.

> > The product will end up being positive in all cases of course so
> > variance may remain as a u64.
> >
> 
> [ ... ]


Nicolas
