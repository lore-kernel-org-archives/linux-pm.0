From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] power: supply: ab8500_btemp: convert to IIO ADC
Date: Sat, 14 Jan 2017 14:54:29 +0000
Message-ID: <8d0cadba-940e-ede4-f04f-042a3fecae59@kernel.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170110234745.29691-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170110234745.29691-2-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Mboumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 10/01/17 23:47, Linus Walleij wrote:
> This switches the AB8500 battery temperature driver to using
> the standard IIO ADC channel lookup and conversion routines.
> 
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
A comment inline on how I'm being useless and not getting round
to cleaning up the handling of consumers in IIO to avoid
the need for messing around in the deferred case...

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/power/supply/ab8500_btemp.c | 41 ++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
> index 6ffdc18f2599..61161db5cffa 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -26,7 +26,7 @@
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/mfd/abx500/ab8500-bm.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
> +#include <linux/iio/consumer.h>
>  
>  #define VTVOUT_V			1800
>  
> @@ -79,7 +79,8 @@ struct ab8500_btemp_ranges {
>   * @bat_temp:		Dispatched battery temperature in degree Celcius
>   * @prev_bat_temp	Last measured battery temperature in degree Celcius
>   * @parent:		Pointer to the struct ab8500
> - * @gpadc:		Pointer to the struct gpadc
> + * @adc_btemp_ball:	ADC channel for the battery ball temperature
> + * @adc_bat_ctrl:	ADC channel for the battery control
>   * @fg:			Pointer to the struct fg
>   * @bm:           	Platform specific battery management information
>   * @btemp_psy:		Structure for BTEMP specific battery properties
> @@ -96,7 +97,8 @@ struct ab8500_btemp {
>  	int bat_temp;
>  	int prev_bat_temp;
>  	struct ab8500 *parent;
> -	struct ab8500_gpadc *gpadc;
> +	struct iio_channel *btemp_ball;
> +	struct iio_channel *bat_ctrl;
>  	struct ab8500_fg *fg;
>  	struct abx500_bm_data *bm;
>  	struct power_supply *btemp_psy;
> @@ -180,13 +182,13 @@ static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
>   */
>  static int ab8500_btemp_read_batctrl_voltage(struct ab8500_btemp *di)
>  {
> -	int vbtemp;
> +	int vbtemp, ret;
>  	static int prev;
>  
> -	vbtemp = ab8500_gpadc_convert(di->gpadc, BAT_CTRL);
> -	if (vbtemp < 0) {
> +	ret = iio_read_channel_processed(di->bat_ctrl, &vbtemp);
> +	if (ret < 0) {
>  		dev_err(di->dev,
> -			"%s gpadc conversion failed, using previous value",
> +			"%s ADC conversion failed, using previous value",
>  			__func__);
>  		return prev;
>  	}
> @@ -501,7 +503,7 @@ static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
>   */
>  static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
>  {
> -	int temp;
> +	int temp, ret;
>  	static int prev;
>  	int rbat, rntc, vntc;
>  	u8 id;
> @@ -526,10 +528,10 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
>  			di->bm->bat_type[id].r_to_t_tbl,
>  			di->bm->bat_type[id].n_temp_tbl_elements, rbat);
>  	} else {
> -		vntc = ab8500_gpadc_convert(di->gpadc, BTEMP_BALL);
> -		if (vntc < 0) {
> +		ret = iio_read_channel_processed(di->btemp_ball, &vntc);
> +		if (ret < 0) {
>  			dev_err(di->dev,
> -				"%s gpadc conversion failed,"
> +				"%s ADC conversion failed,"
>  				" using previous value\n", __func__);
>  			return prev;
>  		}
> @@ -1085,7 +1087,22 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
>  	/* get parent data */
>  	di->dev = &pdev->dev;
>  	di->parent = dev_get_drvdata(pdev->dev.parent);
> -	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> +
> +	/* Get ADC channels */
> +	di->btemp_ball = devm_iio_channel_get(&pdev->dev, "btemp_ball");
> +	if (IS_ERR(di->btemp_ball)) {
> +		if (PTR_ERR(di->btemp_ball) == -ENODEV)
> +                        return -EPROBE_DEFER;
I (or someone else) still needs to look at reworking our in kernel stuff so
that this sort of trickery isn't needed.  Won't do any harm having this there
in the meantime.
> +		dev_err(&pdev->dev, "failed to get BTEMP BALL ADC channel\n");
> +		return PTR_ERR(di->btemp_ball);
> +	}
> +	di->bat_ctrl = devm_iio_channel_get(&pdev->dev, "bat_ctrl");
> +	if (IS_ERR(di->bat_ctrl)) {
> +		if (PTR_ERR(di->bat_ctrl) == -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get BAT CTRL ADC channel\n");
> +		return PTR_ERR(di->bat_ctrl);
> +	}
>  
>  	di->initialized = false;
>  
> 
