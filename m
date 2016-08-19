From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: imx: fix a possible NULL dereference
Date: Fri, 19 Aug 2016 21:17:34 +0800
Message-ID: <1471612654.2691.76.camel@intel.com>
References: <1471337498-6382-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471337498-6382-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 二, 2016-08-16 at 10:51 +0200, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later at line 472:
> data->socdata = of_id->data;
> 
> For fixing this problem, we use of_device_get_match_data(), this will
> simplify the code a little by using a standard function for
> getting the match data.
> 
> Reported-by: coverity (CID 1324128)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

patch applied.

thanks,
rui
> ---
>  drivers/thermal/imx_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c
> b/drivers/thermal/imx_thermal.c
> index c5547bd..e473548b 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -471,8 +471,6 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  
>  static int imx_thermal_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *of_id =
> -		of_match_device(of_imx_thermal_match, &pdev->dev);
>  	struct imx_thermal_data *data;
>  	struct regmap *map;
>  	int measure_freq;
> @@ -490,7 +488,7 @@ static int imx_thermal_probe(struct
> platform_device *pdev)
>  	}
>  	data->tempmon = map;
>  
> -	data->socdata = of_id->data;
> +	data->socdata = of_device_get_match_data(&pdev->dev);
>  
>  	/* make sure the IRQ flag is clear before enabling irq on
> i.MX6SX */
>  	if (data->socdata->version == TEMPMON_IMX6SX) {
