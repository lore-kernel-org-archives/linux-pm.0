From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: imx: Temperature could be not read out from
 on-SOC temp sensor.
Date: Tue, 08 Aug 2017 17:12:54 +0800
Message-ID: <1502183574.4296.24.camel@intel.com>
References: <20170721131201.30507-1-mosipov@ilbers.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52394 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbdHHJM7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 05:12:59 -0400
In-Reply-To: <20170721131201.30507-1-mosipov@ilbers.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Maxim Yu. Osipov" <mosipov@ilbers.de>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org

On Fri, 2017-07-21 at 15:12 +0200, Maxim Yu. Osipov wrote:
> In imx_thermal_probe() thermal alarm interrupt is
> enabled before device's 'mode' field is set to THERMAL_DEVICE_ENABLED
> while
> the sensor hardware is already powered up. If alarm condition is met
> -
> the interrupt immediately fires up. During (threaded) interrupt
> processing
> imx_get_temp() is called. The field 'mode' is still set to DISABLED,
> so imx_get_temp() processes such case by special way: sensor is
> powered up,
> measurement is enabled, a reading is taken, after that measurement is
> DISABLED and temperature sensor is POWERED DOWN.
> 
> When processing of alarm interrupt ends, imx_thermal_probe()
> continues
> and sets mode field to ENABLED, but in fact the device is powered
> off!
> 
> This leads to broken logic of further calls of imx_get_temp().
> 
> Note, that explicit enabling of mode via sysfs
> (echo enabled > /sys/sys/class/therma/thermal_zone0/mode)
> leads to powering up of the sensor hardware (see sensor_set_mode())
> The same applies to suspend/resume cycles - after resume the
> temperature
> sensor will start reading the temperature w/o errors.
> 
> I sent the patch to i.MX list <linux-arm-kernel@lists.infradead.org>
> and Philipp Zabel <p.zabel@pengutronix.de> additionally suggested:
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> Thank you for the patch and the analysis. I have some comments below.
> 
> I think the data->irq_enabled assignment should be moved up before
> the
> call to devm_request_threaded_irq as well. If the interrupt triggers
> immediately (and sets data->irq_enabled=false), and then
> imx_thermal_probe returns (after setting data->irq_enabled=true)
> before
> the threaded irq handler gets to run, imx_get_temp will not reenable
> the
> interrupt at the end, if the temperature has just fallen below the
> alarm
> temperature.
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> <<<<<<
> 
> Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>

Applied.

thanks,
rui
> ---
>  drivers/thermal/imx_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c
> b/drivers/thermal/imx_thermal.c
> index 4798b4b1fd77..0d35487f4c3e 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -600,6 +600,8 @@ static int imx_thermal_probe(struct
> platform_device *pdev)
>  
>  	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_POWER_DOWN);
>  	regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_MEASURE_TEMP);
> +	data->irq_enabled = true;
> +	data->mode = THERMAL_DEVICE_ENABLED;
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
>  			imx_thermal_alarm_irq,
> imx_thermal_alarm_irq_thread,
> @@ -613,8 +615,6 @@ static int imx_thermal_probe(struct
> platform_device *pdev)
>  		return ret;
>  	}
>  
> -	data->irq_enabled = true;
> -	data->mode = THERMAL_DEVICE_ENABLED;
>  
>  	return 0;
>  }
