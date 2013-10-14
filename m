From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 09/14] ARM: mvebu: Add the PMSU related part of the
 cpu idle functions
Date: Mon, 14 Oct 2013 16:54:37 +0200
Message-ID: <20131014165437.72b87ae0@skate>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
	<1381759106-15004-10-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33256 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751704Ab3JNOyn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 10:54:43 -0400
In-Reply-To: <1381759106-15004-10-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:21 +0200, Gregory CLEMENT wrote:
> The cpu idle support will need to access to the Power Management

"to the" -> "the"

> Service Unit. This commit adds and exports the prepare and restore
> functions that will be used by the CPU idle.

CPU idle -> CPU idle driver, or "in the idle path of the cpuidle
driver".

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu.c         | 73 ++++++++++++++++++++++++++++++++++++++
>  include/linux/armada-370-xp-pmsu.h |  2 ++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 445c9a0..d0a02bc 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -30,6 +30,24 @@ static void __iomem *pmsu_fabric_base;
>  #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
>  #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
>  
> +#define PM_CONTROL_AND_CONFIG(cpu)	((cpu * 0x100) + 0x4)
> +#define PM_CONTROL_AND_CONFIG_DFS_REQ		BIT(18)
> +#define PM_CONTROL_AND_CONFIG_PWDDN_REQ	BIT(16)
> +#define PM_CONTROL_AND_CONFIG_L2_PWDDN		BIT(20)
> +
> +#define PM_CPU_POWER_DOWN_CONTROL(cpu)	((cpu * 0x100) + 0x8)
> +
> +#define PM_CPU_POWER_DOWN_DIS_SNP_Q_SKIP	BIT(0)
> +
> +#define PM_STATUS_AND_MASK(cpu)	((cpu * 0x100) + 0xc)
> +#define PM_STATUS_AND_MASK_CPU_IDLE_WAIT	BIT(16)
> +#define PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT	BIT(17)
> +#define PM_STATUS_AND_MASK_IRQ_WAKEUP		BIT(20)
> +#define PM_STATUS_AND_MASK_FIQ_WAKEUP		BIT(21)
> +#define PM_STATUS_AND_MASK_DBG_WAKEUP		BIT(22)
> +#define PM_STATUS_AND_MASK_IRQ_MASK		BIT(24)
> +#define PM_STATUS_AND_MASK_FIQ_MASK		BIT(25)

The other registers are prefixed with PMSU_<something>, why not these
ones? Also, keeping them in increasing offset order seems like a good
idea, so they should be before the PMSU_BOOT_ADDR_REDIRECT_OFFSET
register, which is a cpu * 0x100 + 0x24.

(Yeah, I'm in a nitpicking-mood).

>  #define L2C_NFABRIC_PM_CTL		    0x4
>  #define L2C_NFABRIC_PM_CTL_PWR_DOWN	    BIT(20)
>  
> @@ -92,4 +110,59 @@ void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
>  }
>  EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_enable_l2_powerdown_onidle);
>  
> +void armada_370_xp_pmsu_idle_prepare(bool deepidle)
> +{
> +	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
> +	int reg;
> +	/*

One empty line between variables and the first line of code or comment.

> +	 * Adjust the PMSU configuration to wait for WFI signal, enable
> +	 * IRQ and FIQ as wakeup events, set wait for snoop queue empty
> +	 * indication and mask IRQ and FIQ from CPU
> +	 */
> +	reg = readl(pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
> +	reg |= PM_STATUS_AND_MASK_CPU_IDLE_WAIT    |
> +	       PM_STATUS_AND_MASK_IRQ_WAKEUP       |
> +	       PM_STATUS_AND_MASK_FIQ_WAKEUP       |
> +	       PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT |
> +	       PM_STATUS_AND_MASK_IRQ_MASK         |
> +	       PM_STATUS_AND_MASK_FIQ_MASK;
> +	writel(reg, pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
> +
> +	reg = readl(pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
> +	/* ask HW to power down the L2 Cache if needed */
> +	if (deepidle)
> +		reg |= PM_CONTROL_AND_CONFIG_L2_PWDDN;
> +
> +	/* request power down */
> +	reg |= PM_CONTROL_AND_CONFIG_PWDDN_REQ;
> +	writel(reg, pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
> +
> +	/* Disable snoop disable by HW - SW is taking care of it */
> +	reg = readl(pmsu_mp_base + PM_CPU_POWER_DOWN_CONTROL(hw_cpu));
> +	reg |= PM_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
> +	writel(reg, pmsu_mp_base + PM_CPU_POWER_DOWN_CONTROL(hw_cpu));
> +}
> +EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_idle_prepare);

No need for the EXPORT_SYMBOL_GPL() (cpuidle driver will always be
statically compiled).

> +noinline void armada_370_xp_pmsu_idle_restore(void)
> +{
> +	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
> +	int reg;
> +
> +	/* cancel ask HW to power down the L2 Cache if possible */
> +	reg = readl(pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
> +	reg &= ~PM_CONTROL_AND_CONFIG_L2_PWDDN;
> +	writel(reg, pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
> +
> +	/* cancel Enable wakeup events */
> +	reg = readl(pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
> +	reg &= ~(PM_STATUS_AND_MASK_IRQ_WAKEUP | PM_STATUS_AND_MASK_FIQ_WAKEUP);
> +	reg &= ~PM_STATUS_AND_MASK_CPU_IDLE_WAIT;
> +	reg &= ~PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT;
> +	/* Mask interrupts */

Move this comment up with the previous comment, to keep the strategy of
one comment for each read/modify/write cycle.

Also, maybe a comment on top of those functions mentioning that no
locking is needed because they only access per-CPU registers.

> +	reg &= ~(PM_STATUS_AND_MASK_IRQ_MASK | PM_STATUS_AND_MASK_FIQ_MASK);
> +	writel(reg, pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
> +}
> +EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_idle_restore);

No need for the EXPORT_SYMBOL_GPL() (cpuidle driver will always be
statically compiled).

> +
>  early_initcall(armada_370_xp_pmsu_init);
> diff --git a/include/linux/armada-370-xp-pmsu.h b/include/linux/armada-370-xp-pmsu.h
> index f85cbf7..235a40c 100644
> --- a/include/linux/armada-370-xp-pmsu.h
> +++ b/include/linux/armada-370-xp-pmsu.h
> @@ -12,5 +12,7 @@
>  #define __ARMADA_370_XP__PMSU_H
>  
>  void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
> +void armada_370_xp_pmsu_idle_prepare(bool deepidle);
> +void armada_370_xp_pmsu_idle_restore(void);
>  
>  #endif	/* __ARMADA_370_XP__PMSU_H */

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
