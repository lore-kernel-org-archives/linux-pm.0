From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 09/12] thermal: qoriq: Enable all sensors before
 registering them
Date: Tue, 16 Apr 2019 19:09:30 +0200
Message-ID: <8233019b-988b-05d5-6b7c-55652da8b3cd@linaro.org>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-10-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413082748.29990-10-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Tmu_get_temp will get called as a part of sensor registration via
> devm_thermal_zone_of_sensor_register(). To prevent it from retruning
> bogus data we need to enable sensor monitoring before that. Looking at
> the datasheet (i.MX8MQ RM) there doesn't seem to be any harm in
> enabling them all, so, for the sake of simplicity, change the code to
> do just that.
> 
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
>  drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 9774323a17bf..abbbfe88422e 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -23,6 +23,7 @@
>  #define TMR_DISABLE	0x0
>  #define TMR_ME		0x80000000
>  #define TMR_ALPF	0x0c000000
> +#define TMR_MSITE_ALL	GENMASK(15, 0)
>  
>  #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
>  #define TMTMIR_DEFAULT	0x0000000f
> @@ -61,28 +62,28 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>  static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  				       struct qoriq_tmu_data *qdata)
>  {
> -	int id, sites = 0;
> +	int id, ret;
> +
> +	regmap_write(qdata->regmap, REGS_TMR,
> +		     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
>  
>  	for (id = 0; id < SITES_MAX; id++) {
>  		struct thermal_zone_device *tzd;
>  
>  		tzd = devm_thermal_zone_of_sensor_register(dev, id,
>  							   qdata, &tmu_tz_ops);
> -		if (IS_ERR(tzd)) {
> -			if (PTR_ERR(tzd) == -ENODEV)
> -				continue;
> -			else
> -				return PTR_ERR(tzd);
> +		ret = PTR_ERR_OR_ZERO(tzd);
> +		switch (ret) {
> +		case -ENODEV:
> +			continue;
> +		case 0:

Why not simply:

	if (!IS_ERR(tzd) || PTR_ERR(tzd) == -ENODEV)
		continue;

	regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);

	return PTR_ERR(tzd);

?

> +			break;
> +		default:
> +			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
> +			return ret;
>  		}
> -
> -		sites |= 0x1 << (15 - id);
>  	}
>  
> -	/* Enable monitoring */
> -	if (sites != 0)
> -		regmap_write(qdata->regmap, REGS_TMR,
> -			     sites | TMR_ME | TMR_ALPF);
> -
>  	return 0;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
