From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal/drivers/generic-iio-adc: Switch tz request to
 devm version
Date: Thu, 7 Sep 2017 19:56:07 -0700
Message-ID: <20170908025606.GA2755@localhost.localdomain>
References: <1504808230-12288-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34003 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbdIHC4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2017 22:56:10 -0400
Content-Disposition: inline
In-Reply-To: <1504808230-12288-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: ldewangan@nvidia.com, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, open list <linux-kernel@vger.kernel.org>

Hey Daniel,

On Thu, Sep 07, 2017 at 08:17:10PM +0200, Daniel Lezcano wrote:
> Everything mentionned here:
>  https://lkml.org/lkml/2016/4/20/850
> 
> This driver was added before the devm_iio_channel_get() function version was
> merged. The sensor should be released before the iio channel, thus we had to
> use the non-devm version of thermal_zone_of_sensor_register().
> 
> Now the devm_iio_channel_get() is available, do the corresponding change in
> this driver.
> 
> [Compiled tested only]
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal-generic-adc.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index 73f55d6..71d0365 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -126,28 +126,23 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>  	gti->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, gti);
>  
> -	gti->channel = iio_channel_get(&pdev->dev, "sensor-channel");
> +	gti->channel = devm_iio_channel_get(&pdev->dev, "sensor-channel");
>  	if (IS_ERR(gti->channel)) {
>  		ret = PTR_ERR(gti->channel);
>  		dev_err(&pdev->dev, "IIO channel not found: %d\n", ret);
>  		return ret;
>  	}
>  
> -	gti->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0,
> -						      gti, &gadc_thermal_ops);
> +	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, gti,
> +							   &gadc_thermal_ops);
>  	if (IS_ERR(gti->tz_dev)) {
>  		ret = PTR_ERR(gti->tz_dev);
>  		dev_err(&pdev->dev, "Thermal zone sensor register failed: %d\n",
>  			ret);
> -		goto sensor_fail;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -sensor_fail:
> -	iio_channel_release(gti->channel);
> -
> -	return ret;
>  }
>  
>  static int gadc_thermal_remove(struct platform_device *pdev)

Any particular reason why this patch does not include a removal of
gadc_thermal_remove()?


> -- 
> 2.7.4
> 
