From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 14:42:58 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601121441330.3575@nanos>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.11.1601081631380.3575@nanos> <5694F490.3040300@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38635 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbcALNn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 08:43:58 -0500
In-Reply-To: <5694F490.3040300@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Tue, 12 Jan 2016, Daniel Lezcano wrote:
> On 01/08/2016 04:43 PM, Thomas Gleixner wrote:
> > > +	/*
> > > +	 * Register the setup/free irq callbacks, so new interrupt or
> > > +	 * freed interrupt will update their tracking.
> > > +	 */
> > > +	ret = register_irq_timings(&irqt_ops);
> > > +	if (ret) {
> > > +		pr_err("Failed to register timings ops\n");
> > > +		return ret;
> > > +	}
> > 
> > So that stuff is installed unconditionally. Is it used unconditionally as
> > well?
> 
> Sorry, I am not sure to understand your question. If the kernel is compiled
> with CONFIG_CPU_IDLE_GOV_SCHED=y, this code is enabled and use the irq
> timings. The condition comes from the compilation option.

The question is whether the option also activates that thing or is there still
some /sys/whatever/idlegov magic where you can (de)select it.

Thanks,

	tglx
