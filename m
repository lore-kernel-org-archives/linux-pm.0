From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Tue, 08 Aug 2017 15:55:56 +0800
Message-ID: <1502178956.4296.7.camel@intel.com>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14017 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbdHHH4B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 03:56:01 -0400
In-Reply-To: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, kong.kongxinwei@hisilicon.com, leo.yan@linaro.org

On Fri, 2017-07-07 at 17:03 +0200, Daniel Lezcano wrote:
> The sensor id is unknown at init time and we use all id in the
> authorized
> MAX_SENSORS interval to register the sensor. On this SoC there is one
> thermal-zone with one sensor on it. No need to spit on the console
> everytime we
> failed to register thermal sensors, information which is deliberaly
> known as it
> is part of the discovery process.
> 
>  hisi_thermal f7030700.tsensor: failed to register sensor id 0: -19
>  hisi_thermal f7030700.tsensor: failed to register thermal sensor:
> -19
>  hisi_thermal f7030700.tsensor: failed to register sensor id 1: -19
>  hisi_thermal f7030700.tsensor: failed to register thermal sensor:
> -19
>  hisi_thermal f7030700.tsensor: failed to register sensor id 3: -19
>  hisi_thermal f7030700.tsensor: failed to register thermal sensor:
> -19
> 
> Remove the error messages.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c
> b/drivers/thermal/hisi_thermal.c
> index f642966..2cc98c6 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -187,6 +187,9 @@ static int hisi_thermal_get_temp(void *_sensor,
> int *temp)
>  
>  	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%d,
> thres=%d\n",
>  		sensor->id, data->irq_enabled, *temp, sensor-
> >thres_temp);
> +
> +	printk("id=%d, irq=%d, temp=%d, thres=%d\n",
> +		sensor->id, data->irq_enabled, *temp, sensor-
> >thres_temp);

what's this printk for?

>  	/*
>  	 * Bind irq to sensor for two cases:
>  	 *   Reenable alarm IRQ if temperature below threshold;
> @@ -260,8 +263,6 @@ static int hisi_thermal_register_sensor(struct
> platform_device *pdev,
>  	if (IS_ERR(sensor->tzd)) {
>  		ret = PTR_ERR(sensor->tzd);
>  		sensor->tzd = NULL;
> -		dev_err(&pdev->dev, "failed to register sensor id
> %d: %d\n",
> -			sensor->id, ret);
>  		return ret;
>  	}
>  
> @@ -352,10 +353,9 @@ static int hisi_thermal_probe(struct
> platform_device *pdev)
>  		ret = hisi_thermal_register_sensor(pdev, data,
>  						   &data-
> >sensors[i], i);
>  		if (ret)
> -			dev_err(&pdev->dev,
> -				"failed to register thermal sensor:
> %d\n", ret);
> -		else
> -			hisi_thermal_toggle_sensor(&data-
> >sensors[i], true);
> +			continue;
> +
> +		hisi_thermal_toggle_sensor(&data->sensors[i], true);
>  	}
>  
>  	return 0;

With these removed, is there any other information in dmesg that
suggests this failure?

thanks,
rui
