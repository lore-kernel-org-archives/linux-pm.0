From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 06/13] thermal/drivers/hisi: Remove pointless lock
Date: Fri, 1 Sep 2017 22:44:29 +0800
Message-ID: <20170901144429.GB19958@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36696 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdIAOoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 10:44:38 -0400
Received: by mail-pg0-f42.google.com with SMTP id r133so1155875pgr.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2017 07:44:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504082857-21702-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>

On Wed, Aug 30, 2017 at 10:47:30AM +0200, Daniel Lezcano wrote:
> The threaded interrupt inspect the sensors structure to look in the temp
> threshold field, but this field is read-only in all the code, except in the
> probe function before the threaded interrupt is set. In other words there
> is not race window in the threaded interrupt when reading the field value.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/thermal/hisi_thermal.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 524310d..6f0dab1 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -221,14 +221,10 @@ static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
>  static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>  {
>  	struct hisi_thermal_data *data = dev;
> -	struct hisi_thermal_sensor *sensor;
> -
> -	mutex_lock(&data->thermal_lock);
> -	sensor = &data->sensors;
> +	struct hisi_thermal_sensor *sensor = &data->sensors;
>  
>  	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
>  		 sensor->thres_temp);
> -	mutex_unlock(&data->thermal_lock);
>  
>  	thermal_zone_device_update(data->sensors.tzd,
>  				   THERMAL_EVENT_UNSPECIFIED);
> -- 
> 2.7.4
> 
