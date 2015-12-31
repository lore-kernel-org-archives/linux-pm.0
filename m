From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: imx: update the temperature calibration data
 for imx6 soc
Date: Thu, 31 Dec 2015 09:50:57 -0800
Message-ID: <20151231175048.GA13409@localhost.localdomain>
References: <1450682876-26725-1-git-send-email-ping.bai@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33150 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbLaRvA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Dec 2015 12:51:00 -0500
Received: by mail-pf0-f175.google.com with SMTP id q63so122704491pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Dec 2015 09:51:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450682876-26725-1-git-send-email-ping.bai@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bai Ping <ping.bai@nxp.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org

On Mon, Dec 21, 2015 at 03:27:56PM +0800, Bai Ping wrote:
> According to the design team:
> 
> After a thorough accuracy study of the Temp sense circuit,we found that
> with our current equation, an average part can read 7 degrees lower than
> a known forced temperature. We also found out that the standard variance
> was around 2C; which is the tightest distribution that we could create.
> We need to change the temp sense equation to center the average
> part around the target temperature.
> 
> Old Equation:
> 
> Temp = Troom,cal - slope*(Count measured - Count room fuse)
> Where Troom,cal = 25C and Slope = 0.4297157 - (0.0015974 * Count room fuse)
> 
> New Equation:
> 
> Temp = Troom,cal - slope*(Count measured - Count room fuse) +offset
> Where Troom,cal = 25C and Slope = 0.4148468 - (0.0015423 * Count room fuse)
> Offset = 3.580661
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  drivers/thermal/imx_thermal.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index c5547bd..9fb613e 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -69,8 +69,9 @@ enum imx_thermal_trip {
>  #define IMX_PASSIVE_DELAY		1000
>  
>  #define FACTOR0				10000000
> -#define FACTOR1				15976
> -#define FACTOR2				4297157
> +#define FACTOR1				15423
> +#define FACTOR2				4148468
> +#define OFFSET				3580661
>  
>  #define TEMPMON_IMX6Q			1
>  #define TEMPMON_IMX6SX			2
> @@ -385,23 +386,26 @@ static int imx_get_sensor_data(struct platform_device *pdev)
>  	 * Derived from linear interpolation:
>  	 * slope = 0.4297157 - (0.0015976 * 25C fuse)
>  	 * slope = (FACTOR2 - FACTOR1 * n1) / FACTOR0
> +	 * offset = OFFSET / 1000000
>  	 * (Nmeas - n1) / (Tmeas - t1) = slope
>  	 * We want to reduce this down to the minimum computation necessary
>  	 * for each temperature read.  Also, we want Tmeas in millicelsius
>  	 * and we don't want to lose precision from integer division. So...
> -	 * Tmeas = (Nmeas - n1) / slope + t1
> -	 * milli_Tmeas = 1000 * (Nmeas - n1) / slope + 1000 * t1
> -	 * milli_Tmeas = -1000 * (n1 - Nmeas) / slope + 1000 * t1
> +	 * Tmeas = (Nmeas - n1) / slope + t1 + offset
> +	 * milli_Tmeas = 1000 * (Nmeas - n1) / slope + 1000 * t1 + OFFSET / 1000
> +	 * milli_Tmeas = -1000 * (n1 - Nmeas) / slope + 1000 * t1 + OFFSET / 1000
>  	 * Let constant c1 = (-1000 / slope)
> -	 * milli_Tmeas = (n1 - Nmeas) * c1 + 1000 * t1
> -	 * Let constant c2 = n1 *c1 + 1000 * t1
> +	 * milli_Tmeas = (n1 - Nmeas) * c1 + 1000 * t1 + OFFSET / 1000
> +	 * Let constant c2 = n1 *c1 + 1000 * t1 + OFFSET / 1000
>  	 * milli_Tmeas = c2 - Nmeas * c1
>  	 */
>  	temp64 = FACTOR0;
>  	temp64 *= 1000;
>  	do_div(temp64, FACTOR1 * n1 - FACTOR2);
>  	data->c1 = temp64;
> -	data->c2 = n1 * data->c1 + 1000 * t1;
> +	temp64 = OFFSET;
> +	do_div(temp64, 1000);
> +	data->c2 = n1 * data->c1 + 1000 * t1 + temp64;

Dear Bai Ping. Can you please get at least on Tested-by response in the
mailing list for this patch from one of your co-workers, for example?

Meanwhile, a couple of questions:

Does this offset work well on all chip distribution?

Do we need a different offset for different soc revision ? Is the same
offset applicable to IMX6Q and to IMX6SX?

I strong recommend you to translate this driver to add of-thermal
support. This is more than desirable, specially considering the type of
changes you are in a need, such as the one above. This is better
described in DT, not in the driver code.


>  
>  	/* use OTP for thermal grade */
>  	ret = regmap_read(map, OCOTP_MEM0, &val);
> -- 
> 1.9.1
> 
