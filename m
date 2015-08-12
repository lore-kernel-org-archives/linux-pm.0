From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 9/9] ARM: smp: Add runtime PM support for CPU hotplug
Date: Wed, 12 Aug 2015 16:47:56 -0700
Message-ID: <20150812234756.GO26614@codeaurora.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55542 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbbHLXr5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 19:47:57 -0400
Content-Disposition: inline
In-Reply-To: <1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 08/04, Lina Iyer wrote:
> @@ -137,7 +138,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
>  
> -

Remove noise please.

>  	memset(&secondary_data, 0, sizeof(secondary_data));
>  	return ret;
>  }
> @@ -205,6 +205,9 @@ int __cpu_disable(void)
>  	unsigned int cpu = smp_processor_id();
>  	int ret;
>  
> +	/* We dont need the CPU device anymore. */
> +	pm_runtime_put_sync(get_cpu_device(cpu));

This is all very generic. Any reason it can't be done at a higher
level for all architectures? It certainly seems like
cpu_startup_entry() could be modifed to do the
pm_runtime_get_sync().

> +
>  	ret = platform_cpu_disable(cpu);
>  	if (ret)
>  		return ret;
> @@ -272,6 +275,13 @@ void __ref cpu_die(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  
> +	/*
> +	 * We dont need the CPU device anymore.
> +	 * Lets do this before IRQs are disabled to allow
> +	 * runtime PM to suspend the domain as well.
> +	 */
> +	pm_runtime_put_sync(get_cpu_device(cpu));

The two put calls is confusing. __cpu_disable() is called on the
CPU that's dying, and cpu_die() is called on the CPU that's doing
the takedown. That would be two decrements but only one increment
in secondary_start_kernel()? How is this properly balanced?

> +
>  	idle_task_exit();
>  
>  	local_irq_disable();
> @@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
>  	local_irq_enable();
>  	local_fiq_enable();
>  
> +	/* We are running, enable runtime PM for the CPU. */
> +	cpu_dev = get_cpu_device(cpu);
> +	if (cpu_dev)
> +		pm_runtime_get_sync(cpu_dev);

Also, where would the dev->power.irq_safe flag be set if we
aren't using the genpd DT stuff? It looks like we're going to
start causing warnings on devices that don't have the DT magic.
Please add a hotplug test with some device that isn't using this
genpd code to catch problems. Also please turn on lockdep and RCU
lockdep, touching the idle code like this

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
