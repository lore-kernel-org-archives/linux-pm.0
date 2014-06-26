From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 4/8] arm64: add PSCI CPU_SUSPEND based cpu_suspend
 support
Date: Thu, 26 Jun 2014 17:55:05 +0100
Message-ID: <20140626165505.GD27364@e102568-lin.cambridge.arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-5-git-send-email-lorenzo.pieralisi@arm.com>
 <1403729520.11749.64.camel@smoke>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59837 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853AbaFZQzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jun 2014 12:55:11 -0400
In-Reply-To: <1403729520.11749.64.camel@smoke>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geoff Levand <geoff@infradead.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, Nicolas Pitre <nico@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Chander Kashyap <chander.kashyap@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Brown <broonie@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>

Hi Geoff,

On Wed, Jun 25, 2014 at 09:52:00PM +0100, Geoff Levand wrote:
> Hi Lorenzo,
> 
> On Wed, 2014-06-25 at 15:10 +0100, Lorenzo Pieralisi wrote:
> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> 
> > +	/*
> > +	 * This is belt-and-braces: make sure that if the idle
> > +	 * specified protocol is psci, the cpu_ops have been
> > +	 * initialized to psci operations. Anything else is
> > +	 * a recipe for mayhem.
> > +	 */
> > +	for_each_cpu(cpu, drv->cpumask) {
> > +		cpu_ops_ptr = cpu_ops[cpu];
> > +		if (WARN_ON(!cpu_ops_ptr || strcmp(cpu_ops_ptr->name, "psci")))
> > +			return -EOPNOTSUPP;
> > +	}
> 
> I'm not sure how drv->cpumask is setup, but if a system has mixed enable
> methods, say some cpus 'spin-table' and some 'psci', will this give a
> false error?

I do not think that's a false error. If the idle states specify an
entry-method == psci, and cpu_ops for some cpus are not set to PSCI,
obviously because the enable-method specified that, that's a firmware bug.

> If drv->cpumask should only include 'psci' cpus, then should this be a
> BUG()?

Ok, if we got here, it is because the idle-states entry-method was set
to PSCI. Now, if any of the CPUs in the driver mask has a cpu_ops
pointer != PSCI, we have a problem and we should warn on that. I do
not think that justifies a BUG_ON, but that's one of those things, it is
debatable.

Question is whether the check should also be carried out at cpu_ops
initialization (ie to check for mixed cpu_ops), for certain if the
idle states entry-method is PSCI and cpu_ops != PSCI we should
WARN/BUG on that. Or embed this idle state parameters initialization at
cpu_ops init (see other thread you started) so that we can kill two
birds with one stone.

> > +
> > +	psci_states = kcalloc(drv->state_count, sizeof(*psci_states),
> > +			      GFP_KERNEL);
> > +
> > +	if (!psci_states) {
> > +		pr_warn("psci idle state allocation failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for_each_cpu(cpu, drv->cpumask) {
> > +		if (per_cpu(psci_power_state, cpu)) {
> > +			pr_warn("idle states already initialized on cpu %u\n",
> > +				cpu);
> 
> This seems like an implementation problem, if so, shouldn't this be
> pr_debug()?

Maybe, I will give it some thought.

> >  #endif
> >  
> > +#ifdef CONFIG_ARM64_CPU_SUSPEND
> > +static int cpu_psci_cpu_suspend(unsigned long index)
> > +{
> > +	struct psci_power_state *state = __get_cpu_var(psci_power_state);
> > +
> > +	if (!state)
> > +		return -EOPNOTSUPP;
> > +
> > +	return psci_ops.cpu_suspend(state[index], virt_to_phys(cpu_resume));
> > +}
> > +#endif
> 
> Why not put a __maybe_unused attribute on cpu_psci_cpu_suspend() and
> remove the preprocessor conditional.  That way this code will always be
> compiled, and with therefor always get a build test.  The linker should
> strip out the unused code when CONFIG_ARM64_CPU_SUSPEND=n and the code
> below is not compiled. 

It can make sense, yes.

Thanks,
Lorenzo

