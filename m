From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 12 Jan 2016 15:26:21 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601121523070.3575@nanos>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.11.1601081631380.3575@nanos> <5694F490.3040300@linaro.org> <alpine.DEB.2.11.1601121441330.3575@nanos>
 <56950ACC.4090001@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56950ACC.4090001@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Jan 2016, Daniel Lezcano wrote:
> On 01/12/2016 02:42 PM, Thomas Gleixner wrote:
> > On Tue, 12 Jan 2016, Daniel Lezcano wrote:
> > > On 01/08/2016 04:43 PM, Thomas Gleixner wrote:
> > > > > +	/*
> > > > > +	 * Register the setup/free irq callbacks, so new interrupt or
> > > > > +	 * freed interrupt will update their tracking.
> > > > > +	 */
> > > > > +	ret = register_irq_timings(&irqt_ops);
> > > > > +	if (ret) {
> > > > > +		pr_err("Failed to register timings ops\n");
> > > > > +		return ret;
> > > > > +	}
> > > > 
> > > > So that stuff is installed unconditionally. Is it used unconditionally
> > > > as
> > > > well?
> > > 
> > > Sorry, I am not sure to understand your question. If the kernel is
> > > compiled
> > > with CONFIG_CPU_IDLE_GOV_SCHED=y, this code is enabled and use the irq
> > > timings. The condition comes from the compilation option.
> > 
> > The question is whether the option also activates that thing or is there
> > still
> > some /sys/whatever/idlegov magic where you can (de)select it.
> 
> Yes, in the next patches of the series I did not send, we can switch to the
> cpuidle's governor framework or idle-sched. I will look at how to disable it
> when switching to the cpuidle's governors.

You better implement the switching part in the cpuidle core first, i.e. proper
callbacks when a governor is switched in/out. Then make use of this switcheroo
right away. Doing it the other way round is just wrong.

Thanks,

	tglx
