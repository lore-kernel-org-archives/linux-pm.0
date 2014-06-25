From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH v5 4/8] arm64: add PSCI CPU_SUSPEND based cpu_suspend
 support
Date: Wed, 25 Jun 2014 13:52:00 -0700
Message-ID: <1403729520.11749.64.camel@smoke>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
	 <1403705421-17597-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41784 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbaFYUwE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 16:52:04 -0400
In-Reply-To: <1403705421-17597-5-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, Nicolas Pitre <nico@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Chander Kashyap <chander.kashyap@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Brown <broonie@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Antti Miettinen <ananaza@iki.fi>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm>

Hi Lorenzo,

On Wed, 2014-06-25 at 15:10 +0100, Lorenzo Pieralisi wrote:
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c

> +	/*
> +	 * This is belt-and-braces: make sure that if the idle
> +	 * specified protocol is psci, the cpu_ops have been
> +	 * initialized to psci operations. Anything else is
> +	 * a recipe for mayhem.
> +	 */
> +	for_each_cpu(cpu, drv->cpumask) {
> +		cpu_ops_ptr = cpu_ops[cpu];
> +		if (WARN_ON(!cpu_ops_ptr || strcmp(cpu_ops_ptr->name, "psci")))
> +			return -EOPNOTSUPP;
> +	}

I'm not sure how drv->cpumask is setup, but if a system has mixed enable
methods, say some cpus 'spin-table' and some 'psci', will this give a
false error?

If drv->cpumask should only include 'psci' cpus, then should this be a
BUG()?

> +
> +	psci_states = kcalloc(drv->state_count, sizeof(*psci_states),
> +			      GFP_KERNEL);
> +
> +	if (!psci_states) {
> +		pr_warn("psci idle state allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	for_each_cpu(cpu, drv->cpumask) {
> +		if (per_cpu(psci_power_state, cpu)) {
> +			pr_warn("idle states already initialized on cpu %u\n",
> +				cpu);

This seems like an implementation problem, if so, shouldn't this be
pr_debug()?


>  #endif
>  
> +#ifdef CONFIG_ARM64_CPU_SUSPEND
> +static int cpu_psci_cpu_suspend(unsigned long index)
> +{
> +	struct psci_power_state *state = __get_cpu_var(psci_power_state);
> +
> +	if (!state)
> +		return -EOPNOTSUPP;
> +
> +	return psci_ops.cpu_suspend(state[index], virt_to_phys(cpu_resume));
> +}
> +#endif

Why not put a __maybe_unused attribute on cpu_psci_cpu_suspend() and
remove the preprocessor conditional.  That way this code will always be
compiled, and with therefor always get a build test.  The linker should
strip out the unused code when CONFIG_ARM64_CPU_SUSPEND=n and the code
below is not compiled. 

> +#ifdef CONFIG_ARM64_CPU_SUSPEND
> +	.cpu_suspend	= cpu_psci_cpu_suspend,
> +#endif
>  };

-Geoff

