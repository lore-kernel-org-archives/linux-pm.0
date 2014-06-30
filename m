From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 14/16] ARM: mvebu: Add CPU idle support for Armada 370
Date: Mon, 30 Jun 2014 15:36:53 +0200
Message-ID: <20140630153653.3f9526ae@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-15-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55009 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752192AbaF3NxF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 09:53:05 -0400
In-Reply-To: <1403875377-940-15-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 15:22:55 +0200, Gregory CLEMENT wrote:
> Unlike the Armada XP the Armada 370 always power done the L2 cache, so

power -> powers
done -> down

> it have only 2 cpuidle states. Thanks to the previous patches, adding

have -> has.

> the support for this new SoCs required only the modification of the

required -> requires.

> architecture specific part.

May not be true if we move the cpuidle states back into the cpuidle
driver, as I suggested in a comment to one of the previous patch.

> The message in case of failure to suspend the system was switched from
> warn to debug. Indeed due to the "slow exit process from the deep idle
> state" in Armada 370, this situation happens quite often. Using the
> _debug version avoids spamming the kernel logs, but still allows to
> enable it if needed.

Is it really expected that the system fails to enter the idle state? I
must say I don't really see the relation with the slow exit from deep
idle state, because the do_armada_xp_370_cpu_suspend() function is only
here to *enter* the idle state, so how is entering the deep idle state
related to an issue when exiting the idle state?


> +static struct mvebu_v7_cpuidle armada_370_cpuidle = {
> +	.mvebu_v7_idle_driver = {
> +		.name			= "armada_370_idle",
> +		.states[0]		= ARM_CPUIDLE_WFI_STATE,
> +		.states[1]		= {
> +			.exit_latency		= 100,
> +			.power_usage		= 5,
> +			.target_residency	= 1000,
> +			.flags			= CPUIDLE_FLAG_TIME_VALID |
> +			MVEBU_V7_FLAG_DEEP_IDLE,
> +			.name			= "Deep Idle",
> +			.desc			= "CPU and L2 Fabric power down",
> +		},
> +		.state_count = 2,
> +	},
> +	.mvebu_v7_cpu_suspend = armada_xp_370_cpu_suspend,
> +};

As I said, I'd prefer to see this in the cpuidle driver.

> +
>  static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
>  	.mvebu_v7_idle_driver = {
>  		.name			= "armada_xp_idle",
> @@ -328,6 +346,31 @@ static struct mvebu_v7_cpuidle armada_xp_cpuidle = {
>  	.mvebu_v7_cpu_suspend = armada_xp_370_cpu_suspend,
>  };
>  
> +static __init bool armada_370_cpuidle_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
> +	if (!np)
> +		return false;
> +	of_node_put(np);
> +
> +	/*
> +	 * On Armada 370, there is "a slow exit process from the deep
> +	 * idle state due to heavy L1/L2 cache cleanup operations
> +	 * performed by the BootROM software". To avoid this, we
> +	 * replace the restart code of the bootrom by a a simple jump
> +	 * to the boot address. Then the code located at this boot
> +	 * address will take care of the initialization.
> +	 */
> +	mvebu_boot_addr_wa(ARMADA_370_CRYPT0_ENG_ID, pmsu_mp_phys_base +
> +			PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));
> +
> +	mvebu_cpu_resume = armada_370_xp_cpu_resume;
> +	mvebu_v7_cpuidle_device.dev.platform_data = &armada_370_cpuidle;
> +	return true;
> +}
> +
>  static __init bool armada_xp_cpuidle_init(void)
>  {
>  	struct device_node *np;
> @@ -345,6 +388,9 @@ static struct of_device_id of_cpuidle_table[] __initdata = {
>  	{ .compatible = "marvell,armadaxp",
>  	  .data = (void *)armada_xp_cpuidle_init,
>  	},
> +	{ .compatible = "marvell,armada370",
> +	  .data = (void *)armada_370_cpuidle_init,
> +	},
>  	{ /* end of list */ },
>  };
>  
> @@ -373,18 +419,6 @@ static int __init mvebu_v7_cpu_pm_init(void)
>  		return 0;
>  	of_node_put(np);
>  
> -	/*
> -	 * On Armada 370, there is "a slow exit process from the deep
> -	 * idle state due to heavy L1/L2 cache cleanup operations
> -	 * performed by the BootROM software". To avoid this, we
> -	 * replace the restart code of the bootrom by a a simple jump
> -	 * to the boot address. Then the code located at this boot
> -	 * address will take care of the initialization.
> -	 */
> -	if (of_machine_is_compatible("marvell,armada370"))
> -		mvebu_boot_addr_wa(ARMADA_370_CRYPT0_ENG_ID, pmsu_mp_phys_base +
> -				PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));

So we're almost entirely reverting/moving the code added by "[PATCH
05/16] ARM: mvebu: Add workaround for cpuidle support for Armada 370".
Maybe there is an issue in your series, and the workaround for cpuidle
support on Armada 370 should only be added in this patch, and not
earlier?

> -
>  	mvebu_v7_pmsu_enable_l2_powerdown_onidle();
>  	platform_device_register(&mvebu_v7_cpuidle_device);
>  	cpu_pm_register_notifier(&mvebu_v7_cpu_pm_notifier);

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
