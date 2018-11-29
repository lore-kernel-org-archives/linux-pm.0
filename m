From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal/drivers/hisi: Fix bad initialization
Date: Thu, 29 Nov 2018 11:36:59 -0800
Message-ID: <20181129193658.GA6844@localhost.localdomain>
References: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, vincent.guittot@linaro.org, john.stultz@linaro.org, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 29, 2018 at 07:26:56PM +0100, Daniel Lezcano wrote:
> Without this patch, the thermal driver on hi6220 and hi3660 is broken.
> 
> That is due because part of the posted patchset was merged but a small
> change in the DT was dropped.
> 
> The hi6220 and hi3660 do not have an interrupt name in the DT, so
> finding interrupt by name fails.
> 
> In addition, the hi3660 only defines one thermal zone in the DT and we
> are trying to register two sensors assuming we have two thermal zones
> in the DT.
> 
> Fix this by adding a couple of line of code to add back compatibility
> with older DT and change the sensors number to 1 for the hi3660.

Is this a case of adding dt versioning for those nodes?

> 
> Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index c4111a9..3ab0e63 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
>  	struct platform_device *pdev = data->pdev;
>  	struct device *dev = &pdev->dev;
>  
> -	data->nr_sensors = 2;
> +	data->nr_sensors = 1;

For bisectability (heh.. is that even a word?), would you please send
one fix per patch?

>  
>  	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
>  				    data->nr_sensors, GFP_KERNEL);
> @@ -590,8 +590,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  		}
>  
>  		ret = platform_get_irq_byname(pdev, sensor->irq_name);
> -		if (ret < 0)
> -			return ret;
> +		if (ret <= 0) {

Maybe a simple <  is enough? reading it seams awkward. From a glance, I
dont think platform_get_irq* ever returns 0.

> +			ret = platform_get_irq(pdev, 0);
> +			if (ret <=  0) {

Same here.

> +				dev_err(dev, "Failed get interrupt: %d\n", ret);
> +				return ret;
> +			}
> +		}
>  
>  		ret = devm_request_threaded_irq(dev, ret, NULL,
>  						hisi_thermal_alarm_irq_thread,
> -- 
> 2.7.4
> 
