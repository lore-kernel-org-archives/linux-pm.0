From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 05/13] thermal/drivers/hisi: Fix multiple alarm
 interrupts firing
Date: Fri, 1 Sep 2017 22:40:19 +0800
Message-ID: <20170901144019.GA19958@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36858 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdIAOk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 10:40:29 -0400
Received: by mail-pg0-f49.google.com with SMTP id r133so1126508pgr.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2017 07:40:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504082857-21702-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>

On Wed, Aug 30, 2017 at 10:47:29AM +0200, Daniel Lezcano wrote:
> The DT specifies a threshold of 65000, we setup the register with a value in
> the temperature resolution for the controller, 64656.
> 
> When we reach 64656, the interrupt fires, the interrupt is disabled. Then the
> irq thread runs and calls thermal_zone_device_update() which will call in turn
> hisi_thermal_get_temp().
> 
> The function will look if the temperature decreased, assuming it was more than
> 65000, but that is not the case because the current temperature is 64656
> (because of the rounding when setting the threshold). This condition being
> true, we re-enable the interrupt which fires immediately after exiting the irq
> thread. That happens again and again until the temperature goes to more than
> 65000.
> 
> Potentially, there is here an interrupt storm if the temperature stabilizes at
> this temperature. A very unlikely case but possible.
> 
> In any case, it does not make sense to handle dozens of alarm interrupt for
> nothing.
> 
> Fix this by rounding the threshold value to the controller resolution so the
> check against the threshold is consistent with the one set in the controller.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This is a good fixing. I do see when the temperature over the tipping
point, if without this patch it's possible to generate interrupt for
2~3 times; after applied this patch it always generate single
interrupt.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/thermal/hisi_thermal.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index b58ad40..524310d 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -90,6 +90,12 @@ static inline long hisi_thermal_temp_to_step(long temp)
>  	return (temp - HISI_TEMP_BASE) / HISI_TEMP_STEP;
>  }
>  
> +static inline long hisi_thermal_round_temp(int temp)
> +{
> +	return hisi_thermal_step_to_temp(
> +		hisi_thermal_temp_to_step(temp));
> +}
> +
>  static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
>  					 struct hisi_thermal_sensor *sensor)
>  {
> @@ -221,7 +227,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>  	sensor = &data->sensors;
>  
>  	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
> -		 sensor->thres_temp / 1000);
> +		 sensor->thres_temp);
>  	mutex_unlock(&data->thermal_lock);
>  
>  	thermal_zone_device_update(data->sensors.tzd,
> @@ -255,7 +261,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
>  
>  	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
>  		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
> -			sensor->thres_temp = trip[i].temperature;
> +			sensor->thres_temp = hisi_thermal_round_temp(trip[i].temperature);
>  			break;
>  		}
>  	}
> -- 
> 2.7.4
> 
