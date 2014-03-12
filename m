From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 4/4] devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro
 instead of legacy method
Date: Wed, 12 Mar 2014 16:22:49 +0100
Message-ID: <1869652.x5hcu1bJcu@amdc1032>
References: <1394624882-2989-1-git-send-email-cw00.choi@samsung.com>
 <1394624882-2989-5-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32902 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbaCLPXH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Mar 2014 11:23:07 -0400
In-reply-to: <1394624882-2989-5-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org


Hi,

On Wednesday, March 12, 2014 08:48:02 PM Chanwoo Choi wrote:
> This patch use SET_SYSTEM_SLEEP_PM_OPS macro instead of legacy method. Also,
> Before entering suspend state, disable ppmu's clock to remove power-leakage
> in suspend state.

The main thing that this patch does is adding ->suspend method and PPMU
clocks handling and this should be reflected in the patch summary (i.e.
"devfreq: exynos4: fix PM suspend/resume handling for PPMU clocks") and in
the patch description. The fact that the patch also converts code to use
SET_SYSTEM_SLEEP_PM_OPS() macro is secondary.

> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/exynos/exynos4_bus.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
> index 0c5b99e..7e1540a 100644
> --- a/drivers/devfreq/exynos/exynos4_bus.c
> +++ b/drivers/devfreq/exynos/exynos4_bus.c
> @@ -1229,16 +1229,40 @@ static int exynos4_busfreq_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int exynos4_busfreq_resume(struct device *dev)
>  {
>  	struct busfreq_data *data = dev_get_drvdata(dev);
> +	int i;
> +
> +	/* Enable clock after wake-up from suspend state */
> +	for (i = 0; i < PPMU_END; i++)
> +		clk_prepare_enable(data->clk_ppmu[i]);
>  
> +	/* Reset PPMU to check utilization again */
>  	busfreq_mon_reset(data);
> +
> +	return 0;
> +}
> +
> +static int exynos4_busfreq_suspend(struct device *dev)
> +{
> +	struct busfreq_data *data = dev_get_drvdata(dev);
> +	int i;
> +
> +	/*
> +	 * Disable clock before entering suspend state
> +	 * to reduce leakage power on suspend state.
> +	 */
> +	for (i = 0; i < PPMU_END; i++)
> +		clk_disable_unprepare(data->clk_ppmu[i]);
> +
>  	return 0;
>  }
> +#endif
>  
>  static const struct dev_pm_ops exynos4_busfreq_pm = {
> -	.resume	= exynos4_busfreq_resume,
> +	SET_SYSTEM_SLEEP_PM_OPS(exynos4_busfreq_suspend, exynos4_busfreq_resume)
>  };
>  
>  static const struct platform_device_id exynos4_busfreq_id[] = {

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

