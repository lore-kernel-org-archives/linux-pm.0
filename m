From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 04/12] thermal: qoriq: Drop per-sensor data
Date: Tue, 16 Apr 2019 19:23:39 +0200
Message-ID: <230a8f04-0d1a-8b3e-2ddc-c1bb0d06bfb1@linaro.org>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-5-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413082748.29990-5-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Now that driver is converted to use get_temp_id() instead of
> get_temp() we no longer need per sensor data. Drop all of the code
> related to it.

Rui, Eduardo,

I just want to point out this patch is depending on:

"[PATCH] thermal/drivers/of: Add a get_temp_id callback function"


> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/thermal/qoriq_thermal.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index c041d1ae3500..3500e238fe3e 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -59,20 +59,9 @@ struct qoriq_tmu_regs {
>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>  };
>  
> -struct qoriq_tmu_data;
> -
> -/*
> - * Thermal zone data
> - */
> -struct qoriq_sensor {
> -	struct qoriq_tmu_data		*qdata;
> -	int				id;
> -};
> -
>  struct qoriq_tmu_data {
>  	struct qoriq_tmu_regs __iomem *regs;
>  	bool little_endian;
> -	struct qoriq_sensor	*sensor[SITES_MAX];
>  };
>  
>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
> @@ -93,8 +82,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
>  
>  static int tmu_get_temp(int id, void *p, int *temp)
>  {
> -	struct qoriq_sensor *qsensor = p;
> -	struct qoriq_tmu_data *qdata = qsensor->qdata;
> +	struct qoriq_tmu_data *qdata = p;
>  	u32 val;
>  
>  	val = tmu_read(qdata, &qdata->regs->site[id].tritsr);
> @@ -115,17 +103,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
>  
> -		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> -				sizeof(struct qoriq_sensor), GFP_KERNEL);
> -		if (!qdata->sensor[id])
> -			return -ENOMEM;
> -
> -		qdata->sensor[id]->id = id;
> -		qdata->sensor[id]->qdata = qdata;
> -
>  		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> -							   qdata->sensor[id],
> -							   &tmu_tz_ops);
> +							   qdata, &tmu_tz_ops);
>  		if (IS_ERR(tzd)) {
>  			if (PTR_ERR(tzd) == -ENODEV)
>  				continue;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
