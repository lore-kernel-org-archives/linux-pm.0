From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 06/13] thermal/drivers/hisi: Remove pointless lock
Date: Thu, 7 Sep 2017 20:16:43 -0700
Message-ID: <20170908031641.GD2755@localhost.localdomain>
References: <1504554972-2624-1-git-send-email-daniel.lezcano@linaro.org>
 <1504554972-2624-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504554972-2624-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 04, 2017 at 09:56:05PM +0200, Daniel Lezcano wrote:
> The threaded interrupt inspect the sensors structure to look in the temp
> threshold field, but this field is read-only in all the code, except in the
> probe function before the threaded interrupt is set. In other words there
> is not race window in the threaded interrupt when reading the field value.


Sure? Not even if you have a userspace process read the zone temp via
sysfs and the polling workqueue reading the temp too?

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index f523197..9ec5f29 100644
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
