From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 08/14] ARM: mvebu: Allow to power down L2 cache
 controller in idle mode
Date: Mon, 14 Oct 2013 16:44:15 +0200
Message-ID: <20131014164415.59e250fb@skate>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
	<1381759106-15004-9-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33165 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755918Ab3JNOoT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 10:44:19 -0400
In-Reply-To: <1381759106-15004-9-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:20 +0200, Gregory CLEMENT wrote:
> This commit adds an exported function which allows to power down the
> L2 cache controller and the Coherency Fabric when the CPU goes into
> deep idle mode.

This comment is slightly misleading I believe: it explains that this
function should be called every time you want to power down the L2
cache and the coherency fabric. However, looking at the cpuidle driver
code, it seems that this function only ever gets called in the
->probe() function, and what it really does is that it adjusts the PMSU
configuration to automatically power down the L2 and coherency fabric
when we enter a certain idle state.

> This feature is part of the Power Management Service Unit of the
> Armada 370 and Armada XP SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu.c         | 14 ++++++++++++++
>  include/linux/armada-370-xp-pmsu.h | 16 ++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 include/linux/armada-370-xp-pmsu.h
> 
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index f6b00fb..445c9a0 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -30,6 +30,9 @@ static void __iomem *pmsu_fabric_base;
>  #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
>  #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
>  
> +#define L2C_NFABRIC_PM_CTL		    0x4
> +#define L2C_NFABRIC_PM_CTL_PWR_DOWN	    BIT(20)
> +
>  static struct of_device_id of_pmsu_table[] = {
>  	{.compatible = "marvell,armada-370-xp-pmsu"},
>  	{ /* end of list */ },
> @@ -78,4 +81,15 @@ int __init armada_370_xp_pmsu_init(void)
>  	return 0;
>  }
>  
> +void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
> +{
> +	int reg;

u32 ?

> +
> +	/* Enable L2 & Fabric powerdown in Deep-Idle mode - Fabric */
> +	reg = readl(pmsu_fabric_base + L2C_NFABRIC_PM_CTL);
> +	reg |= L2C_NFABRIC_PM_CTL_PWR_DOWN;
> +	writel(reg, pmsu_fabric_base + L2C_NFABRIC_PM_CTL);
> +}
> +EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_enable_l2_powerdown_onidle);

We don't need to have thiS EXPORT_SYMBOL_GPL. The cpuidle driver has a
'bool' Kconfig option, so it will also be built into the kernel and
never be built as a module.

I am also wondering if it is really useful to expose this function. If
it's just called at initialization, why not do it in the mach-mvebu
code directly, before registering the cpuidle driver? (I'm not sure
about this one, just proposing, it makes one less SoC-specific function
exposed to the world).

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
