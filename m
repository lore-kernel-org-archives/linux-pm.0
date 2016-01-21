From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 14:52:31 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601211128240.3873@nanos>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org> <20160120190718.GS6357@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1601202050050.3575@nanos>
 <56A0A9E3.2070306@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38235 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759002AbcAUNxd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 08:53:33 -0500
In-Reply-To: <56A0A9E3.2070306@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Thu, 21 Jan 2016, Daniel Lezcano wrote:
> On 01/20/2016 08:57 PM, Thomas Gleixner wrote:
> > That and we don't want to call it for each handler which returned handled.
> > The
> > called code would do two samples in a row for the same interrupt in case of
> > two shared handlers which get raised at the same time. Not very likely, but
> > possible.
> 
> Actually, the handle passes dev_id in order to let the irqtimings to sort out
> a shared interrupt and prevent double sampling. In other words, for shared
> interrupts, statistics should be per t-uple(irq , dev_id) but that is
> something I did not implemented ATM.

So my comment about double sampling applies.

> IMO, the handler is at the right place. The prediction code does not take care
> of the shared interrupts yet.
> 
> I tried to find a platform with shared interrupts in the ones I have available
> around me but I did not find any. Are the shared interrupts something used
> nowadays or coming from legacy hardware ? What is the priority to handle the
> shared interrupts in the prediction code ?

And why would that thing care about shared interruts at all? It's a legacy
burden and I really don't see a reason why that new thing which is targeted on
modern hardware should deal with them. Just treat them as a single interrupt
for now and be done with it.

Thanks,

	tglx


