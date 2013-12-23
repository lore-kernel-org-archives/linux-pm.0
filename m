From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] thermal: imx: correct suspend/resume flow
Date: Mon, 23 Dec 2013 22:29:33 +0800
Message-ID: <20131223142931.GM26070@S2101-09.ap.freescale.net>
References: <1387831918-17028-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387831918-17028-1-git-send-email-b20788@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 23, 2013 at 03:51:58PM -0500, Anson Huang wrote:
> Current imx thermal sensor's suspend function will return fail if
> thermal sensor is always enabled, but because alarm function is enabled,
> thermal sensor will be always enabled as well, hence break system's suspend,
> this patch will disable thermal sensor before suspend and re-enable it
> after resume, it fixes the failure of suspend/resume caused by thermal driver.

We should probably make it clear in the commit log that it's a
regression caused by commit 37713a1 (thermal: imx: implement thermal
alarm interrupt handling).

> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  drivers/thermal/imx_thermal.c |   31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index cbb16f3..9a9a6c2 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -510,27 +510,30 @@ static int imx_thermal_suspend(struct device *dev)
>  {
>  	struct imx_thermal_data *data = dev_get_drvdata(dev);
>  	struct regmap *map = data->tempmon;
> -	u32 val;
>  
> -	regmap_read(map, TEMPSENSE0, &val);
> -	if ((val & TEMPSENSE0_POWER_DOWN) == 0) {
> -		/*
> -		 * If a measurement is taking place, wait for a long enough
> -		 * time for it to finish, and then check again.  If it still
> -		 * does not finish, something must go wrong.
> -		 */
> -		udelay(50);
> -		regmap_read(map, TEMPSENSE0, &val);
> -		if ((val & TEMPSENSE0_POWER_DOWN) == 0)
> -			return -ETIMEDOUT;
> -	}
> +	/*
> +	 * Need to disable thermal sensor, otherwise, when thermal core
> +	 * try to get temperature before thermal sensor resume, a wrong
> +	 * temperature will be read as the thermal sensor is powered
> +	 * down.
> +	 */
> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
> +	data->mode = THERMAL_DEVICE_DISABLED;

Is it really necessary to update data->mode through suspend/resume
cycle?

Shawn

>  
>  	return 0;
>  }
>  
>  static int imx_thermal_resume(struct device *dev)
>  {
> -	/* Nothing to do for now */
> +	struct imx_thermal_data *data = dev_get_drvdata(dev);
> +	struct regmap *map = data->tempmon;
> +
> +	/* Enabled thermal sensor after resume */
> +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
> +	data->mode = THERMAL_DEVICE_ENABLED;
> +
>  	return 0;
>  }
>  #endif
> -- 
> 1.7.9.5
> 
> 
