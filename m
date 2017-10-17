From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 02/25] thermal/drivers/hisi: Remove the multiple sensors
 support
Date: Mon, 16 Oct 2017 20:54:10 -0700
Message-ID: <20171017035409.GA23821@localhost.localdomain>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
 <1507658570-32675-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507658570-32675-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 10, 2017 at 08:02:27PM +0200, Daniel Lezcano wrote:
> By essence, the tsensor does not really support multiple sensor at the same
> time. It allows to set a sensor and use it to get the temperature, another
> sensor could be switched but with a delay of 3-5ms. It is difficult to read
> simultaneously several sensors without a big delay.
> 

Is 3-5 ms enough to loose an event? Is this really a problem?

> Today, just one sensor is used, it is not necessary to deal with multiple

How come? Today the driver exposes all sensors to userspace. Removing
them, means you are changing the amount of sensors userspace really
sees.

Are you sure about this?

Can you please elaborate how we are only using one of the four sensors?

> sensors in the code. Remove them and if it is needed in the future add them
> on top of a code which will be clean up in the meantime.

It is just not clear to me why having 1 sensor support is better than
having 4, as per the hw supported tsensor.

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I would prefer to get confirmation from folks from hisilicon here.

BTW, you should be copying previous author of the code.

> ---
>  drivers/thermal/hisi_thermal.c | 75 +++++++++++-------------------------------
>  1 file changed, 19 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index f3b50b0..687efd4 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -39,6 +39,7 @@
>  #define HISI_TEMP_RESET			(100000)
>  
>  #define HISI_MAX_SENSORS		4
> +#define HISI_DEFAULT_SENSOR		2
>  
>  struct hisi_thermal_sensor {
>  	struct hisi_thermal_data *thermal;
> @@ -53,9 +54,8 @@ struct hisi_thermal_data {
>  	struct mutex thermal_lock;    /* protects register data */
>  	struct platform_device *pdev;
>  	struct clk *clk;
> -	struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
> -
> -	int irq, irq_bind_sensor;
> +	struct hisi_thermal_sensor sensors;
> +	int irq;
>  	bool irq_enabled;
>  
>  	void __iomem *regs;
> @@ -113,7 +113,7 @@ static void hisi_thermal_enable_bind_irq_sensor
>  
>  	mutex_lock(&data->thermal_lock);
>  
> -	sensor = &data->sensors[data->irq_bind_sensor];
> +	sensor = &data->sensors;
>  
>  	/* setting the hdak time */
>  	writel(0x0, data->regs + TEMP0_CFG);
> @@ -160,31 +160,8 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
>  	struct hisi_thermal_sensor *sensor = _sensor;
>  	struct hisi_thermal_data *data = sensor->thermal;
>  
> -	int sensor_id = -1, i;
> -	long max_temp = 0;
> -
>  	*temp = hisi_thermal_get_sensor_temp(data, sensor);
>  
> -	sensor->sensor_temp = *temp;
> -
> -	for (i = 0; i < HISI_MAX_SENSORS; i++) {
> -		if (!data->sensors[i].tzd)
> -			continue;
> -
> -		if (data->sensors[i].sensor_temp >= max_temp) {
> -			max_temp = data->sensors[i].sensor_temp;
> -			sensor_id = i;
> -		}
> -	}
> -
> -	/* If no sensor has been enabled, then skip to enable irq */
> -	if (sensor_id == -1)
> -		return 0;
> -
> -	mutex_lock(&data->thermal_lock);
> -	data->irq_bind_sensor = sensor_id;
> -	mutex_unlock(&data->thermal_lock);
> -
>  	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%d, thres=%d\n",
>  		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
>  	/*
> @@ -197,7 +174,7 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
>  		return 0;
>  	}
>  
> -	if (max_temp < sensor->thres_temp) {
> +	if (*temp < sensor->thres_temp) {
>  		data->irq_enabled = true;
>  		hisi_thermal_enable_bind_irq_sensor(data);
>  		enable_irq(data->irq);
> @@ -224,22 +201,16 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
>  {
>  	struct hisi_thermal_data *data = dev;
>  	struct hisi_thermal_sensor *sensor;
> -	int i;
>  
>  	mutex_lock(&data->thermal_lock);
> -	sensor = &data->sensors[data->irq_bind_sensor];
> +	sensor = &data->sensors;
>  
>  	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
>  		 sensor->thres_temp / 1000);
>  	mutex_unlock(&data->thermal_lock);
>  
> -	for (i = 0; i < HISI_MAX_SENSORS; i++) {
> -		if (!data->sensors[i].tzd)
> -			continue;
> -
> -		thermal_zone_device_update(data->sensors[i].tzd,
> -					   THERMAL_EVENT_UNSPECIFIED);
> -	}
> +	thermal_zone_device_update(data->sensors.tzd,
> +				   THERMAL_EVENT_UNSPECIFIED);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -296,7 +267,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  {
>  	struct hisi_thermal_data *data;
>  	struct resource *res;
> -	int i;
>  	int ret;
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> @@ -347,16 +317,17 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  	hisi_thermal_enable_bind_irq_sensor(data);
>  	data->irq_enabled = true;
>  
> -	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
> -		ret = hisi_thermal_register_sensor(pdev, data,
> -						   &data->sensors[i], i);
> -		if (ret)
> -			dev_err(&pdev->dev,
> -				"failed to register thermal sensor: %d\n", ret);
> -		else
> -			hisi_thermal_toggle_sensor(&data->sensors[i], true);
> +	ret = hisi_thermal_register_sensor(pdev, data,
> +					   &data->sensors,
> +					   HISI_DEFAULT_SENSOR);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
> +			ret);
> +		return ret;
>  	}
>  
> +	hisi_thermal_toggle_sensor(&data->sensors, true);
> +
>  	enable_irq(data->irq);
>  
>  	return 0;
> @@ -365,17 +336,9 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  static int hisi_thermal_remove(struct platform_device *pdev)
>  {
>  	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
> -	int i;
> -
> -	for (i = 0; i < HISI_MAX_SENSORS; i++) {
> -		struct hisi_thermal_sensor *sensor = &data->sensors[i];
> -
> -		if (!sensor->tzd)
> -			continue;
> -
> -		hisi_thermal_toggle_sensor(sensor, false);
> -	}
> +	struct hisi_thermal_sensor *sensor = &data->sensors;
>  
> +	hisi_thermal_toggle_sensor(sensor, false);
>  	hisi_thermal_disable_sensor(data);
>  	clk_disable_unprepare(data->clk);
>  
> -- 
> 2.7.4
> 
