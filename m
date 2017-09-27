From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal/drivers/hisi: Switch to interrupt mode
Date: Wed, 27 Sep 2017 13:56:20 +0530
Message-ID: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
References: <1506470049-12597-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:40097 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbdI0I1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2017 04:27:11 -0400
In-Reply-To: <1506470049-12597-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>



On Wednesday 27 September 2017 05:24 AM, Daniel Lezcano wrote:
> At this moment, we have both the interrupt setup and the polling enabled. The
> interrupt does nothing more than forcing an update while the temperature is
> polled every second.
> 
> We can do much better than that, threshold is set to 65C in the DT and the
> passive ooling device enters in the dance when 75C is reached. We need to

/s/ooling/cooling

> sample the temperature at 65C in order to let the IPA gather enough values for
> the PID computation. If the SoC is running at a temperature below 65C, we will
> be constantly polling for nothing.
> 
> This patch disables the sensor when the temperature is below the temperature

temperature below 65C you mean?

> and enables it when passing the threshold. It resuls the sensor thermal sensor

/s/resuls/results

> driver will have no activity most of the time.

By chance you miss the interrupt you will never have cooling on again?

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 39f4627..74ea70d 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -218,6 +218,15 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
>  	return 0;
>  }
>  
> +static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
> +				       bool on)
> +{
> +	struct thermal_zone_device *tzd = sensor->tzd;
> +
> +	tzd->ops->set_mode(tzd,
> +		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
> +}
> +
>  static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
>  	.get_temp = hisi_thermal_get_temp,
>  };
> @@ -236,12 +245,16 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>  		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
>  			 temp, sensor->thres_temp);
>  
> +		hisi_thermal_toggle_sensor(&data->sensor, true);
> +
>  		thermal_zone_device_update(data->sensor.tzd,
>  					   THERMAL_EVENT_UNSPECIFIED);
>  
>  	} else if (temp < sensor->thres_temp) {
>  		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
>  			 temp, sensor->thres_temp);
> +
> +		hisi_thermal_toggle_sensor(&data->sensor, false);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -286,15 +299,6 @@ static const struct of_device_id of_hisi_thermal_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
>  
> -static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
> -				       bool on)
> -{
> -	struct thermal_zone_device *tzd = sensor->tzd;
> -
> -	tzd->ops->set_mode(tzd,
> -		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
> -}
> -
>  static int hisi_thermal_setup(struct hisi_thermal_data *data)
>  {
>  	struct hisi_thermal_sensor *sensor;
> @@ -393,7 +397,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	hisi_thermal_toggle_sensor(&data->sensor, true);
> +	hisi_thermal_toggle_sensor(&data->sensor, false);
>  
>  	return 0;
>  }
> 
