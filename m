From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/9] thermal: rockchip: handle the power sequence for
 tsadc controller
Date: Wed, 27 Apr 2016 16:48:19 -0700
Message-ID: <20160427234818.GB2590@localhost.localdomain>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-5-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36819 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbcD0XsY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 19:48:24 -0400
Content-Disposition: inline
In-Reply-To: <1460950562-20652-5-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Apr 18, 2016 at 11:35:56AM +0800, Caesar Wang wrote:
> This adds the grf property to handle the tsadc power sequence on
> rockchip some SoCs.
> 
> Verified on rk3399 can work with this patch on now.
> 
> while true; do grep "" /sys/class/thermal/thermal_zone[0-1]/temp
> sleep .5; done
> /sys/class/thermal/thermal_zone0/temp:40555
> /sys/class/thermal/thermal_zone1/temp:41111
> /sys/class/thermal/thermal_zone0/temp:40555
> /sys/class/thermal/thermal_zone1/temp:41111
> /sys/class/thermal/thermal_zone0/temp:40555
> /sys/class/thermal/thermal_zone1/temp:41666
> /sys/class/thermal/thermal_zone0/temp:40555
> /sys/class/thermal/thermal_zone1/temp:41111
> /sys/class/thermal/thermal_zone0/temp:40555
> /sys/class/thermal/thermal_zone1/temp:41111
> /sys/class/thermal/thermal_zone0/temp:40555
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
> 
>  drivers/thermal/rockchip_thermal.c | 87 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index e5064d7..3cb2e94 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -23,8 +23,10 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/thermal.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/pinctrl/consumer.h>
>  
>  /**
> @@ -97,7 +99,8 @@ struct rockchip_tsadc_chip {
>  	enum tshut_polarity tshut_polarity;
>  
>  	/* Chip-wide methods */
> -	void (*initialize)(void __iomem *reg, enum tshut_polarity p);
> +	void (*initialize)(struct regmap *grf,
> +			   void __iomem *reg, enum tshut_polarity p);
>  	void (*irq_ack)(void __iomem *reg);
>  	void (*control)(void __iomem *reg, bool on);
>  
> @@ -128,6 +131,7 @@ struct rockchip_thermal_data {
>  	struct clk *clk;
>  	struct clk *pclk;
>  
> +	struct regmap *grf;
>  	void __iomem *regs;
>  
>  	int tshut_temp;
> @@ -142,6 +146,7 @@ struct rockchip_thermal_data {
>   * TSADCV3_* are used for newer SoCs than RK3288. (e.g: RK3228, RK3399)
>   *
>   */
> +#define TSADCV2_USER_CON			0x00
>  #define TSADCV2_AUTO_CON			0x04
>  #define TSADCV2_INT_EN				0x08
>  #define TSADCV2_INT_PD				0x0c
> @@ -177,6 +182,16 @@ struct rockchip_thermal_data {
>  #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
>  #define TSADCV2_AUTO_PERIOD_TIME		250 /* msec */
>  #define TSADCV2_AUTO_PERIOD_HT_TIME		50  /* msec */
> +#define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
> +
> +#define GRF_SARADC_TESTBIT			0x0e644
> +#define GRF_TSADC_TESTBIT_L			0x0e648
> +#define GRF_TSADC_TESTBIT_H			0x0e64c
> +
> +#define GRF_TSADC_TSEN_PD_ON			(0x30003 << 0)
> +#define GRF_TSADC_TSEN_PD_OFF			(0x30000 << 0)
> +#define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
> +#define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
>  
>  struct tsadc_table {
>  	u32 code;
> @@ -449,7 +464,7 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
>   *     If the temperature is higher than COMP_INT or COMP_SHUT for
>   *     "debounce" times, TSADC controller will generate interrupt or TSHUT.
>   */
> -static void rk_tsadcv2_initialize(void __iomem *regs,
> +static void rk_tsadcv2_initialize(struct regmap *grf, void __iomem *regs,
>  				  enum tshut_polarity tshut_polarity)
>  {
>  	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
> @@ -466,6 +481,61 @@ static void rk_tsadcv2_initialize(void __iomem *regs,
>  		       regs + TSADCV2_AUTO_PERIOD_HT);
>  	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
>  		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
> +
> +	if (IS_ERR(grf)) {
> +		pr_warn("%s: Missing rockchip,grf property\n", __func__);
> +		return;
> +	}
> +}
> +
> +/**
> + * rk_tsadcv3_initialize - initialize TASDC Controller.
> + * (1) The tsadc control power sequence.
> + *
> + * (2) Set TSADC_V2_AUTO_PERIOD:
> + *     Configure the interleave between every two accessing of
> + *     TSADC in normal operation.
> + *
> + * (2) Set TSADCV2_AUTO_PERIOD_HT:
> + *     Configure the interleave between every two accessing of
> + *     TSADC after the temperature is higher than COM_SHUT or COM_INT.
> + *
> + * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE:
> + *     If the temperature is higher than COMP_INT or COMP_SHUT for
> + *     "debounce" times, TSADC controller will generate interrupt or TSHUT.
> + */
> +static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
> +				  enum tshut_polarity tshut_polarity)
> +{
> +	/* The tsadc control power sequence */
> +	if (IS_ERR(grf)) {
> +		/* Set interleave value to workround ic time sync issue */
> +		writel_relaxed(TSADCV2_USER_INTER_PD_SOC, regs +
> +			       TSADCV2_USER_CON);
> +	} else {
> +		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_ON);
> +		mdelay(10);
> +		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_OFF);
> +		udelay(100); /* The spec note says at least 15 us */
> +		regmap_write(grf, GRF_SARADC_TESTBIT, GRF_SARADC_TESTBIT_ON);
> +		regmap_write(grf, GRF_TSADC_TESTBIT_H, GRF_TSADC_TESTBIT_H_ON);
> +		udelay(200); /* The spec note says at least 90 us */

Does it make sense to use usleep_range() instead?

> +	}
> +
> +	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
> +		writel_relaxed(0U | TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
> +			       regs + TSADCV2_AUTO_CON);
> +	else
> +		writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
> +			       regs + TSADCV2_AUTO_CON);
> +
> +	writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIOD);
> +	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
> +		       regs + TSADCV2_HIGHT_INT_DEBOUNCE);
> +	writel_relaxed(TSADCV2_AUTO_PERIOD_HT_TIME,
> +		       regs + TSADCV2_AUTO_PERIOD_HT);
> +	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
> +		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
>  }
>  
>  static void rk_tsadcv2_irq_ack(void __iomem *regs)
> @@ -636,7 +706,7 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
>  
> -	.initialize = rk_tsadcv2_initialize,
> +	.initialize = rk_tsadcv3_initialize,
>  	.irq_ack = rk_tsadcv3_irq_ack,
>  	.control = rk_tsadcv3_control,
>  	.get_temp = rk_tsadcv2_get_temp,
> @@ -768,6 +838,11 @@ static int rockchip_configure_from_dt(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	/* The tsadc wont to handle the error in here since some SoCs didn't
> +	 * need this property.
> +	 */
> +	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +
>  	return 0;
>  }
>  
> @@ -888,7 +963,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  		goto err_disable_pclk;
>  	}
>  
> -	thermal->chip->initialize(thermal->regs, thermal->tshut_polarity);
> +	thermal->chip->initialize(thermal->grf, thermal->regs,
> +				  thermal->tshut_polarity);
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		error = rockchip_thermal_register_sensor(pdev, thermal,
> @@ -986,7 +1062,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  
>  	rockchip_thermal_reset_controller(thermal->reset);
>  
> -	thermal->chip->initialize(thermal->regs, thermal->tshut_polarity);
> +	thermal->chip->initialize(thermal->grf, thermal->regs,
> +				  thermal->tshut_polarity);
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		int id = thermal->sensors[i].id;
> -- 
> 1.9.1
> 
