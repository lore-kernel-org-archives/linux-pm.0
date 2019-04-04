From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 03/13] thermal: qoriq: Don't store struct
 thermal_zone_device reference
Date: Thu, 4 Apr 2019 05:23:37 +0200
Message-ID: <af50ccd1-1fad-4400-2404-cc5de475b43f@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-4-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-4-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Struct thermal_zone_device reference stored as sensor's private data
> isn't really used anywhere in the code. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/qoriq_thermal.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 91f9f49d2776..6d40b9788266 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -65,7 +65,6 @@ struct qoriq_tmu_data;
>   * Thermal zone data
>   */
>  struct qoriq_sensor {
> -	struct thermal_zone_device	*tzd;
>  	struct qoriq_tmu_data		*qdata;
>  	int				id;
>  };
> @@ -114,6 +113,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  	int id, sites = 0;
>  
>  	for (id = 0; id < SITES_MAX; id++) {
> +		struct thermal_zone_device *tzd;
> +
>  		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>  				sizeof(struct qoriq_sensor), GFP_KERNEL);
>  		if (!qdata->sensor[id])
> @@ -121,13 +122,15 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  		qdata->sensor[id]->id = id;
>  		qdata->sensor[id]->qdata = qdata;
> -		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
> -				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
> -		if (IS_ERR(qdata->sensor[id]->tzd)) {
> -			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
> +
> +		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> +							   qdata->sensor[id],
> +							   &tmu_tz_ops);
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV)
>  				continue;
>  			else
> -				return PTR_ERR(qdata->sensor[id]->tzd);
> +				return PTR_ERR(tzd);
>  		}
>  
>  		sites |= 0x1 << (15 - id);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
