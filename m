From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 06/13] thermal: qoriq: Pass data to
 qoriq_tmu_register_tmu_zone() directly
Date: Thu, 4 Apr 2019 10:09:15 +0200
Message-ID: <3015d0db-5e22-3c56-b6bc-78f836ff51dd@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-7-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-7-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
> instead of passing a paltform device and then deriving it. This is
> done as a first step to simplify resource deallocation code.
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
>  drivers/thermal/qoriq_thermal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index deb5cb6a0baf..24a2a57f61c9 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -109,9 +109,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>  	.get_temp = tmu_get_temp,
>  };
>  
> -static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
> +static int qoriq_tmu_register_tmu_zone(struct device *dev,
> +				       struct qoriq_tmu_data *qdata)
>  {
> -	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
>  	int id, sites = 0;
>  
>  	for (id = 0; id < SITES_MAX; id++) {
> @@ -120,7 +120,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>  
>  		s->id = id;
>  
> -		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
> +		tzd = devm_thermal_zone_of_sensor_register(dev, id,
>  							   s, &tmu_tz_ops);
>  		if (IS_ERR(tzd)) {
>  			if (PTR_ERR(tzd) == -ENODEV)
> @@ -215,7 +215,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_tmu;
>  
> -	ret = qoriq_tmu_register_tmu_zone(pdev);
> +	ret = qoriq_tmu_register_tmu_zone(dev, data);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to register sensors\n");
>  		ret = -ENODEV;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
