From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 15/16] ARM: mvebu: Add CPU idle support for Armada 38x
Date: Mon, 30 Jun 2014 17:07:41 +0200
Message-ID: <20140630170741.73256ba0@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-16-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55739 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005AbaF3PHp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 11:07:45 -0400
In-Reply-To: <1403875377-940-16-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Gregory,

On Fri, 27 Jun 2014 15:22:56 +0200, Gregory CLEMENT wrote:

> Unlike the Armada XP and the Armada 370, this SoC uses a Cortex A9
> core.

Isn't there some more details missing in this sentence? When I read it,
at the end of the sentence, I'm wondering "and so what? what does this
implies in terms of cpuidle support?".

> Beside this, the main difference for the cpu idle is the way to
> handle the L2 cache and the use of SCU.

Beside -> Besides.

of SCU -> of the SCU

> +static void __iomem *scu_base;

It's really a shame that the SCU driver isn't a driver on its own,
capable of storing the base address of the SCU instead of having to
pass it around everywhere. But for sure it's not the point of this
patch series to improve this as well.

>  static struct platform_device mvebu_v7_cpuidle_device = {
> @@ -151,6 +168,7 @@ static int __init mvebu_v7_pmsu_init(void)
>  				np->full_name)) {
>  		pr_err("unable to request region\n");
>  		ret = -EBUSY;
> +

This change.

>  		goto out;
>  	}
>  
> @@ -163,7 +181,6 @@ static int __init mvebu_v7_pmsu_init(void)
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -

And this one look like spurious changes not related to the patch.

>   out:
>  	of_node_put(np);
>  	return ret;
> @@ -260,6 +277,27 @@ static int armada_xp_370_cpu_suspend(unsigned long deepidle)
>  	return cpu_suspend(deepidle, do_armada_xp_370_cpu_suspend);
>  }
>  
> +static noinline int do_armada_38x_cpu_suspend(unsigned long deepidle)
> +{
> +	mvebu_v7_pmsu_idle_prepare(deepidle, false);
> +	/*
> +	 * Already flushed cache, but do it again as the outer cache
> +	 * functions dirty the cache with spinlocks
> +	 */
> +	v7_exit_coherency_flush(louis);
> +
> +	scu_power_mode(scu_base, SCU_PM_POWEROFF);
> +
> +	cpu_do_idle();

I see cpu_do_idle() does dsb() and wfi(), so why don't we use in the
do_armada_370_xp_cpu_suspend() function ?

> +
> +	return 1;

You return 1 here, but in the do_armada_370_xp_cpu_suspend() function
you return zero. Is the return value being used? Why use 0 in one case
and 1 in the other?

> +}
> +
> +static int armada_38x_cpu_suspend(unsigned long deepidle)
> +{
> +	return cpu_suspend(false, do_armada_38x_cpu_suspend);
> +}
> +
>  /* No locking is needed because we only access per-CPU registers */
>  static noinline void mvebu_v7_pmsu_idle_restore(void)
>  {
> @@ -268,7 +306,6 @@ static noinline void mvebu_v7_pmsu_idle_restore(void)
>  
>  	if (pmsu_mp_base == NULL)
>  		return;
> -

Spurious change.

>  	/* cancel ask HW to power down the L2 Cache if possible */
>  	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
>  	reg &= ~PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
> @@ -320,6 +357,23 @@ static struct mvebu_v7_cpuidle armada_370_cpuidle = {
>  	.mvebu_v7_cpu_suspend = armada_xp_370_cpu_suspend,
>  };
>  
> +static struct mvebu_v7_cpuidle armada_38x_cpuidle = {
> +	.mvebu_v7_idle_driver = {
> +		.name			= "armada_38x_idle",
> +		.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +		.states[1]		= {
> +			.exit_latency		= 10,
> +			.power_usage		= 5,
> +			.target_residency	= 100,
> +			.flags			= CPUIDLE_FLAG_TIME_VALID,
> +			.name			= "Idle",
> +			.desc			= "CPU and SCU power down",
> +		},
> +		.state_count = 2,
> +	},
> +	.mvebu_v7_cpu_suspend = armada_38x_cpu_suspend,
> +};

Should go to the cpuidle driver, IMO.

>  static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
>  	.mvebu_v7_idle_driver = {
>  		.name			= "armada_xp_idle",
> @@ -371,6 +425,46 @@ static __init bool armada_370_cpuidle_init(void)
>  	return true;
>  }
>  
> +static __init bool armada_38x_cpuidle_init(void)

As mentioned earlier, this function should return an 'int'.

> +{
> +	struct device_node *np;
> +	void __iomem *mpsoc_base;
> +	u32 reg;
> +
> +	np = of_find_compatible_node(NULL, NULL,
> +				"marvell,armada-380-coherency-fabric");
> +	if (!np)
> +		return false;

		return -ENODEV;

> +	of_node_put(np);
> +
> +	np = of_find_compatible_node(NULL, NULL,
> +				"marvell,armada-380-mpcore-soc-ctrl");
> +	if (!np)
> +		return false;

		return -ENODEV;

> +	mpsoc_base = of_iomap(np, 0);
> +	WARN_ON(!mpsoc_base);

WARN_ON() seems a bit weak for something that will make the next line
crash the kernel. What about:

	if (!mpsoc_base)
		return -ENOMEM;

I think the of_node_put(np) should be here.

> +
> +	/* Set up reset mask when powering down the cpus */
> +	reg = readl(mpsoc_base + MPCORE_RESET_CTL);
> +	reg |= MPCORE_RESET_CTL_L2;
> +	reg |= MPCORE_RESET_CTL_DEBUG;
> +	writel(reg, mpsoc_base + MPCORE_RESET_CTL);
> +	iounmap(mpsoc_base);
> +	of_node_put(np);
> +
> +	/* Set up delay */
> +	reg = readl(pmsu_mp_base + PMSU_POWERDOWN_DELAY);
> +	reg &= ~PMSU_POWERDOWN_DELAY_MASK;
> +	reg |= PMSU_DFLT_ARMADA38X_DELAY;
> +	reg |= PMSU_POWERDOWN_DELAY_PMU;
> +	writel(reg, pmsu_mp_base + PMSU_POWERDOWN_DELAY);
> +
> +	scu_base = mvebu_get_scu_base();
> +	mvebu_cpu_resume = armada_38x_cpu_resume;
> +	mvebu_v7_cpuidle_device.dev.platform_data = &armada_38x_cpuidle;
> +	return true;

	return 0;

> +}
> +
>  static __init bool armada_xp_cpuidle_init(void)
>  {
>  	struct device_node *np;
> @@ -391,6 +485,9 @@ static struct of_device_id of_cpuidle_table[] __initdata = {
>  	{ .compatible = "marvell,armada370",
>  	  .data = (void *)armada_370_cpuidle_init,
>  	},
> +	{ .compatible = "marvell,armada380",
> +	  .data = (void *)armada_38x_cpuidle_init,
> +	},

As mentioned in the comments to a previous commit, I'm not sure using a
match table is the best idea here.

>  	{ /* end of list */ },
>  };
>  
> diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
> index 3b702a16bd3d..15b823dff61a 100644
> --- a/arch/arm/mach-mvebu/pmsu_ll.S
> +++ b/arch/arm/mach-mvebu/pmsu_ll.S
> @@ -23,6 +23,20 @@ ARM_BE8(setend	be )			@ go BE8 if entered LE
>  	b	cpu_resume
>  ENDPROC(armada_370_xp_cpu_resume)
>  
> +ENTRY(armada_38x_cpu_resume)
> +	/* do we need it for Armada 38x*/
> +ARM_BE8(setend	be )			@ go BE8 if entered LE

Yes, I believe we will need it. I'll try to do some testing and report.

> +	bl	v7_invalidate_l1
> +	mrc     p15, 4, r1, c15, c0	@ get SCU base address
> +	orr	r1, r1, #0x8		@ SCU CPU Power Status Register
> +	mrc	15, 0, r0, cr0, cr0, 5	@ get the CPU ID
> +	and	r0, r0, #15
> +	add	r1, r1, r0
> +	mov	r0, #0x0
> +	strb	r0, [r1]		@ switch SCU power state to Normal mode
> +	b	cpu_resume
> +ENDPROC(armada_38x_cpu_resume)
> +
>  .global mvebu_boot_wa_start
>  .global mvebu_boot_wa_end
>  

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
