From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 8/9] pinctrl: samsung: Add runtime PM support
Date: Sun, 25 Dec 2016 21:26:47 +0200
Message-ID: <20161225192647.omy6qnd6pe4aaoud@kozik-lap>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122542epcas1p444c9d8c91c2983f9934e68a6bb882726@epcas1p4.samsung.com>
 <1482495889-6201-9-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34833 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbcLYT0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Dec 2016 14:26:52 -0500
Content-Disposition: inline
In-Reply-To: <1482495889-6201-9-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Dec 23, 2016 at 01:24:48PM +0100, Marek Szyprowski wrote:
> This patch adds runtime power management support to Samsung pin controller
> driver. It uses recently introduced property to mark some pin states as
> suitable for power off. When all pins for given controller are set to this
> special state, the controller is able to enter runtime suspend state. This
> in turn might allow to turn respective power domain off to reduce power
> consumption.
> 
> This patch moves saving driver state to runtime pm callbacks and implements
> system sleep suspend/resume callbacks with pm_runtime_force_suspend/resume
> helpers to keep the runtime pm state consistent with the hardware both
> during runtime and system sleep transitions.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 24 ++++++++++++++++++++++--
>  drivers/pinctrl/samsung/pinctrl-samsung.h |  1 +
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 301169d2b6e1..c741e93d65b8 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -28,6 +28,7 @@
>  #include <linux/gpio.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  
>  #include "../core.h"
> @@ -378,6 +379,17 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
>  		shift -= 32;
>  		reg += 4;
>  	}
> +	if (func->rpm_active) {
> +		if (!(bank->rpm_map & (1 << pin_offset))) {
> +			bank->rpm_map |= 1 << pin_offset;
> +			pm_runtime_get_sync(drvdata->dev);
> +		}
> +	} else {
> +		if ((bank->rpm_map & (1 << pin_offset))) {
> +			bank->rpm_map &= ~(1 << pin_offset);
> +			pm_runtime_put(drvdata->dev);
> +		}
> +	}
>  
>  	spin_lock_irqsave(&bank->slock, flags);
>  
> @@ -427,6 +439,8 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
>  	if (cfg_type >= PINCFG_TYPE_NUM || !type->fld_width[cfg_type])
>  		return -EINVAL;
>  
> +	pm_runtime_get_sync(drvdata->dev);
> +
>  	width = type->fld_width[cfg_type];
>  	cfg_reg = type->reg_offset[cfg_type];
>  
> @@ -449,6 +463,8 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
>  
>  	spin_unlock_irqrestore(&bank->slock, flags);
>  
> +	pm_runtime_put(drvdata->dev);
> +
>  	return 0;
>  }
>  
> @@ -1096,6 +1112,8 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>  		ctrl->retention_init(drvdata);
>  
>  	platform_set_drvdata(pdev, drvdata);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
>  
>  	return 0;
>  }
> @@ -1242,8 +1260,10 @@ static int samsung_pinctrl_resume(struct device *dev)
>  MODULE_DEVICE_TABLE(of, samsung_pinctrl_dt_match);
>  
>  static const struct dev_pm_ops samsung_pinctrl_pm_ops = {
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(samsung_pinctrl_suspend,
> -				     samsung_pinctrl_resume)
> +	SET_RUNTIME_PM_OPS(samsung_pinctrl_suspend,
> +			   samsung_pinctrl_resume, NULL)
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				     pm_runtime_force_resume)
>  };
>  
>  static struct platform_driver samsung_pinctrl_driver = {
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
> index edeafa00abd3..ccb24ec46796 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
> @@ -172,6 +172,7 @@ struct samsung_pin_bank {

A nit:
Missing kernel doc update.

It took me a while to understand the logic behind the rpm_active (the
code is simple but logic was not that easy to see) but it looks good and
sensible. I didn't find any issues with that approach except the usage
of DT configuration as a "notification" mechanism.

For this itself:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


>  	const char	*name;
>  
>  	u32		pin_base;
> +	u32		rpm_map;
>  	void		*soc_priv;
>  	struct device_node *of_node;
>  	struct samsung_pinctrl_drv_data *drvdata;
> -- 
> 1.9.1
> 
