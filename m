From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 03/13] thermal/drivers/hisi: Fix kernel panic on alarm
 interrupt
Date: Fri, 1 Sep 2017 22:14:17 +0800
Message-ID: <20170901141417.GA11198@leoy-linaro>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
 <1504082857-21702-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504082857-21702-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 30, 2017 at 10:47:27AM +0200, Daniel Lezcano wrote:
> The threaded interrupt for the alarm interrupt is requested before the
> temperature controller is setup. This one can fire an interrupt immediately
> leading to a kernel panic as the sensor data is not initialized.
> 
> In order to prevent that, move the threaded irq after the Tsensor is setup.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/thermal/hisi_thermal.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 92b6889..67db523 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -287,15 +287,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  	if (data->irq < 0)
>  		return data->irq;
>  
> -	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
> -					hisi_thermal_alarm_irq,
> -					hisi_thermal_alarm_irq_thread,
> -					0, "hisi_thermal", data);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
> -		return ret;
> -	}
> -
>  	platform_set_drvdata(pdev, data);
>  
>  	data->clk = devm_clk_get(&pdev->dev, "thermal_clk");
> @@ -328,6 +319,15 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  
>  	hisi_thermal_toggle_sensor(&data->sensors, true);
>  
> +	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
> +					hisi_thermal_alarm_irq,
> +					hisi_thermal_alarm_irq_thread,
> +					0, "hisi_thermal", data);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
> +		return ret;
> +	}
> +

Just reminding for the initialization sequence, could we also move
hisi_thermal_enable_bind_irq_sensor(data) after function
hisi_thermal_register_sensor()? The reason is after we registser
sensor with specified sensor ID, then we can bind irq for the
specified ID, otherwise it will wrongly to bind irq to sensor 0. So
finally we can get result as below:

        ret = hisi_thermal_register_sensor(pdev, data,
                                           &data->sensors,
                                           HISI_DEFAULT_SENSOR);
        if (ret) {
                dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
                        ret);
                return ret;
        }

        hisi_thermal_enable_bind_irq_sensor(data);
        hisi_thermal_toggle_sensor(&data->sensors, true);
        data->irq_enabled = true;

        ret = devm_request_threaded_irq(&pdev->dev, data->irq,
                                        hisi_thermal_alarm_irq,
                                        hisi_thermal_alarm_irq_thread,
                                        0, "hisi_thermal", data);
        if (ret < 0) {
                dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
                return ret;
        }

>  	enable_irq(data->irq);
>  
>  	return 0;
> -- 
> 2.7.4
> 
