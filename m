From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 05/13] thermal: qoriq: Embed per-sensor data into
 struct qoriq_tmu_data
Date: Thu, 4 Apr 2019 09:57:21 +0200
Message-ID: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-6-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-6-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Embed per-sensor data into struct qoriq_tmu_data so we can drop the
> code allocating it. This also allows us to get rid of per-sensor back
> reference to struct qoriq_tmu_data since now its address can be
> caluclated using container_of().

This seems to be a repeating pattern, drivers are forced to put a back
pointer in the thermal sensor structure to regain access to the
container structure in the get_temp callback.

It would make sense to pass the sensor id to the get_temp callback as we
register with the sensor id.

One comment below.

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
>  drivers/thermal/qoriq_thermal.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index e281bdcfa11f..deb5cb6a0baf 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -59,22 +59,24 @@ struct qoriq_tmu_regs {
>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>  };
>  
> -struct qoriq_tmu_data;
> -
>  /*
>   * Thermal zone data
>   */
>  struct qoriq_sensor {
> -	struct qoriq_tmu_data		*qdata;
>  	int				id;
>  };>
>  struct qoriq_tmu_data {
>  	struct qoriq_tmu_regs __iomem *regs;
>  	bool little_endian;

Why not replace the little_endian boolean by a couple of callback
read/write and assign them to ioread32|ioread32be at init time.

That will kill the tmu_read and tmu_write functions and from there you
can figure out how to remove the qdata backpointer. In addition, it will
save a few instructions to test the boolean.

> -	struct qoriq_sensor	*sensor[SITES_MAX];
> +	struct qoriq_sensor	sensor[SITES_MAX];
>
>  };
>  
> +static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
> +{
> +	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
> +}
> +
>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
>  {
>  	if (p->little_endian)
> @@ -94,7 +96,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
>  static int tmu_get_temp(void *p, int *temp)
>  {
>  	struct qoriq_sensor *qsensor = p;
> -	struct qoriq_tmu_data *qdata = qsensor->qdata;
> +	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
>  	u32 val;
>  
>  	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
> @@ -114,15 +116,9 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
> -		struct qoriq_sensor *s;
> -
> -		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> -				sizeof(struct qoriq_sensor), GFP_KERNEL);
> -		if (!qdata->sensor[id])
> -			return -ENOMEM;
> +		struct qoriq_sensor *s = &qdata->sensor[id];
>  
>  		s->id = id;
> -		s->qdata = qdata;
>  
>  		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
>  							   s, &tmu_tz_ops);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
