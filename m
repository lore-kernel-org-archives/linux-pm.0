From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH 1/3 v3] ARM: EXYNOS4: Support for generic I/O
 power domains on EXYNOS4210/4212
Date: Thu, 03 Nov 2011 11:09:00 +0900
Message-ID: <013301cc99cd$8d5a6a00$a80f3e00$%kim@samsung.com>
References: <4EA690EF.4000703@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <4EA690EF.4000703@samsung.com>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: 'Chanwoo Choi' <cw00.choi@samsung.com>
Cc: 'Sylwester Nawrocki' <snjw23@gmail.com>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, 'linux-arm-kernel' <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Chanwoo Choi wrote:
> 
> This patch support the generic power domains to control power domain
> of EXYNOS4.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/Kconfig                   |    2 +
>  arch/arm/mach-exynos4/Makefile                  |    1 +
>  arch/arm/mach-exynos4/include/mach/pm-exynos4.h |   50 +++++
>  arch/arm/mach-exynos4/include/mach/regs-clock.h |    9 +
>  arch/arm/mach-exynos4/include/mach/regs-pmu.h   |    2 +
>  arch/arm/mach-exynos4/pm-exynos4.c              |  237
> +++++++++++++++++++++++
>  6 files changed, 301 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/include/mach/pm-exynos4.h
>  create mode 100644 arch/arm/mach-exynos4/pm-exynos4.c
> 
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index 4924838..d042e53 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -14,6 +14,7 @@ config CPU_EXYNOS4210
>  	select SAMSUNG_DMADEV
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> +	select PM_GENERIC_DOMAINS if PM
>  	help
>  	  Enable EXYNOS4210 CPU support
> 
> @@ -21,6 +22,7 @@ config SOC_EXYNOS4212
>  	bool
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> +	select PM_GENERIC_DOMAINS if PM
>  	help
>  	  Enable EXYNOS4212 SoC support
> 
> diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
> index 2bb18f4..d73a4e7 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -14,6 +14,7 @@ obj-				:=
> 
>  obj-$(CONFIG_ARCH_EXYNOS4)	+= cpu.o init.o clock.o irq-combiner.o
>  obj-$(CONFIG_ARCH_EXYNOS4)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
> +obj-$(CONFIG_ARCH_EXYNOS4)	+= pm-exynos4.o
>  obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
>  obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
>  obj-$(CONFIG_PM)		+= pm.o
> diff --git a/arch/arm/mach-exynos4/include/mach/pm-exynos4.h b/arch/arm/mach-
> exynos4/include/mach/pm-exynos4.h
> new file mode 100644
> index 0000000..31f6b75
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/include/mach/pm-exynos4.h
> @@ -0,0 +1,50 @@
> +/* linux/arch/arm/mach-exynos4/include/mach/pm-exynos4.h
> + *
> + * EXYNOS4 series Power management support
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef PM_EXYNOS4_H
> +#define PM_EXYNOS4_H
> +
> +#include <linux/pm_domain.h>
> +
> +#ifdef CONFIG_PM
> +struct exynos4_pm_domain {
> +	struct generic_pm_domain genpd;
> +	const char *name;
> +	void __iomem *base;
> +	u32 clkgate_mask;
> +};
> +
> +extern int exynos4_add_device_to_domain(struct exynos4_pm_domain
> *exynos4_pd,
> +				struct platform_device *pdev);
> +extern void exynos4210_init_pm_domains(void);
> +extern void exynos4x12_init_pm_domains(void);
> +
> +/* Common power domain for EXYNOS4 series */
> +extern struct exynos4_pm_domain exynos4_pd_mfc;
> +extern struct exynos4_pm_domain exynos4_pd_g3d;
> +extern struct exynos4_pm_domain exynos4_pd_lcd0;
> +extern struct exynos4_pm_domain exynos4_pd_tv;
> +extern struct exynos4_pm_domain exynos4_pd_cam;
> +extern struct exynos4_pm_domain exynos4_pd_gps;
> +
> +/* Only for EXYNOS4210 */
> +extern struct exynos4_pm_domain exynos4_pd_lcd1;
> +
> +/* Only for EXYNOS4x12 */
> +extern struct exynos4_pm_domain exynos4_pd_isp;
> +
> +#else
> +#define exynos4_add_device_to_domain(exynos4_pd, pdev) { }
> +#define exynos4210_init_pm_domains() { }
> +#define exynos4x12_init_pm_domains() { }
> +#endif	/* CONFIG_PM */
> +#endif	/* PM_EXYNOS4_H */
> diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-
> exynos4/include/mach/regs-clock.h
> index 6c37ebe..c519ade 100644
> --- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
> +++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
> @@ -194,6 +194,13 @@
>  #define S5P_CLKDIV_BUS_GPLR_SHIFT	(4)
>  #define S5P_CLKDIV_BUS_GPLR_MASK	(0x7 <<
> S5P_CLKDIV_BUS_GPLR_SHIFT)
> 
> +#define S5P_CLKGATE_BLOCK_CAM		(1 << 0)
> +#define S5P_CLKGATE_BLOCK_TV		(1 << 1)
> +#define S5P_CLKGATE_BLOCK_MFC		(1 << 2)
> +#define S5P_CLKGATE_BLOCK_G3D		(1 << 3)
> +#define S5P_CLKGATE_BLOCK_LCD0		(1 << 4)
> +#define S5P_CLKGATE_BLOCK_GPS		(1 << 7)
> +
>  /* Only for EXYNOS4210 */
> 
>  #define S5P_CLKSRC_LCD1			S5P_CLKREG(0x0C238)
> @@ -201,6 +208,8 @@
>  #define S5P_CLKDIV_LCD1			S5P_CLKREG(0x0C538)
>  #define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
> 
> +#define S5P_CLKGATE_BLOCK_LCD1		(1 << 5)
> +
>  /* Compatibility defines and inclusion */
> 
>  #include <mach/regs-pmu.h>
> diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h b/arch/arm/mach-
> exynos4/include/mach/regs-pmu.h
> index 4fff8e9..da397d5 100644
> --- a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
> @@ -217,4 +217,6 @@
>  #define S5P_SECSS_MEM_OPTION
> 	S5P_PMUREG(0x2EC8)
>  #define S5P_ROTATOR_MEM_OPTION
> 	S5P_PMUREG(0x2F48)
> 
> +#define S5P_PMU_ISP_CONF			S5P_PMUREG(0x3CA0)
> +
>  #endif /* __ASM_ARCH_REGS_PMU_H */
> diff --git a/arch/arm/mach-exynos4/pm-exynos4.c b/arch/arm/mach-exynos4/pm-
> exynos4.c
> new file mode 100644
> index 0000000..c35952b
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/pm-exynos4.c
> @@ -0,0 +1,237 @@
> +/* linux/arch/arm/mach-exynos4/pm-exynos4.c
> + *
> + * EXYNOS4 series Power management support
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/io.h>
> +
> +#include <mach/regs-clock.h>
> +#include <mach/pm-exynos4.h>
> +
> +#ifdef CONFIG_PM
> +/*
> + * Define function to support generic power domain
> + */
> +
> +static DEFINE_SPINLOCK(clkgate_block_lock);
> +
> +static struct exynos4_pm_domain *to_exynos4_pd(struct generic_pm_domain
> *pd)
> +{
> +	return container_of(pd, struct exynos4_pm_domain, genpd);
> +}
> +
> +static int __exynos4_pd_power_down(struct generic_pm_domain *genpd)
> +{
> +	struct exynos4_pm_domain *exynos4_pd = to_exynos4_pd(genpd);
> +	u32 timeout;
> +
> +	/* Disable the power of power-domain */
> +	__raw_writel(0, exynos4_pd->base);
> +
> +	/* Wait max 1ms */
> +	timeout = 10;
> +	while (__raw_readl(exynos4_pd->base + 0x4) &
> S5P_INT_LOCAL_PWR_EN) {
> +		if (timeout == 0) {
> +			pr_err("Power domain %s disable failed.\n",
> exynos4_pd->name);
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		usleep_range(90, 110);
> +	}
> +
> +	/* Configure the clock-gating control register for block to turn off */
> +	if (exynos4_pd->clkgate_mask) {
> +		unsigned long flags;
> +		u32 reg;
> +
> +		spin_lock_irqsave(&clkgate_block_lock, flags);
> +		reg = __raw_readl(S5P_CLKGATE_BLOCK);
> +		reg &= ~exynos4_pd->clkgate_mask;
> +		__raw_writel(reg, S5P_CLKGATE_BLOCK);
> +		spin_unlock_irqrestore(&clkgate_block_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __exynos4_pd_power_up(struct generic_pm_domain *genpd)
> +{
> +	struct exynos4_pm_domain *exynos4_pd = to_exynos4_pd(genpd);
> +	u32 timeout;
> +
> +	/* Enable power domain */
> +	__raw_writel(S5P_INT_LOCAL_PWR_EN, exynos4_pd->base);
> +
> +	/* Wait max 1ms */
> +	timeout = 10;
> +	while ((__raw_readl(exynos4_pd->base + 0x4) &
> S5P_INT_LOCAL_PWR_EN)
> +		!= S5P_INT_LOCAL_PWR_EN) {
> +		if (timeout == 0) {
> +			pr_err("Power domain %s enable failed.\n",
> +				exynos4_pd->name);
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		usleep_range(90, 110);
> +	}
> +
> +	/* Configure the clock-gating control register for block to turn on */
> +	if (exynos4_pd->clkgate_mask) {
> +		unsigned long flags;
> +		u32 reg;
> +
> +		spin_lock_irqsave(&clkgate_block_lock, flags);
> +		reg = __raw_readl(S5P_CLKGATE_BLOCK);
> +		reg |= exynos4_pd->clkgate_mask;
> +		__raw_writel(reg, S5P_CLKGATE_BLOCK);
> +		spin_unlock_irqrestore(&clkgate_block_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static bool __exynos4_pd_active_wakeup(struct device *dev)
> +{
> +	return true;
> +}
> +
> +static void __exynos4_init_pm_domain(struct exynos4_pm_domain *exynos4_pd)
> +{
> +	struct generic_pm_domain *genpd;
> +
> +	if (!exynos4_pd) {
> +		pr_err("Failed to initialize Power domain(%s)\n", exynos4_pd-
> >name);
> +		return;
> +	}
> +
> +	genpd = &exynos4_pd->genpd;
> +
> +	pm_genpd_init(genpd, NULL, false);
> +	genpd->active_wakeup = __exynos4_pd_active_wakeup;
> +	genpd->power_off = __exynos4_pd_power_down;
> +	genpd->power_on = __exynos4_pd_power_up;
> +}
> +
> +/*
> + * Define power domain of EXYNOS4 series
> + * - EXYNOS4210
> + * - EXYNOS4212
> + */
> +/* Common power domain on EXYNOS4 series */
> +struct exynos4_pm_domain exynos4_pd_mfc = {
> +	.name		= "PD_MFC",
> +	.base		= S5P_PMU_MFC_CONF,
> +	.clkgate_mask	= S5P_CLKGATE_BLOCK_MFC,
> +};
> +
> +struct exynos4_pm_domain exynos4_pd_g3d = {
> +	.name		= "PD_G3D",
> +	.base		= S5P_PMU_G3D_CONF,
> +	.clkgate_mask	= S5P_CLKGATE_BLOCK_G3D,
> +};
> +
> +struct exynos4_pm_domain exynos4_pd_lcd0 = {
> +	.name		= "PD_LCD0",
> +	.base		= S5P_PMU_LCD0_CONF,
> +	.clkgate_mask	= S5P_CLKGATE_BLOCK_LCD0,
> +};
> +
> +struct exynos4_pm_domain exynos4_pd_tv = {
> +	.name		= "PD_TV",
> +	.base		= S5P_PMU_TV_CONF,
> +	.clkgate_mask	= S5P_CLKGATE_BLOCK_TV,
> +};
> +
> +struct exynos4_pm_domain exynos4_pd_cam = {
> +	.name		= "PD_CAM",
> +	.base		= S5P_PMU_CAM_CONF,
> +	.clkgate_mask	= S5P_CLKGATE_BLOCK_CAM,
> +};
> +
> +struct exynos4_pm_domain exynos4_pd_gps = {
> +	.name		= "PD_GPS",
> +	.base		= S5P_PMU_GPS_CONF,
> +	.clkgate_mask	= S5P_CLKGATE_BLOCK_GPS,
> +};
> +
> +/* Only for EXYNOS4210 */
> +struct exynos4_pm_domain exynos4_pd_lcd1 = {
> +	.name		= "PD_LCD1",
> +	.base		= S5P_PMU_LCD1_CONF,
> +	.clkgate_mask	= S5P_CLKGATE_BLOCK_LCD1,
> +};
> +
> +/* Only for EXYNOS4212 */
> +struct exynos4_pm_domain exynos4_pd_isp = {
> +	.name		= "PD_ISP",
> +	.base		= S5P_PMU_ISP_CONF,
> +};
> +
> +/*
> + * Define function which initalize power domain and add device to it
> + */
> +int exynos4_add_device_to_domain(struct exynos4_pm_domain *exynos4_pd,
> +				struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (!exynos4_pd || !pdev)
> +		return -EINVAL;
> +
> +	ret = pm_genpd_add_device(&exynos4_pd->genpd, dev);
> +	if (ret < 0) {
> +		pr_err("Failed to add %s device to power domain(%s)\n",
> +			dev_name(&pdev->dev), exynos4_pd->name);
> +		return ret;
> +	}
> +
> +	pr_info("Add %s device to power domain(%s)\n",
> +			dev_name(&pdev->dev), exynos4_pd->name);
> +	return 0;
> +}
> +
> +void exynos4_init_pm_domains(void)
> +{
> +	__exynos4_init_pm_domain(&exynos4_pd_mfc);
> +	__exynos4_init_pm_domain(&exynos4_pd_g3d);
> +	__exynos4_init_pm_domain(&exynos4_pd_lcd0);
> +	__exynos4_init_pm_domain(&exynos4_pd_tv);
> +	__exynos4_init_pm_domain(&exynos4_pd_cam);
> +	__exynos4_init_pm_domain(&exynos4_pd_gps);
> +
> +}
> +
> +/* Initialize EXYNOS4210 power domain */
> +void exynos4210_init_pm_domains(void)
> +{
> +	exynos4_init_pm_domains();
> +
> +	__exynos4_init_pm_domain(&exynos4_pd_lcd1);
> +
> +	/* Enabled the power domain of LCD0 */
> +	__exynos4_pd_power_up(&exynos4_pd_lcd0.genpd);
> +}
> +
> +/* Initialize EXYNOS4x12 power domain */
> +void exynos4x12_init_pm_domains(void)
> +{
> +	exynos4_init_pm_domains();
> +
> +	__exynos4_init_pm_domain(&exynos4_pd_isp);
> +
> +	/* Enabled the power domain of LCD0 */
> +	__exynos4_pd_power_up(&exynos4_pd_lcd0.genpd);
> +}
> +#endif	/* CONFIG_PM */
> --
> 1.7.0.4

As I said, I don't think we should control/gate the clocks with regarding power domain. It should be controlled by each regarding device driver and in addition, as I know, to handle block of clock is not recommended on EXYNOS4 now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
