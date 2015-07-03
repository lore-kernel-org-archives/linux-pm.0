From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 2/4] ARM: mvebu: Add standby support
Date: Fri, 03 Jul 2015 13:39:49 +0200
Message-ID: <55967485.2010607@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>	<1435684740-24912-3-git-send-email-gregory.clement@free-electrons.com> <20150701174709.2d55007d@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34442 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754689AbbGCLjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 07:39:52 -0400
In-Reply-To: <20150701174709.2d55007d@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Thomas,

On 01/07/2015 17:47, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Tue, 30 Jun 2015 19:18:58 +0200, Gregory CLEMENT wrote:
>> Until now only one Armada XP and one Armada 388 based board supported
>> suspend to ram. However, most of the recent mvebu SoCs can support the
>> standby mode. Unlike for the suspend to ram, nothing special have to
> 
> have -> has
> 
>> be done for these SoCs. This patch allows the system to use the
>> standby mode on Armada 370, 38x, 39x and XP SoCs. There are issues
>> with the Armada 375, and the support would be added (if possible) in a
> 
> would -> might
> 
>> future patch.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/mach-mvebu/common.h   |  5 ++--
>>  arch/arm/mach-mvebu/pm-board.c | 17 ++++++++-----
>>  arch/arm/mach-mvebu/pm.c       | 57 ++++++++++++++++++++++++++++++++++++------
>>  3 files changed, 64 insertions(+), 15 deletions(-)
> 
> On the implementation side, this is much more complicated that it needs
> to be I believe. You don't need this mechanism to register the
> board-specific hook. Just make pm.c register the suspend_ops in a
> late_initcall(), and the pm-board.c register the board specific hook in
> a late_initcall(), and have pm.c say that it supports suspend to RAM
> only if the board-specific hook has been registered.

Having 2 initcall does not work because, there is a dependency between these
2 calls. And actually the suspend_ops is registered before the board specific
hook. As soon as the suspend_ops is registered, mvebu_pm_valid() is called but
at this point mvebu_board_pm_enter is NULL so PM_SUSPEND_MEM is not available.

All the complexity of the original patch was to allow registering a handler
without needed to get the resource(gpio device) that are not available when using
arch_initcall(). However the device_initcall_sync comes latter enough to
get all the devices registered but it still happens before the late_initcall,
so I will use this one and I will add a comment around it.

Thanks,

Gregory


> 
> Something like the below (only compile tested, not runtime tested) :
> 
> commit 0b74c5b2916cb4be216bd2c607faf5c10a482284
> Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Date:   Tue Jun 30 19:18:58 2015 +0200
> 
>     ARM: mvebu: Add standby support
>     
>     Until now only one Armada XP and one Armada 388 based board supported
>     suspend to ram. However, most of the recent mvebu SoCs can support the
>     standby mode. Unlike for the suspend to ram, nothing special have to
>     be done for these SoCs. This patch allows the system to use the
>     standby mode on Armada 370, 38x, 39x and XP SoCs. There are issues
>     with the Armada 375, and the support would be added (if possible) in a
>     future patch.
>     
>     Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index 3e0aca1..6b77549 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -25,6 +25,6 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
>  
>  void __iomem *mvebu_get_scu_base(void);
>  
> -int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd));
> -
> +int mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
> +							u32 srcmd));
>  #endif
> diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
> index acc69e3..4dccc64 100644
> --- a/arch/arm/mach-mvebu/pm-board.c
> +++ b/arch/arm/mach-mvebu/pm-board.c
> @@ -135,7 +135,7 @@ static int __init mvebu_armada_pm_init(void)
>  	if (!gpio_ctrl)
>  		return -ENOMEM;
>  
> -	mvebu_pm_init(mvebu_armada_pm_enter);
> +	mvebu_pm_suspend_init(mvebu_armada_pm_enter);
>  
>  out:
>  	of_node_put(np);
> diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
> index f249c8e..db31cbb 100644
> --- a/arch/arm/mach-mvebu/pm.c
> +++ b/arch/arm/mach-mvebu/pm.c
> @@ -204,13 +204,10 @@ static int mvebu_pm_store_bootinfo(void)
>  	return 0;
>  }
>  
> -static int mvebu_pm_enter(suspend_state_t state)
> +static int mvebu_enter_suspend(void)
>  {
>  	int ret;
>  
> -	if (state != PM_SUSPEND_MEM)
> -		return -EINVAL;
> -
>  	ret = mvebu_pm_store_bootinfo();
>  	if (ret)
>  		return ret;
> @@ -226,16 +223,57 @@ static int mvebu_pm_enter(suspend_state_t state)
>  	set_cpu_coherent();
>  
>  	cpu_pm_exit();
> +	return 0;
> +}
> +
> +static int mvebu_pm_enter(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +		cpu_do_idle();
> +		break;
> +	case PM_SUSPEND_MEM:
> +		return mvebu_enter_suspend();
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int mvebu_pm_valid(suspend_state_t state)
> +{
> +	if (state == PM_SUSPEND_STANDBY)
> +		return 1;
> +
> +	if (state == PM_SUSPEND_MEM && mvebu_board_pm_enter != NULL)
> +		return 1;
>  
>  	return 0;
>  }
>  
>  static const struct platform_suspend_ops mvebu_pm_ops = {
>  	.enter = mvebu_pm_enter,
> -	.valid = suspend_valid_only_mem,
> +	.valid = mvebu_pm_valid,
>  };
>  
> -int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
> +static int __init mvebu_pm_init(void)
> +{
> +	if (!of_machine_is_compatible("marvell,armadaxp") &&
> +	    !of_machine_is_compatible("marvell,armada370") &&
> +	    !of_machine_is_compatible("marvell,armada380") &&
> +	    !of_machine_is_compatible("marvell,armada390"))
> +		return -ENODEV;
> +
> +	suspend_set_ops(&mvebu_pm_ops);
> +
> +	return 0;
> +}
> +
> +
> +late_initcall(mvebu_pm_init);
> +
> +int __init mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
> +							u32 srcmd))
>  {
>  	struct device_node *np;
>  	struct resource res;
> @@ -267,7 +305,5 @@ int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 src
>  
>  	mvebu_board_pm_enter = board_pm_enter;
>  
> -	suspend_set_ops(&mvebu_pm_ops);
> -
>  	return 0;
>  }
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
