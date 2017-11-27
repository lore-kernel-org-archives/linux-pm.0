From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/4] thermal: imx: Use better parameter names than "val"
Date: Mon, 27 Nov 2017 20:39:31 +0200
Message-ID: <1511807971.20123.29.camel@nxp.com>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
         <20171121200225.23316-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:19359
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751360AbdK0Sji (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Nov 2017 13:39:38 -0500
In-Reply-To: <20171121200225.23316-2-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel@pengutronix.de

On Tue, 2017-11-21 at 21:02 +0100, Uwe Kleine-König wrote:
> The values passed to imx_init_calib() and imx_init_temp_grade() are
> read from specific OCOTP values. Use their names (in lower case) as
> parameter name instead of "val" to make the code easier to understand.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/thermal/imx_thermal.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index e7d4ffc3de7f..21b8c4c4da3c 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -347,13 +347,13 @@ static struct thermal_zone_device_ops imx_tz_ops = {
>  	.set_trip_temp = imx_set_trip_temp,
>  };
>  
> -static int imx_init_calib(struct platform_device *pdev, u32 val)
> +static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
>  {
>  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
>  	int t1, n1;
>  	u64 temp64;
>  
> -	if (val == 0 || val == ~0) {
> +	if (ocotp_ana1 == 0 || ocotp_ana1 == ~0) {
>  		dev_err(&pdev->dev, "invalid sensor calibration data\n");
>  		return -EINVAL;
>  	}
> @@ -364,7 +364,7 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
>  	 * Use universal formula now and only need sensor value @ 25C
>  	 * slope = 0.4297157 - (0.0015976 * 25C fuse)
>  	 */
> -	n1 = val >> 20;
> +	n1 = ocotp_ana1 >> 20;
>  	t1 = 25; /* t1 always 25C */
>  
>  	/*
> @@ -392,12 +392,12 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
>  	return 0;
>  }
>  
> -static void imx_init_temp_grade(struct platform_device *pdev, u32 val)
> +static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)

On imx7 (thermal not currently supported in upstream) the temperature
grade is in OCOTP_TESTER3. So using a more generic parameter name here
would be preferable or this would have to be changed again later.

Unfortunately I can't find a good reference for the imx7 fusemap. But
the IMX7D Reference Manual mentions a speed grade in 0x440 and
something else for 0x480.

--
Regards,
Leonard
