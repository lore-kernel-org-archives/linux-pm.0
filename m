From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 10/13] thermal/drivers/hisi: Rename and remove unused
 field
Date: Sat, 2 Sep 2017 11:36:24 +0800
Message-ID: <20170902033624.GC3841@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-10-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36737 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdIBDgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 23:36:33 -0400
Received: by mail-pg0-f49.google.com with SMTP id r133so5284507pgr.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2017 20:36:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1504082857-21702-10-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>

On Wed, Aug 30, 2017 at 10:47:34AM +0200, Daniel Lezcano wrote:
> Rename the 'sensors' field to 'sensor' as we describe only one sensor.
> Remove the 'sensor_temp' as it is no longer used.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/thermal/hisi_thermal.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index b038d8a..68b625c 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -47,8 +47,6 @@
>  struct hisi_thermal_sensor {
>  	struct hisi_thermal_data *thermal;
>  	struct thermal_zone_device *tzd;
> -
> -	long sensor_temp;
>  	uint32_t id;
>  	uint32_t thres_temp;
>  };
> @@ -57,9 +55,9 @@ struct hisi_thermal_data {
>  	struct mutex thermal_lock;    /* protects register data */
>  	struct platform_device *pdev;
>  	struct clk *clk;
> -	struct hisi_thermal_sensor sensors;
> -	int irq;
> +	struct hisi_thermal_sensor sensor;
>  	void __iomem *regs;
> +	int irq;
>  };
>  
>  /*
> @@ -229,7 +227,7 @@ static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
>  static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>  {
>  	struct hisi_thermal_data *data = dev;
> -	struct hisi_thermal_sensor *sensor = &data->sensors;
> +	struct hisi_thermal_sensor *sensor = &data->sensor;
>  	int temp;
>  
>  	hisi_thermal_alarm_clear(data->regs, 1);
> @@ -240,7 +238,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>  		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
>  			 temp, sensor->thres_temp);
>  
> -		thermal_zone_device_update(data->sensors.tzd,
> +		thermal_zone_device_update(data->sensor.tzd,
>  					   THERMAL_EVENT_UNSPECIFIED);
>  
>  	} else if (temp < sensor->thres_temp) {
> @@ -303,7 +301,7 @@ static int hisi_thermal_setup(struct hisi_thermal_data *data)
>  {
>  	struct hisi_thermal_sensor *sensor;
>  
> -	sensor = &data->sensors;
> +	sensor = &data->sensor;
>  
>  	/* disable module firstly */
>  	hisi_thermal_reset_enable(data->regs, 0);
> @@ -376,7 +374,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = hisi_thermal_register_sensor(pdev, data,
> -					   &data->sensors,
> +					   &data->sensor,
>  					   HISI_DEFAULT_SENSOR);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
> @@ -398,7 +396,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	hisi_thermal_toggle_sensor(&data->sensors, true);
> +	hisi_thermal_toggle_sensor(&data->sensor, true);
>  
>  	return 0;
>  }
> @@ -406,7 +404,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  static int hisi_thermal_remove(struct platform_device *pdev)
>  {
>  	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
> -	struct hisi_thermal_sensor *sensor = &data->sensors;
> +	struct hisi_thermal_sensor *sensor = &data->sensor;
>  
>  	hisi_thermal_toggle_sensor(sensor, false);
>  	hisi_thermal_disable_sensor(data);
> -- 
> 2.7.4
> 
