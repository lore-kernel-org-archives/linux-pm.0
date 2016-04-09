From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC PM domains
Date: Sat, 09 Apr 2016 22:50:52 +0300
Message-ID: <1651059.9FCnPbykeI@avalon>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be> <1460031628-13336-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:52636 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbcDITvA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 15:51:00 -0400
In-Reply-To: <1460031628-13336-4-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 07 Apr 2016 14:20:20 Geert Uytterhoeven wrote:
> Populate the SYSC PM domains from DT, based on the presence of a device
> node for the System Controller. The actual power area hiearchy, and
> features of specific areas are obtained from tables in the C code.
> 
> The SYSCIER and SYSCIMR register values are derived from the power areas
> present, which will help to get rid of the hardcoded values in R-Car H1
> and R-Car Gen2 platform code later.
> 
> Initialization is done in two phases:
>   1. SYSC initialization and setup of power areas containing CPUs or
>      SCUs is done from an early_initcall(), to make sure these PM
>      Domains are initialized before secondary CPU bringup,
>   2. Setup of the always-on power area (which is basically an alias for
>      the CPG/MSSR or CPG/MSTP Clock Domain), and of I/O power areas is
>      done from builtin_platform_driver_probe(), when the Clock Domain is
>      available.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - Make sure not to clear reserved SYSCIMR bits that were set before,
>   - Make the always-on power area implicit and always present, and an
>     alias of the existing SoC's Clock Domain. This makes the number of
>     power areas a compile-time constant, and allows to drop PD_ALWAYS_ON
>     and some checks.
>   - Split initialization in two phases,
>   - Document that ARM cores are controlled by PSCI on R-Car Gen3
>     (although the underlying CPG/APMU hardware is the same as on Gen2),
>   - Minor improvements (double evaluation, unused parameter, debug
>     message consolidation),
> 
> v3:
>   - Drop check for CONFIG_PM_GENERIC_DOMAINS, which is now always
>     enabled on R-Car SoCs,
>   - Create PM Domains from hierarchy in C data instead of DT,
>   - Initialize SYSCIER early, as SYSC needs the interrupt sources to be
>     enabled to control power,
>   - Mask all SYSC interrupt sources for the CPU,
>   - Add support for an "always-on" domain,
>   - Use early_initcall() instead of core_initcall(),
>   - Do not power up CPU power areas during initialization, as this is
>     handled later (directly or indirectly) by the SMP code,
> 
> v2:
>   - Add missing definitions for SYSC_PWR_CA15_CPU and SYSC_PWR_CA7_CPU,
>   - Add R-Car H3 (r8a7795) support,
>   - Drop tests for CONFIG_ARCH_SHMOBILE_LEGACY,
>   - Add missing break statements in rcar_sysc_pwr_on_off(),
>   - Add missing calls to of_node_put() in error paths,
>   - Fix build if CONFIG_PM=n,
>   - Update compatible values,
>   - Update copyright.
> ---
>  drivers/soc/renesas/rcar-sysc.c | 261 ++++++++++++++++++++++++++++++++++++-
>  drivers/soc/renesas/rcar-sysc.h |  52 ++++++++
>  2 files changed, 312 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/renesas/rcar-sysc.h
> 
> diff --git a/drivers/soc/renesas/rcar-sysc.c
> b/drivers/soc/renesas/rcar-sysc.c index 9ba5fd15c53bf9b9..3cb19b599cee4ee5
> 100644
> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -2,6 +2,7 @@
>   * R-Car SYSC Power management support
>   *
>   * Copyright (C) 2014  Magnus Damm
> + * Copyright (C) 2015-2016 Glider bvba
>   *
>   * This file is subject to the terms and conditions of the GNU General
> Public * License.  See the file "COPYING" in the main directory of this
> archive
> @@ -11,10 +12,17 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/soc/renesas/rcar-sysc.h>
> 
> +#include "rcar-sysc.h"
> +
>  /* SYSC Common */
>  #define SYSCSR			0x00	/* SYSC Status Register */
>  #define SYSCISR			0x04	/* Interrupt Status Register */
> @@ -29,7 +37,8 @@
>  /*
>   * Power Control Register Offsets inside the register block for each domain
> * Note: The "CR" registers for ARM cores exist on H1 only
> - *       Use WFI to power off, CPG/APMU to resume ARM cores on R-Car Gen2
> + *	 Use WFI to power off, CPG/APMU to resume ARM cores on R-Car Gen2
> + *	 Use PSCI on R-Car Gen3
>   */
>  #define PWRSR_OFFS		0x00	/* Power Status Register */
>  #define PWROFFCR_OFFS		0x04	/* Power Shutoff Control Register */
> @@ -48,6 +57,8 @@
>  #define SYSCISR_RETRIES		1000
>  #define SYSCISR_DELAY_US	1
> 
> +#define RCAR_PD_ALWAYS_ON	32	/* Always-on power area */
> +
>  static void __iomem *rcar_sysc_base;
>  static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
> 
> @@ -162,3 +173,251 @@ void __iomem *rcar_sysc_init(phys_addr_t base)
> 
>  	return rcar_sysc_base;
>  }
> +
> +struct rcar_sysc_pd {
> +	struct generic_pm_domain genpd;
> +	struct rcar_sysc_ch ch;
> +	unsigned int flags;
> +	char name[0];
> +};
> +
> +static inline struct rcar_sysc_pd *to_rcar_pd(struct generic_pm_domain *d)
> +{
> +	return container_of(d, struct rcar_sysc_pd, genpd);
> +}
> +
> +static bool rcar_sysc_active_wakeup(struct device *dev)
> +{
> +	return true;
> +}
> +
> +static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
> +
> +	pr_debug("%s: %s\n", __func__, genpd->name);
> +
> +	if (pd->flags & PD_NO_CR) {
> +		pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
> +		return -EBUSY;
> +	}
> +
> +	if (pd->flags & PD_BUSY) {
> +		pr_debug("%s: %s busy\n", __func__, genpd->name);
> +		return -EBUSY;
> +	}
> +
> +	return rcar_sysc_power_down(&pd->ch);
> +}
> +
> +static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
> +
> +	pr_debug("%s: %s\n", __func__, genpd->name);
> +
> +	if (pd->flags & PD_NO_CR) {
> +		pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
> +		return 0;
> +	}
> +
> +	return rcar_sysc_power_up(&pd->ch);
> +}
> +
> +static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
> +{
> +	struct generic_pm_domain *genpd = &pd->genpd;
> +	const char *name = pd->genpd.name;
> +	struct dev_power_governor *gov = &simple_qos_governor;
> +
> +	if (pd->flags & PD_CPU) {
> +		/*
> +		 * This domain contains a CPU core and therefore it should
> +		 * only be turned off if the CPU is not in use.
> +		 */
> +		pr_debug("PM domain %s contains %s\n", name, "CPU");
> +		pd->flags |= PD_BUSY;
> +		gov = &pm_domain_always_on_gov;
> +	} else if (pd->flags & PD_SCU) {
> +		/*
> +		 * This domain contains an SCU and cache-controller, and
> +		 * therefore it should only be turned off if the CPU cores are
> +		 * not in use.
> +		 */
> +		pr_debug("PM domain %s contains %s\n", name, "SCU");
> +		pd->flags |= PD_BUSY;
> +		gov = &pm_domain_always_on_gov;
> +	}
> +
> +	pm_genpd_init(genpd, gov, false);
> +	genpd->dev_ops.active_wakeup = rcar_sysc_active_wakeup;
> +	genpd->power_off = rcar_sysc_pd_power_off;
> +	genpd->power_on = rcar_sysc_pd_power_on;
> +
> +	if (pd->flags & PD_CPU) {
> +		/* Skip CPUs (handled by SMP code) */
> +		pr_debug("%s: Not touching %s\n", __func__, genpd->name);
> +		return;
> +	}
> +
> +	if (!rcar_sysc_power_is_off(&pd->ch)) {
> +		pr_debug("%s: %s is already powered\n", __func__, genpd->name);
> +		return;
> +	}
> +
> +	rcar_sysc_power_up(&pd->ch);
> +}
> +
> +static const struct of_device_id rcar_sysc_matches[] = {
> +	{ /* sentinel */ }
> +};
> +
> +struct rcar_pm_domains {
> +	struct genpd_onecell_data onecell_data;
> +	struct generic_pm_domain *domains[RCAR_PD_ALWAYS_ON + 1];
> +};
> +
> +static struct genpd_onecell_data *rcar_sysc_onecell_data;
> +
> +static int __init rcar_sysc_pd_init(const struct rcar_sysc_info *info,
> +				    bool early)
> +{
> +	struct generic_pm_domain **domains = rcar_sysc_onecell_data->domains;
> +	unsigned int i;
> +
> +	for (i = 0; i < info->num_areas; i++) {
> +		const struct rcar_sysc_area *area = &info->areas[i];
> +		struct rcar_sysc_pd *pd;
> +
> +		/* Skip non-CPU/SCU domains during phase 1 */
> +		if (early && !(area->flags & (PD_CPU | PD_SCU)))
> +			continue;
> +
> +		/* Tie CPU/SCU domains to always-on domain during phase 2 * */
> +		if (!early && (area->flags & (PD_CPU | PD_SCU))) {
> +			if (area->parent < 0)
> +				pm_genpd_add_subdomain(
> +					domains[RCAR_PD_ALWAYS_ON],
> +					domains[area->isr_bit]);
> +			continue;
> +		}
> +
> +		pd = kzalloc(sizeof(*pd) + strlen(area->name) + 1, GFP_KERNEL);
> +		if (!pd)
> +			return -ENOMEM;
> +
> +		strcpy(pd->name, area->name);
> +		pd->genpd.name = pd->name;
> +		pd->ch.chan_offs = area->chan_offs;
> +		pd->ch.chan_bit = area->chan_bit;
> +		pd->ch.isr_bit = area->isr_bit;
> +		pd->flags = area->flags;
> +
> +		rcar_sysc_pd_setup(pd);
> +		if (area->parent >= 0)
> +			pm_genpd_add_subdomain(domains[area->parent],
> +					       &pd->genpd);
> +		else if (domains[RCAR_PD_ALWAYS_ON])
> +			pm_genpd_add_subdomain(domains[RCAR_PD_ALWAYS_ON],
> +					       &pd->genpd);
> +
> +		domains[area->isr_bit] = &pd->genpd;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialization phase 1, including setup of CPU and SCU domains
> + */
> +static int __init rcar_sysc_early(void)
> +{
> +	const struct rcar_sysc_info *info;
> +	const struct of_device_id *match;
> +	struct rcar_pm_domains *domains;
> +	struct device_node *np;
> +	u32 syscier, syscimr;
> +	void __iomem *base;
> +	unsigned int i;
> +	int error;
> +
> +	np = of_find_matching_node_and_match(NULL, rcar_sysc_matches, &match);
> +	if (!np)
> +		return -ENODEV;
> +
> +	info = match->data;
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		pr_warn("%s: Cannot map regs\n", np->full_name);
> +		error = -ENOMEM;
> +		goto out_put;
> +	}
> +
> +	rcar_sysc_base = base;
> +
> +	domains = kzalloc(sizeof(*domains), GFP_KERNEL);
> +	if (!domains) {
> +		error = -ENOMEM;
> +		goto out_put;

You might want to iounmap() when cleaning up.

> +	}
> +
> +	domains->onecell_data.domains = domains->domains;
> +	domains->onecell_data.num_domains = ARRAY_SIZE(domains->domains);
> +
> +	/*
> +	 * SYSC needs all interrupt sources enabled to control power.
> +	 */
> +	for (i = 0, syscier = 0; i < info->num_areas; i++)
> +		syscier |= BIT(info->areas[i].isr_bit);
> +	pr_debug("%s: syscier = 0x%08x\n", np->full_name, syscier);
> +	iowrite32(syscier, base + SYSCIER);
> +
> +	/*
> +	 * Mask all interrupt sources to prevent the CPU from receiving them.
> +	 * Make sure not to clear reserved bits that were set before.
> +	 */
> +	syscimr = ioread32(base + SYSCIMR);
> +	syscimr |= syscier;
> +	pr_debug("%s: syscimr = 0x%08x\n", np->full_name, syscimr);
> +	iowrite32(syscimr, base + SYSCIMR);

Should you mask the interrupt sources before enabling them in SYSCIER ?

> +	rcar_sysc_onecell_data = &domains->onecell_data;
> +
> +	error = rcar_sysc_pd_init(info, true);
> +	if (error)
> +		goto out_put;
> +
> +	of_genpd_add_provider_onecell(np, &domains->onecell_data);
> +
> +out_put:
> +	of_node_put(np);
> +	return error;
> +}
> +early_initcall(rcar_sysc_early);
> +
> +
> +/*
> + * Initialization phase 2, including setup of always-on and I/O domains
> + */
> +static int __init rcar_sysc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	if (!rcar_sysc_onecell_data)
> +		return -ENODEV;
> +
> +	rcar_sysc_onecell_data->domains[RCAR_PD_ALWAYS_ON] =
> +		pd_to_genpd(dev->pm_domain);

This part, or rather the power-domains = <&cpg_clocks>; property in the SYSC 
DT node, bothers me. I don't think the DT property really describes the 
hardware. I like your " clk: renesas: cpg-mssr: Export 
cpg_mssr_{at,de}tach_dev()" approach better.

> +	return rcar_sysc_pd_init(of_device_get_match_data(dev), false);
> +}
> +
> +static struct platform_driver rcar_sysc_driver = {
> +	.driver = {
> +		.name = "rcar-sysc",
> +		.of_match_table = rcar_sysc_matches,
> +	},
> +};
> +
> +builtin_platform_driver_probe(rcar_sysc_driver, rcar_sysc_probe);
> diff --git a/drivers/soc/renesas/rcar-sysc.h
> b/drivers/soc/renesas/rcar-sysc.h new file mode 100644
> index 0000000000000000..4aeb3541227a5456
> --- /dev/null
> +++ b/drivers/soc/renesas/rcar-sysc.h
> @@ -0,0 +1,52 @@
> +/*
> + * Renesas R-Car System Controller
> + *
> + * Copyright (C) 2016 Glider bvba
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +#ifndef __SOC_RENESAS_RCAR_SYSC_H__
> +#define __SOC_RENESAS_RCAR_SYSC_H__
> +
> +#include <linux/types.h>
> +
> +
> +/*
> + * Power Domain flags
> + */
> +#define PD_CPU		BIT(0)	/* Area contains main CPU core */
> +#define PD_SCU		BIT(1)	/* Area contains SCU and L2 cache */
> +#define PD_NO_CR	BIT(2)	/* Area lacks PWR{ON,OFF}CR registers */
> +
> +#define PD_BUSY		BIT(3)	/* Busy, for internal use only */
> +
> +#define PD_CPU_CR	PD_CPU		  /* CPU area has CR (R-Car H1) */
> +#define PD_CPU_NOCR	PD_CPU | PD_NO_CR /* CPU area lacks CR (R-Car Gen2/3)

I'd enclose PD_CPU | PD_NO_CR in parentheses.

> */ +
> +
> +/*
> + * Description of a Power Area
> + */
> +
> +struct rcar_sysc_area {
> +	const char *name;
> +	u16 chan_offs;		/* Offset of PWRSR register for this area */
> +	u8 chan_bit;		/* Bit in PWR* (except for PWRUP in PWRSR) */
> +	u8 isr_bit;		/* Bit in SYSCI*R */
> +	int parent;		/* -1 if none (i.e. always-on) */
> +	unsigned int flags;	/* See PD_* */
> +};
> +
> +
> +/*
> + * SoC-specific Power Area Description
> + */
> +
> +struct rcar_sysc_info {
> +	const struct rcar_sysc_area *areas;
> +	unsigned int num_areas;
> +};
> +
> +#endif /* __SOC_RENESAS_RCAR_SYSC_H__ */

-- 
Regards,

Laurent Pinchart

