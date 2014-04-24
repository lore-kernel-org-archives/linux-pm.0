From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] thermal: samsung: Only update available threshold limits
Date: Thu, 24 Apr 2014 12:48:38 +0200
Message-ID: <1705902.4858U1S3Zd@amdc1032>
References: <1397453895-6688-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1397453895-6688-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, April 14, 2014 11:08:15 AM Tushar Behera wrote:
> Currently the threshold limits are updated in 2 stages, once for all
> software trigger levels and again for hardware trip point.
> 
> While updating the software trigger levels, it overwrites the threshold
> limit for hardware trip point thereby forcing the Exynos core to issue
> an emergency shutdown.

On what SoC type have you encountered this problem?  It doesn't seem to
happen on older SoCs (at least Exynos4210 and Exynos4x12 ones).

> Updating only the required fields in threshold register fixes this issue.

With the current code there is indeed a time window during which threshold
limit for hardware trip point is set to zero so the fix is correct.

> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
> Based on v3.15-rc1.
> 
>  drivers/thermal/samsung/exynos_tmu.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 0d96a51..ffccc89 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -225,6 +225,8 @@ skip_calib_data:
>  			trigger_levs++;
>  	}
>  
> +	rising_threshold = readl(data->base + reg->threshold_th0);

You may move this inside "} else {" block as rising_threshold
is not used for data->soc == SOC_ARCH_EXYNOS4210 case.

Also rising_threshold initialization to zero at the beginning of
exynos_tmu_initialize() is not needed anylonger.

> +
>  	if (data->soc == SOC_ARCH_EXYNOS4210) {
>  		/* Write temperature code for threshold */
>  		threshold_code = temp_to_code(data, pdata->threshold);
> @@ -249,6 +251,7 @@ skip_calib_data:
>  				ret = threshold_code;
>  				goto out;
>  			}
> +			rising_threshold &= ~(0xff << 8 * i);
>  			rising_threshold |= threshold_code << 8 * i;
>  			if (pdata->threshold_falling) {
>  				threshold_code = temp_to_code(data,
> @@ -281,6 +284,7 @@ skip_calib_data:
>  			}
>  			if (i == EXYNOS_MAX_TRIGGER_PER_REG - 1) {
>  				/* 1-4 level to be assigned in th0 reg */
> +				rising_threshold &= ~(0xff << 8 * i);
>  				rising_threshold |= threshold_code << 8 * i;
>  				writel(rising_threshold,
>  					data->base + reg->threshold_th0);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
