From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Thu, 21 Jan 2016 15:12:07 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601211510500.3873@nanos>
References: <alpine.DEB.2.11.1601201634520.3575@nanos> <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-3-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.11.1601201856040.3575@nanos> <56A0E31A.6020001@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38450 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965270AbcAUONK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 09:13:10 -0500
In-Reply-To: <56A0E31A.6020001@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Thu, 21 Jan 2016, Daniel Lezcano wrote:
> On 01/20/2016 08:49 PM, Thomas Gleixner wrote:
> > So now for the allocation/free of that data. We simply allocate/free it
> > along
> > with the irq descriptor. That IRQS_TIMING bit gets set in __setup_irq()
> > except
> > for timer interrupts. That's simple and avoid _all_ the issues.
> 
> Indeed, making this as part of the irq code makes everything much more simple
> and self contained. For the shared interrupts, shouldn't we put the timings
> samples into the irqaction structure instead of the irqdesc structure ?
> 
> eg.
> 
> #define IRQT_MAX_VALUES 4
> 
> struct irqaction {
> 	...
> #ifdef CONFIG_IRQ_TIMINGS
> 	u32 irqtimings_samples[IRQT_MAX_VALUES];
> #endif
> 	...
> };
> 
> So we don't have to deal with the allocation/free under locks. The drawback is
> the array won't be used in the case of the timers.

I still have to ask the question whether a per device information is useful at
all. I don't see the value, but I might miss something.

Thanks,

	tglx
