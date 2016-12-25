From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/9] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Sun, 25 Dec 2016 15:42:28 +0200
Message-ID: <20161225134228.qlp553c7cdqy6256@kozik-lap>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122531epcas1p4b8fad6664dad3408acb7a1b9f140884a@epcas1p4.samsung.com>
 <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 23, 2016 at 01:24:45PM +0100, Marek Szyprowski wrote:
> Pad retention control after suspend/resume cycle should be done from pin
> controller driver instead of PMU (power management unit) driver to avoid
> possible ordering and logical dependencies. Till now it worked fine only
> because PMU driver registered its sys_ops after pin controller.
> 
> This patch moves pad retention control from PMU driver to Exynos pin
> controller driver. This is a preparation for adding new features to Exynos
> pin controller driver, like runtime power management and suspending
> individual pin controllers, which might be a part of some power domain.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/pinctrl/samsung-pinctrl.txt           |   4 +
>  arch/arm/mach-exynos/suspend.c                     |  64 ---------
>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 148 +++++++++++++++++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c          |  16 ++-
>  drivers/pinctrl/samsung/pinctrl-samsung.h          |  13 ++
>  5 files changed, 178 insertions(+), 67 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> index 1baf19eecabf..b7bd2e12a269 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> @@ -43,6 +43,10 @@ Required Properties:
>  		};
>  	};
>  
> +- samsung,pmu-syscon: Phandle to the PMU system controller, to let driver
> +  to control pad retention after system suspend/resume cycle (only for Exynos
> +  SoC series).
> +
>  - Pin banks as child nodes: Pin banks of the controller are represented by child
>    nodes of the controller node. Bank name is taken from name of the node. Each
>    bank node must contain following properties:
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index 06332f626565..10bc753624be 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -57,7 +57,6 @@ struct exynos_wkup_irq {
>  struct exynos_pm_data {
>  	const struct exynos_wkup_irq *wkup_irq;
>  	unsigned int wake_disable_mask;
> -	unsigned int *release_ret_regs;
>  
>  	void (*pm_prepare)(void);
>  	void (*pm_resume_prepare)(void);
> @@ -95,47 +94,6 @@ struct exynos_pm_data {
>  	{ /* sentinel */ },
>  };
>  
> -static unsigned int exynos_release_ret_regs[] = {
> -	S5P_PAD_RET_MAUDIO_OPTION,
> -	S5P_PAD_RET_GPIO_OPTION,
> -	S5P_PAD_RET_UART_OPTION,
> -	S5P_PAD_RET_MMCA_OPTION,
> -	S5P_PAD_RET_MMCB_OPTION,
> -	S5P_PAD_RET_EBIA_OPTION,
> -	S5P_PAD_RET_EBIB_OPTION,
> -	REG_TABLE_END,
> -};
> -
> -static unsigned int exynos3250_release_ret_regs[] = {
> -	S5P_PAD_RET_MAUDIO_OPTION,
> -	S5P_PAD_RET_GPIO_OPTION,
> -	S5P_PAD_RET_UART_OPTION,
> -	S5P_PAD_RET_MMCA_OPTION,
> -	S5P_PAD_RET_MMCB_OPTION,
> -	S5P_PAD_RET_EBIA_OPTION,
> -	S5P_PAD_RET_EBIB_OPTION,
> -	S5P_PAD_RET_MMC2_OPTION,
> -	S5P_PAD_RET_SPI_OPTION,
> -	REG_TABLE_END,
> -};
> -
> -static unsigned int exynos5420_release_ret_regs[] = {
> -	EXYNOS_PAD_RET_DRAM_OPTION,
> -	EXYNOS_PAD_RET_MAUDIO_OPTION,
> -	EXYNOS_PAD_RET_JTAG_OPTION,
> -	EXYNOS5420_PAD_RET_GPIO_OPTION,
> -	EXYNOS5420_PAD_RET_UART_OPTION,
> -	EXYNOS5420_PAD_RET_MMCA_OPTION,
> -	EXYNOS5420_PAD_RET_MMCB_OPTION,
> -	EXYNOS5420_PAD_RET_MMCC_OPTION,
> -	EXYNOS5420_PAD_RET_HSI_OPTION,
> -	EXYNOS_PAD_RET_EBIA_OPTION,
> -	EXYNOS_PAD_RET_EBIB_OPTION,
> -	EXYNOS5420_PAD_RET_SPI_OPTION,
> -	EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
> -	REG_TABLE_END,
> -};
> -
>  static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
>  {
>  	const struct exynos_wkup_irq *wkup_irq;
> @@ -442,15 +400,6 @@ static int exynos5420_pm_suspend(void)
>  	return 0;
>  }
>  
> -static void exynos_pm_release_retention(void)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; (pm_data->release_ret_regs[i] != REG_TABLE_END); i++)
> -		pmu_raw_writel(EXYNOS_WAKEUP_FROM_LOWPWR,
> -				pm_data->release_ret_regs[i]);
> -}
> -
>  static void exynos_pm_resume(void)
>  {
>  	u32 cpuid = read_cpuid_part();
> @@ -458,9 +407,6 @@ static void exynos_pm_resume(void)
>  	if (exynos_pm_central_resume())
>  		goto early_wakeup;
>  
> -	/* For release retention */
> -	exynos_pm_release_retention();
> -
>  	if (cpuid == ARM_CPU_PART_CORTEX_A9)
>  		scu_enable(S5P_VA_SCU);
>  
> @@ -482,9 +428,6 @@ static void exynos3250_pm_resume(void)
>  	if (exynos_pm_central_resume())
>  		goto early_wakeup;
>  
> -	/* For release retention */
> -	exynos_pm_release_retention();
> -
>  	pmu_raw_writel(S5P_USE_STANDBY_WFI_ALL, S5P_CENTRAL_SEQ_OPTION);
>  
>  	if (call_firmware_op(resume) == -ENOSYS
> @@ -522,9 +465,6 @@ static void exynos5420_pm_resume(void)
>  	if (exynos_pm_central_resume())
>  		goto early_wakeup;
>  
> -	/* For release retention */
> -	exynos_pm_release_retention();
> -
>  	pmu_raw_writel(exynos_pmu_spare3, S5P_PMU_SPARE3);
>  
>  early_wakeup:
> @@ -637,7 +577,6 @@ static void exynos_suspend_finish(void)
>  static const struct exynos_pm_data exynos3250_pm_data = {
>  	.wkup_irq	= exynos3250_wkup_irq,
>  	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
> -	.release_ret_regs = exynos3250_release_ret_regs,
>  	.pm_suspend	= exynos_pm_suspend,
>  	.pm_resume	= exynos3250_pm_resume,
>  	.pm_prepare	= exynos3250_pm_prepare,
> @@ -647,7 +586,6 @@ static void exynos_suspend_finish(void)
>  static const struct exynos_pm_data exynos4_pm_data = {
>  	.wkup_irq	= exynos4_wkup_irq,
>  	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
> -	.release_ret_regs = exynos_release_ret_regs,
>  	.pm_suspend	= exynos_pm_suspend,
>  	.pm_resume	= exynos_pm_resume,
>  	.pm_prepare	= exynos_pm_prepare,
> @@ -657,7 +595,6 @@ static void exynos_suspend_finish(void)
>  static const struct exynos_pm_data exynos5250_pm_data = {
>  	.wkup_irq	= exynos5250_wkup_irq,
>  	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
> -	.release_ret_regs = exynos_release_ret_regs,
>  	.pm_suspend	= exynos_pm_suspend,
>  	.pm_resume	= exynos_pm_resume,
>  	.pm_prepare	= exynos_pm_prepare,
> @@ -667,7 +604,6 @@ static void exynos_suspend_finish(void)
>  static const struct exynos_pm_data exynos5420_pm_data = {
>  	.wkup_irq	= exynos5250_wkup_irq,
>  	.wake_disable_mask = (0x7F << 7) | (0x1F << 1),
> -	.release_ret_regs = exynos5420_release_ret_regs,
>  	.pm_resume_prepare = exynos5420_prepare_pm_resume,
>  	.pm_resume	= exynos5420_pm_resume,
>  	.pm_suspend	= exynos5420_pm_suspend,
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
> index 12f7d1eb65bc..55c1104a1ccf 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -24,11 +24,15 @@
>  #include <linux/irqdomain.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip/chained_irq.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of_irq.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/regmap.h>
>  #include <linux/err.h>
> +#include <linux/soc/samsung/exynos-regs-pmu.h>
> +
>  
>  #include "pinctrl-samsung.h"
>  #include "pinctrl-exynos.h"
> @@ -633,6 +637,46 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  			exynos_pinctrl_resume_bank(drvdata, bank);
>  }
>  
> +static atomic_t exynos_retention_refcnt;
> +static struct regmap *pmu_regs;
> +
> +static int exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata)
> +{
> +	struct device *dev = drvdata->dev;
> +
> +	pmu_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						   "samsung,pmu-syscon");
> +	if (IS_ERR(pmu_regs)) {
> +		dev_err(dev, "failed to lookup PMU regmap, no support for pad retention\n");
> +		return PTR_ERR(pmu_regs);
> +	}
> +	return 0;
> +}
> +
> +static void exynos_retention_on(struct samsung_pinctrl_drv_data *drvdata)
> +{
> +	atomic_inc(&exynos_retention_refcnt);

As this does not imply memory barriers, so maybe you need smp_mb__after_atomic()?

You didn't describe the need behind this barrier. What do you want to
protect? Do you expect suspend (or resume) happening multiple times for
one device? Or maybe you expect even mixing of these by different CPUs?

> +}
> +
> +static void exynos_retention_off(struct samsung_pinctrl_drv_data *drvdata)
> +{
> +	int i;
> +
> +	if (!atomic_dec_and_test(&exynos_retention_refcnt) || IS_ERR(pmu_regs))
> +		return;
> +
> +	for (i = 0; i < drvdata->nr_retention_regs; i++)
> +		regmap_write(pmu_regs, drvdata->retention_regs[i],
> +			     EXYNOS_WAKEUP_FROM_LOWPWR);
> +}
> +
> +static void exynos_retention_audio_off(struct samsung_pinctrl_drv_data *drvdata)
> +{
> +	if (!IS_ERR(pmu_regs))
> +		regmap_write(pmu_regs, S5P_PAD_RET_MAUDIO_OPTION,
> +			     EXYNOS_WAKEUP_FROM_LOWPWR);
> +}
> +
>  /* pin banks of s5pv210 pin-controller */
>  static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
>  	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
> @@ -714,6 +758,18 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gpx3", 0x0c),
>  };
>  
> +static const u32 exynos3250_retention_regs[] = {
> +	S5P_PAD_RET_MAUDIO_OPTION,
> +	S5P_PAD_RET_GPIO_OPTION,
> +	S5P_PAD_RET_UART_OPTION,
> +	S5P_PAD_RET_MMCA_OPTION,
> +	S5P_PAD_RET_MMCB_OPTION,
> +	S5P_PAD_RET_EBIA_OPTION,
> +	S5P_PAD_RET_EBIB_OPTION,
> +	S5P_PAD_RET_MMC2_OPTION,
> +	S5P_PAD_RET_SPI_OPTION,
> +};
> +
>  /*
>   * Samsung pinctrl driver data for Exynos3250 SoC. Exynos3250 SoC includes
>   * two gpio/pin-mux/pinconfig controllers.
> @@ -726,6 +782,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_gpio_init = exynos_eint_gpio_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos3250_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos3250_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 1 data */
>  		.pin_banks	= exynos3250_pin_banks1,
> @@ -734,6 +795,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_wkup_init = exynos_eint_wkup_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos3250_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos3250_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	},
>  };
>  
> @@ -786,6 +852,15 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  	EXYNOS_PIN_BANK_EINTN(7, 0x000, "gpz"),
>  };
>  
> +static const u32 exynos4_retention_regs[] = {
> +	S5P_PAD_RET_GPIO_OPTION,
> +	S5P_PAD_RET_UART_OPTION,
> +	S5P_PAD_RET_MMCA_OPTION,
> +	S5P_PAD_RET_MMCB_OPTION,
> +	S5P_PAD_RET_EBIA_OPTION,
> +	S5P_PAD_RET_EBIB_OPTION,
> +};
> +
>  /*
>   * Samsung pinctrl driver data for Exynos4210 SoC. Exynos4210 SoC includes
>   * three gpio/pin-mux/pinconfig controllers.
> @@ -798,6 +873,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_gpio_init = exynos_eint_gpio_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos4_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos4_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 1 data */
>  		.pin_banks	= exynos4210_pin_banks1,
> @@ -806,10 +886,17 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_wkup_init = exynos_eint_wkup_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos4_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos4_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 2 data */
>  		.pin_banks	= exynos4210_pin_banks2,
>  		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks2),
> +		.retention_init = exynos_retention_init,
> +		.retention_off   = exynos_retention_audio_off,
>  	},
>  };
>  
> @@ -883,6 +970,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_gpio_init = exynos_eint_gpio_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos4_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos4_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 1 data */
>  		.pin_banks	= exynos4x12_pin_banks1,
> @@ -891,6 +983,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_wkup_init = exynos_eint_wkup_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos4_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos4_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 2 data */
>  		.pin_banks	= exynos4x12_pin_banks2,
> @@ -898,6 +995,8 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_gpio_init = exynos_eint_gpio_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_init = exynos_retention_init,
> +		.retention_off   = exynos_retention_audio_off,
>  	}, {
>  		/* pin-controller instance 3 data */
>  		.pin_banks	= exynos4x12_pin_banks3,
> @@ -1052,6 +1151,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_wkup_init = exynos_eint_wkup_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos4_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos4_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 1 data */
>  		.pin_banks	= exynos5250_pin_banks1,
> @@ -1059,6 +1163,11 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_gpio_init = exynos_eint_gpio_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_regs = exynos4_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos4_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 2 data */
>  		.pin_banks	= exynos5250_pin_banks2,
> @@ -1073,6 +1182,8 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.eint_gpio_init = exynos_eint_gpio_init,
>  		.suspend	= exynos_pinctrl_suspend,
>  		.resume		= exynos_pinctrl_resume,
> +		.retention_init = exynos_retention_init,
> +		.retention_off   = exynos_retention_audio_off,
>  	},
>  };
>  
> @@ -1299,6 +1410,21 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
>  };
>  
> +static const u32 exynos5420_retention_regs[] = {
> +	EXYNOS_PAD_RET_DRAM_OPTION,
> +	EXYNOS_PAD_RET_JTAG_OPTION,
> +	EXYNOS5420_PAD_RET_GPIO_OPTION,
> +	EXYNOS5420_PAD_RET_UART_OPTION,
> +	EXYNOS5420_PAD_RET_MMCA_OPTION,
> +	EXYNOS5420_PAD_RET_MMCB_OPTION,
> +	EXYNOS5420_PAD_RET_MMCC_OPTION,
> +	EXYNOS5420_PAD_RET_HSI_OPTION,
> +	EXYNOS_PAD_RET_EBIA_OPTION,
> +	EXYNOS_PAD_RET_EBIB_OPTION,
> +	EXYNOS5420_PAD_RET_SPI_OPTION,
> +	EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
> +};
> +
>  /*
>   * Samsung pinctrl driver data for Exynos5420 SoC. Exynos5420 SoC includes
>   * four gpio/pin-mux/pinconfig controllers.
> @@ -1310,26 +1436,48 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>  		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks0),
>  		.eint_gpio_init = exynos_eint_gpio_init,
>  		.eint_wkup_init = exynos_eint_wkup_init,
> +		.retention_regs = exynos5420_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos5420_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,

The indent here:                ^
looks weird. Did you indent it with a tab? Similar in the code below.

>  	}, {
>  		/* pin-controller instance 1 data */
>  		.pin_banks	= exynos5420_pin_banks1,
>  		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks1),
>  		.eint_gpio_init = exynos_eint_gpio_init,
> +		.retention_regs = exynos5420_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos5420_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 2 data */
>  		.pin_banks	= exynos5420_pin_banks2,
>  		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks2),
>  		.eint_gpio_init = exynos_eint_gpio_init,
> +		.retention_regs = exynos5420_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos5420_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 3 data */
>  		.pin_banks	= exynos5420_pin_banks3,
>  		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks3),
>  		.eint_gpio_init = exynos_eint_gpio_init,
> +		.retention_regs = exynos5420_retention_regs,
> +		.nr_retention_regs = ARRAY_SIZE(exynos5420_retention_regs),
> +		.retention_init = exynos_retention_init,
> +		.retention_on   = exynos_retention_on,
> +		.retention_off   = exynos_retention_off,
>  	}, {
>  		/* pin-controller instance 4 data */
>  		.pin_banks	= exynos5420_pin_banks4,
>  		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks4),
>  		.eint_gpio_init = exynos_eint_gpio_init,
> +		.retention_init = exynos_retention_init,
> +		.retention_off  = exynos_retention_audio_off,
>  	},
>  };
>  
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index a6c2ea74e0f3..cb425e6837f9 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1011,6 +1011,11 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
>  			return ERR_PTR(-EIO);
>  	}
>  
> +	d->retention_regs = ctrl->retention_regs;
> +	d->nr_retention_regs = ctrl->nr_retention_regs;
> +	d->retention_on = ctrl->retention_on;
> +	d->retention_off = ctrl->retention_off;
> +
>  	bank = d->pin_banks;
>  	bdata = ctrl->pin_banks;
>  	for (i = 0; i < ctrl->nr_banks; ++i, ++bdata, ++bank) {
> @@ -1087,6 +1092,8 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>  		ctrl->eint_gpio_init(drvdata);
>  	if (ctrl->eint_wkup_init)
>  		ctrl->eint_wkup_init(drvdata);
> +	if (ctrl->retention_init)
> +		ctrl->retention_init(drvdata);
>  
>  	platform_set_drvdata(pdev, drvdata);
>  
> @@ -1139,15 +1146,15 @@ static void samsung_pinctrl_suspend_dev(
>  
>  	if (drvdata->suspend)
>  		drvdata->suspend(drvdata);
> +	if (drvdata->retention_on)
> +		drvdata->retention_on(drvdata);
> +

Empty line is not needed.

Best regards,
Krzysztof
