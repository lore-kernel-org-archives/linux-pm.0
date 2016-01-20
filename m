From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 20 Jan 2016 19:44:14 +0100
Message-ID: <20160120184414.GQ6357@twins.programming.kicks-ass.net>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.20.1601201212170.2140@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56713 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbcATSoT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 13:44:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1601201212170.2140@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

On Wed, Jan 20, 2016 at 12:46:48PM -0500, Nicolas Pitre wrote:
> > +struct stats {
> > +	u64           sum;                     /* sum of values */
> > +	u32           values[STATS_NR_VALUES]; /* array of values */
> > +	unsigned char w_ptr;                   /* current window pointer */
> 
> Why did you change this from an unsigned int?
> 
> This won't provide any memory space saving given that the structure has 
> to be padded up to the next 64-bit boundary.

Not to mention that loading bytes is more expensive on many archs
compared to full words.

Also, its not a pointer, its an index.

So:	unsigned int w_idx;
