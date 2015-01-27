From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-exynos: add support for controlling emmc
 reset pin
Date: Tue, 27 Jan 2015 17:28:35 +0900
Message-ID: <54C74C33.5050305@samsung.com>
References: <1422346289-9348-1-git-send-email-m.szyprowski@samsung.com>
 <1422346289-9348-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422346289-9348-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <Liquid.Acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi, Marek.

your patch should be conflicted with "https://patchwork.kernel.org/patch/5698421/"

On 01/27/2015 05:11 PM, Marek Szyprowski wrote:
> There are boards (like Hardkernel's Odroid boards) on which eMMC card's
> reset line is connected to SoC GPIO line instead of the hardware reset
> logic. In case of such boards, before performing system reboot,
> additional reset of eMMC card is required to boot again properly.
> This patch adds code for handling such cases.

mmc core supported to hw_reset function.
So i think we can use it. It's called at only initial time to clear the previous status.
But i think it can be called at reboot time. (it needs to implement codes.)
how about?

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |  6 +++
>  drivers/mmc/host/dw_mmc-exynos.c                   | 43 +++++++++++++++++++++-
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index ee4fc0576c7d..fc53d335e7db 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -50,6 +50,12 @@ Required Properties:
>        - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
>          phase shift clocks should be 0.
>  
> +Optional properties:
> +
> +* dw-mshc-reset-gpios: optional property specifying gpio for the eMMC nreset
> +  line, it will be triggered on system reboot to properly reset eMMC card for
> +  next system boot.
> +
>  Required properties for a slot (Deprecated - Recommend to use one slot per host):
>  
>  * gpios: specifies a list of gpios used for command, clock and data bus. The
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 509365cb22c6..2add5a93859d 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -12,12 +12,14 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/dw_mmc.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/slab.h>
> +#include <linux/reboot.h>
>  
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> @@ -77,8 +79,23 @@ struct dw_mci_exynos_priv_data {
>  	u32				sdr_timing;
>  	u32				ddr_timing;
>  	u32				cur_speed;
> +	struct gpio_desc 		*reset_gpio;
> +	struct notifier_block		reset_nb;
>  };
>  
> +static int dw_mci_restart_handler(struct notifier_block *this,
> +				  unsigned long mode, void *cmd)
> +{
> +	struct dw_mci_exynos_priv_data *data;
> +	data = container_of(this, struct dw_mci_exynos_priv_data, reset_nb);
> +
> +	gpiod_direction_output(data->reset_gpio, 0);
> +	mdelay(150);
> +	gpiod_direction_output(data->reset_gpio, 1);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static struct dw_mci_exynos_compatible {
>  	char				*compatible;
>  	enum dw_mci_exynos_type		ctrl_type;
> @@ -295,7 +312,20 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>  		return ret;
>  
>  	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
> +
> +	priv->reset_gpio = devm_gpiod_get_optional(host->dev,
> +						   "samsung,dw-mshc-reset",
> +						   GPIOD_OUT_HIGH);
> +	if (!IS_ERR_OR_NULL(priv->reset_gpio)) {
> +		priv->reset_nb.notifier_call = dw_mci_restart_handler;
> +		priv->reset_nb.priority = 255;
> +		ret = register_restart_handler(&priv->reset_nb);
> +		if (ret)
> +			dev_err(host->dev, "cannot register restart handler\n");
> +	}
> +
>  	host->priv = priv;
> +
>  	return 0;
>  }
>  
> @@ -490,6 +520,17 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
>  	return dw_mci_pltfm_register(pdev, drv_data);
>  }
>  
> +static int dw_mci_exynos_remove(struct platform_device *pdev)
> +{
> +	struct dw_mci *host = platform_get_drvdata(pdev);
> +	struct dw_mci_exynos_priv_data *priv = host->priv;
> +
> +	if (priv->reset_gpio)
> +		unregister_restart_handler(&priv->reset_nb);
> +
> +	return dw_mci_pltfm_remove(pdev);
> +}
> +
>  static const struct dev_pm_ops dw_mci_exynos_pmops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend, dw_mci_exynos_resume)
>  	.resume_noirq = dw_mci_exynos_resume_noirq,
> @@ -499,7 +540,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops = {
>  
>  static struct platform_driver dw_mci_exynos_pltfm_driver = {
>  	.probe		= dw_mci_exynos_probe,
> -	.remove		= __exit_p(dw_mci_pltfm_remove),
> +	.remove		= dw_mci_exynos_remove,
>  	.driver		= {
>  		.name		= "dwmmc_exynos",
>  		.of_match_table	= dw_mci_exynos_match,
> 
