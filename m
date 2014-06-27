From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 07/16] ARM: mvebu: Make the CPU idle initialization more
 generic
Date: Fri, 27 Jun 2014 16:15:44 +0200
Message-ID: <53AD7C90.6080600@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com> <1403875377-940-8-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42735 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753173AbaF0OQO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 10:16:14 -0400
In-Reply-To: <1403875377-940-8-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On 27/06/2014 15:22, Gregory CLEMENT wrote:
> In order to support more mvebu SoCs, this patch use an initialization
> specific function associated to each SoCs which support CPU Idle.
> 
> Then each SoC will have his own set of check and of data
> configuration.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu.c | 39 +++++++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 087157c20b8a..454f0f9ede6b 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -293,23 +293,47 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
>  	.notifier_call = mvebu_v7_cpu_pm_notify,
>  };
>  
> +static bool (*mvebu_v7_cpu_idle_init)(void);
> +
> +static __init bool armada_xp_cpuidle_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
> +	if (!np)
> +		return false;
> +	of_node_put(np);
> +
> +	mvebu_v7_cpuidle_device.dev.platform_data = armada_xp_370_cpu_suspend;
> +	return true;
> +}
> +
> +static struct of_device_id of_cpuidle_table[] __initdata = {
> +	{ .compatible = "marvell,armadaxp",
> +	  .data = (void *)armada_xp_cpuidle_init,
> +	},
> +	{ /* end of list */ },
> +};
> +
>  static int __init mvebu_v7_cpu_pm_init(void)
>  {
>  	struct device_node *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_matching_node_and_match(NULL, of_cpuidle_table,
> +					&match);
> +

The following part was missing (without this the kernel hang on Armada 375)

+       if (!np)
+               return 0;



>  
>  	/*
>  	 * Check that all the requirements are available to enable
> -	 * cpuidle. So far, it is only supported on Armada XP, cpuidle
> -	 * needs the coherency fabric and the PMSU enabled
> +	 * cpuidle. Each SoCs comes with its own requirements and
> +	 * configuration
>  	 */
>  
> -	if (!of_machine_is_compatible("marvell,armadaxp"))
> -		return 0;
> +	mvebu_v7_cpu_idle_init = (bool (*)(void))match->data;
>  
> -	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
> -	if (!np)
> +	if (!mvebu_v7_cpu_idle_init())
>  		return 0;
> -	of_node_put(np);
>  
>  	np = of_find_matching_node(NULL, of_pmsu_table);
>  	if (!np)
> @@ -329,7 +353,6 @@ static int __init mvebu_v7_cpu_pm_init(void)
>  				PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));
>  
>  	mvebu_v7_pmsu_enable_l2_powerdown_onidle();
> -	mvebu_v7_cpuidle_device.dev.platform_data = armada_xp_370_cpu_suspend;
>  	platform_device_register(&mvebu_v7_cpuidle_device);
>  	cpu_pm_register_notifier(&mvebu_v7_cpu_pm_notifier);
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
