From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH V2] thermal/drivers/hisi: Switch to interrupt mode
Date: Fri, 29 Sep 2017 12:07:01 +0100
Message-ID: <4ce2e445-d846-e032-5677-36dcbce7bed4@arm.com>
References: <1bfd974e-3dc1-e99b-d0dd-50102cee762d@ti.com>
 <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdI2LHE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Sep 2017 07:07:04 -0400
In-Reply-To: <1506575625-20388-1-git-send-email-daniel.lezcano@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, ionela.voinescu@arm.com, Leo Yan <leo.yan@linaro.org>

Hi,


On 09/28/2017 06:13 AM, Daniel Lezcano wrote:
> At this moment, we have both the interrupt setup and the polling enabled. The
> interrupt does nothing more than forcing an update while the temperature is
> polled every second.
>
> We can do much better than that, threshold is set to 65C in the DT and the
> passive cooling device enters in the dance when 75C is reached. We need to
> sample the temperature at 65C in order to let the IPA gather enough values for
> the PID computation.
Sample collection is a valid point, but passive cooling should become 
active as soon
as 65C is reached (at least that's the case with IPA). Furthermore, 
IPA's PID controller
is reset when the temperature drops below the first trip-point 
(threshold) - as such,
I believe the PID's behavior should be the same now as it with polling.

I think the main selling point of interrupt-based updates is a faster 
reaction time.
On the HiKey960, we can go from below the threshold temperature to over 
the control temperature
in less than a second (default polling rate is 1s). In this situation, 
IPA's PID starts accumulating error
while already overshooting, which isn't optimal. On top of that, the 
passive cooling reacts
too slowly.
>   If the SoC is running at a temperature below 65C, we will
> be constantly polling for nothing.
>
> This patch disables the sensor when the temperature is below 65C and enables it
> when passing the threshold. It results the thermal sensor driver will have no
> activity most of the time.
>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Leo Yang <leo.yan@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
I've tested this on HiKey960 (Android 4.9 + upstream patches to apply 
your thermal/drivers/hisi series + Kevin's hi3600 support).
I ran a video workload, and noticed I get several interrupts while 
passive cooling is already in effect
(I might move part of this discussion to Kevin's posting, but I think 
it's still relevant to be here):

[  118.107357] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
[  119.182531] hisi_thermal fff30000.tsensor: THERMAL ALARM: 76235 > 65000
[  119.361964] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70495 > 65000
[  119.907865] hisi_thermal fff30000.tsensor: THERMAL ALARM: 75620 > 65000
[  119.959076] hisi_thermal fff30000.tsensor: THERMAL ALARM: 70700 > 65000

This isn't optimal for IPA, as the PID is supposed to use a specific 
sampling rate, but those interrupts
forced a re-trigger of power_allocator_throttle which changes the PID's 
actual sampling rate.
IPA isn't expecting this kind of scenarios, as I can see a 
tz->passive_delay in the computation
of the derivative term (although the derivative coefficient defaults to 
0...).

In a perfect world I would see those interrupts being toggled by the 
thermal governor, as that is
where we know what to do with each trip point - we could still want the 
interrupts, but in the case
of IPA we'd like to disable them while the PID controller is active, and 
we would know when to re-enable them
(as soon as IPA is toggled off).
> ---
>   drivers/thermal/hisi_thermal.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 39f4627..74ea70d 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -218,6 +218,15 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
>   	return 0;
>   }
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
>   static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
>   	.get_temp = hisi_thermal_get_temp,
>   };
> @@ -236,12 +245,16 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>   		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
>   			 temp, sensor->thres_temp);
>   
> +		hisi_thermal_toggle_sensor(&data->sensor, true);
> +
>   		thermal_zone_device_update(data->sensor.tzd,
>   					   THERMAL_EVENT_UNSPECIFIED);
>   
>   	} else if (temp < sensor->thres_temp) {
>   		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
>   			 temp, sensor->thres_temp);
> +
> +		hisi_thermal_toggle_sensor(&data->sensor, false);
>   	}
>   
>   	return IRQ_HANDLED;
> @@ -286,15 +299,6 @@ static const struct of_device_id of_hisi_thermal_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
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
>   static int hisi_thermal_setup(struct hisi_thermal_data *data)
>   {
>   	struct hisi_thermal_sensor *sensor;
> @@ -393,7 +397,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	hisi_thermal_toggle_sensor(&data->sensor, true);
> +	hisi_thermal_toggle_sensor(&data->sensor, false);
>   
>   	return 0;
>   }
