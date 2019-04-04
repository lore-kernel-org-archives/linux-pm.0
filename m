From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 04/13] thermal: qoriq: Add local struct qoriq_sensor
 pointer
Date: Thu, 4 Apr 2019 05:28:49 +0200
Message-ID: <02822a7c-ae86-8c00-093e-665b603b1430@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-5-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-5-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Add local struct qoriq_sensor pointer in qoriq_tmu_register_tmu_zone()
> for brevity.
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
> ---
>  drivers/thermal/qoriq_thermal.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 6d40b9788266..e281bdcfa11f 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -114,18 +114,18 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
> +		struct qoriq_sensor *s;
>  
> -		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> +		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>  				sizeof(struct qoriq_sensor), GFP_KERNEL);

I would not recommend this, especially if you use a variable helper for
clarity. Keep using the 's' variable and then assign qdata->sensor[id] =
s at the end when everything is ok. May be rename it 'sensor'?

>  		if (!qdata->sensor[id])
>  			return -ENOMEM;
>  
> -		qdata->sensor[id]->id = id;
> -		qdata->sensor[id]->qdata = qdata;
> +		s->id = id;
> +		s->qdata = qdata;
>  
>  		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> -							   qdata->sensor[id],
> -							   &tmu_tz_ops);
> +							   s, &tmu_tz_ops);
>  		if (IS_ERR(tzd)) {
>  			if (PTR_ERR(tzd) == -ENODEV)
>  				continue;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
