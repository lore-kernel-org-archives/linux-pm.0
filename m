From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/2] thermal: imx: implement thermal alarm interrupt
 handling
Date: Mon, 05 Aug 2013 09:50:12 +0200
Message-ID: <1375689012.4000.32.camel@pizza.hi.pengutronix.de>
References: <1375374792-32326-1-git-send-email-p.zabel@pengutronix.de>
	 <1375374792-32326-3-git-send-email-p.zabel@pengutronix.de>
	 <20130805032254.GA24629@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60951 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903Ab3HEHvF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2013 03:51:05 -0400
In-Reply-To: <20130805032254.GA24629@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, kernel@pengutronix.de

Hi Shawn,

Am Montag, den 05.08.2013, 11:22 +0800 schrieb Shawn Guo:
> Philipp,
> 
> Thanks for adding interrupt support for the driver.
> 
> On Thu, Aug 01, 2013 at 06:33:12PM +0200, Philipp Zabel wrote:
> > Enable automatic measurements at 10 Hz and use the alarm interrupt to react
> > more quickly to sudden temperature changes above the passive or critical
> > temperature trip points.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/thermal/imx_thermal.c | 140 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 127 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > index 9387e47..411be0a 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/syscon.h>
> > @@ -31,6 +32,8 @@
> >  #define MISC0_REFTOP_SELBIASOFF		(1 << 3)
> >  
> >  #define TEMPSENSE0			0x0180
> > +#define TEMPSENSE0_ALARM_VALUE_SHIFT	20
> > +#define TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << TEMPSENSE0_ALARM_VALUE_SHIFT)
> >  #define TEMPSENSE0_TEMP_CNT_SHIFT	8
> >  #define TEMPSENSE0_TEMP_CNT_MASK	(0xfff << TEMPSENSE0_TEMP_CNT_SHIFT)
> >  #define TEMPSENSE0_FINISHED		(1 << 2)
> > @@ -66,33 +69,62 @@ struct imx_thermal_data {
> >  	int c1, c2; /* See formula in imx_get_sensor_data() */
> >  	unsigned long temp_passive;
> >  	unsigned long temp_critical;
> > +	unsigned long alarm_temp;
> > +	unsigned long last_temp;
> > +	bool irq_enabled;
> > +	int irq;
> >  };
> >  
> > +static void imx_set_alarm_temp(struct imx_thermal_data *data,
> > +			       signed long alarm_temp)
> > +{
> > +	struct regmap *map = data->tempmon;
> > +	int alarm_value;
> > +
> > +	data->alarm_temp = alarm_temp;
> > +	alarm_value = (alarm_temp - data->c2) / data->c1;
> > +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_ALARM_VALUE_MASK);
> > +	regmap_write(map, TEMPSENSE0 + REG_SET, alarm_value <<
> > +			TEMPSENSE0_ALARM_VALUE_SHIFT);
> > +}
> > +
> >  static int imx_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
> >  {
> >  	struct imx_thermal_data *data = tz->devdata;
> >  	struct regmap *map = data->tempmon;
> > -	static unsigned long last_temp;
> >  	unsigned int n_meas;
> > +	bool wait;
> >  	u32 val;
> >  
> > -	/*
> > -	 * Every time we measure the temperature, we will power on the
> > -	 * temperature sensor, enable measurements, take a reading,
> > -	 * disable measurements, power off the temperature sensor.
> > -	 */
> > -	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> > -	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
> > +	if (data->mode == THERMAL_DEVICE_ENABLED) {
> > +		/* Check if a measurement is currently in progress */
> > +		regmap_read(map, TEMPSENSE0, &val);
> > +		wait = !(val & TEMPSENSE0_FINISHED);
> > +	} else {
> > +		/*
> > +		 * Every time we measure the temperature, we will power on the
> > +		 * temperature sensor, enable measurements, take a reading,
> > +		 * disable measurements, power off the temperature sensor.
> > +		 */
> > +		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> > +		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
> 
> Could imx_get_temp() be possibly called when mode is
> !THERMAL_DEVICE_ENABLED?  If not, this will be a piece of code which
> will never be called but simply confusing people.

yes:
  echo disabled > /sys/class/thermal/thermal_zone0/mode
  cat /sys/class/thermal/thermal_zone0/temp

Maybe I should extend the comment?

> > +
> > +		wait = true;
> > +	}
> >  
> >  	/*
> >  	 * According to the temp sensor designers, it may require up to ~17us
> >  	 * to complete a measurement.
> >  	 */
> > -	usleep_range(20, 50);
> > +	if (wait)
> > +		usleep_range(20, 50);
> >  
> >  	regmap_read(map, TEMPSENSE0, &val);
> > -	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
> > -	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
> > +
> > +	if (data->mode != THERMAL_DEVICE_ENABLED) {
> > +		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
> > +		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
> > +	}
> >  
> >  	if ((val & TEMPSENSE0_FINISHED) == 0) {
> >  		dev_dbg(&tz->device, "temp measurement never finished\n");
> > @@ -104,9 +136,24 @@ static int imx_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
> >  	/* See imx_get_sensor_data() for formula derivation */
> >  	*temp = data->c2 + data->c1 * n_meas;
> >  
> > -	if (*temp != last_temp) {
> > +	/* Update alarm value to next higher trip point */
> > +	if (data->alarm_temp == data->temp_passive && *temp >= data->temp_passive)
> > +		imx_set_alarm_temp(data, data->temp_critical);
> > +	if (data->alarm_temp == data->temp_critical && *temp < data->temp_passive) {
> > +		imx_set_alarm_temp(data, data->temp_passive);
> > +		dev_dbg(&tz->device, "thermal alarm off: T < %lu\n",
> > +			data->alarm_temp / 1000);
> > +	}
> 
> Running the driver in polling mode with step_wise governor, we can have
> cooling device (cpufreq) enter different cooling level, when temperature
> increases or decreases.  For example, imx6q runs at 1GHz before reaching
> passive temperature 85C, and will slow down to 800 MHz when temperature
> reaches 85C.  It will continue slowing down 400 MHz if temperature
> continues increasing to, saying 87C.  And if temperature decreases, the
> frequency will go back to 800 MHz and then 1 GHz.
> 
> With interrupt mode, thermal zone update will only be triggered by alarm
> temperature.  That says cooling device will transit between different
> cooling levels only when passive or critical temperature is reached in
> raising thermal trend.  For above example, even when temperature
> decreases back to something original below 85C, CPU will still run at
> 400 MHz, I think.

I have not disabled the polling (with 0.5 Hz below and 1 Hz above the
passive trip point), that still works as before.
The interrupt only forces an additional measurement right after the
alarm interrupt. I think for the step_wise governor we should probably
also raise the polling frequency for a while after getting interrupted.

> > +
> > +	if (*temp != data->last_temp) {
> >  		dev_dbg(&tz->device, "millicelsius: %ld\n", *temp);
> > -		last_temp = *temp;
> > +		data->last_temp = *temp;
> > +	}
> > +
> > +	/* Reenable alarm IRQ if temperature below alarm temperature */
> > +	if (!data->irq_enabled && *temp < data->alarm_temp) {
> > +		data->irq_enabled = true;
> > +		enable_irq(data->irq);
> >  	}
> >  
> >  	return 0;
> > @@ -126,13 +173,30 @@ static int imx_set_mode(struct thermal_zone_device *tz,
> >  			enum thermal_device_mode mode)
> >  {
> >  	struct imx_thermal_data *data = tz->devdata;
> > +	struct regmap *map = data->tempmon;
> >  
> >  	if (mode == THERMAL_DEVICE_ENABLED) {
> >  		tz->polling_delay = IMX_POLLING_DELAY;
> >  		tz->passive_delay = IMX_PASSIVE_DELAY;
> > +
> > +		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> > +		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
> > +
> > +		if (!data->irq_enabled) {
> > +			data->irq_enabled = true;
> > +			enable_irq(data->irq);
> > +		}
> >  	} else {
> > +		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
> > +		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
> > +
> >  		tz->polling_delay = 0;
> >  		tz->passive_delay = 0;
> > +
> > +		if (data->irq_enabled) {
> > +			disable_irq(data->irq);
> > +			data->irq_enabled = false;
> > +		}
> >  	}
> >  
> >  	data->mode = mode;
> > @@ -181,6 +245,8 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
> >  
> >  	data->temp_passive = temp;
> >  
> > +	imx_set_alarm_temp(data, temp);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -299,11 +365,34 @@ static int imx_get_sensor_data(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static irqreturn_t imx_thermal_alarm_irq(int irq, void *dev)
> > +{
> > +	struct imx_thermal_data *data = dev;
> > +
> > +	disable_irq_nosync(irq);
> > +	data->irq_enabled = false;
> > +
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
> > +{
> > +	struct imx_thermal_data *data = dev;
> > +
> > +	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %lu\n",
> > +		data->alarm_temp / 1000);
> > +
> > +	thermal_zone_device_update(data->tz);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int imx_thermal_probe(struct platform_device *pdev)
> >  {
> >  	struct imx_thermal_data *data;
> >  	struct cpumask clip_cpus;
> >  	struct regmap *map;
> > +	int measure_freq;
> >  	int ret;
> >  
> >  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > @@ -318,6 +407,18 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  	}
> >  	data->tempmon = map;
> >  
> > +	data->irq = platform_get_irq(pdev, 0);
> > +	if (data->irq < 0)
> > +		return data->irq;
> > +
> > +	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
> > +			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
> > +			0, "imx_thermal", data);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> >  	platform_set_drvdata(pdev, data);
> >  
> >  	ret = imx_get_sensor_data(pdev);
> > @@ -356,6 +457,15 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > +	/* Enable measurements at ~ 10 Hz */
> > +	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
> > +	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
> > +	regmap_write(map, TEMPSENSE1 + REG_SET, measure_freq);
> > +	imx_set_alarm_temp(data, data->temp_passive);
> > +	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
> > +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
> 
> This is another thing that interrupt support changes comparing to
> polling mode.  In polling mode, tempmon circuit consumes power only when
> the measurement takes place, while now we have to keep the power on
> since initialization.

That is correct. Is there any information about how much this circuit is
actually consuming? Should this be made configurable?
Certainly polling in 100 ms intervals will consume more energy, and 2 s
intervals are short enough for all hardware configurations.

> Shawn
> 
> > +
> > +	data->irq_enabled = true;
> >  	data->mode = THERMAL_DEVICE_ENABLED;
> >  
> >  	return 0;
> > @@ -364,6 +474,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >  static int imx_thermal_remove(struct platform_device *pdev)
> >  {
> >  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > +	struct regmap *map = data->tempmon;
> > +
> > +	/* Disable measurements */
> > +	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
> >  
> >  	thermal_zone_device_unregister(data->tz);
> >  	cpufreq_cooling_unregister(data->cdev);
> > -- 
> > 1.8.4.rc0
> > 

regards
Philipp

