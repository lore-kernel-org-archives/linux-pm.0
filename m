From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC 1/1] thermal: rcar-thermal: add cpu cooling
Date: Thu, 20 Mar 2014 13:55:44 +0800
Message-ID: <1395294944.3571.9.camel@rzhang1-mobl4>
References: <1393599758-17315-1-git-send-email-ptitiano@baylibre.com>
	 <1393599758-17315-2-git-send-email-ptitiano@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1393599758-17315-2-git-send-email-ptitiano@baylibre.com>
Sender: linux-sh-owner@vger.kernel.org
To: Patrick Titiano <ptitiano@baylibre.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: magnus.damm@gmail.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2014-02-28 at 16:02 +0100, Patrick Titiano wrote:
> Renesas RCar platforms only register a thermal zone, but do not implement
> any thermal management.
> Use CPU cooling (CPUFreq DVFS driver) to implement thermal management.
> Register cpufreq cooling device, add passive trip point and bind it
> to thermal zone 0.
> Passive trip point temperature is set to 70C, but is adjustable
> via sysfs to facilitate experimentation and platform tuning.
> 
> Signed-off-by: Patrick Titiano <ptitiano@baylibre.com>

Kuninori,

what do you think of this patch?

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c | 103 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 96 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 187693c..0f953cf0 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -31,6 +31,8 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/thermal.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  
>  #define IDLE_INTERVAL	5000
>  
> @@ -62,11 +64,14 @@ struct rcar_thermal_priv {
>  	void __iomem *base;
>  	struct rcar_thermal_common *common;
>  	struct thermal_zone_device *zone;
> +	struct thermal_cooling_device *cpucooldev;
>  	struct delayed_work work;
>  	struct mutex lock;
>  	struct list_head list;
>  	int id;
>  	int ctemp;
> +	int trip_ctemp_passive;
> +	int trip_ctemp_critical;
>  };
>  
>  #define rcar_thermal_for_each_priv(pos, common)	\
> @@ -78,6 +83,9 @@ struct rcar_thermal_priv {
>  #define rcar_has_irq_support(priv)	((priv)->common->base)
>  #define rcar_id_to_shift(priv)		((priv)->id * 8)
>  
> +#define TRIP_CTEMP_PASSIVE		MCELSIUS(70)
> +#define TRIP_CTEMP_CRITICAL		MCELSIUS(90)
> +
>  #ifdef DEBUG
>  # define rcar_force_update_temp(priv)	1
>  #else
> @@ -224,9 +232,11 @@ static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
>  	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
>  	struct device *dev = rcar_priv_to_dev(priv);
>  
> -	/* see rcar_thermal_get_temp() */
>  	switch (trip) {
> -	case 0: /* +90 <= temp */
> +	case 0:
> +		*type = THERMAL_TRIP_PASSIVE;
> +		break;
> +	case 1:
>  		*type = THERMAL_TRIP_CRITICAL;
>  		break;
>  	default:
> @@ -243,15 +253,35 @@ static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
>  	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
>  	struct device *dev = rcar_priv_to_dev(priv);
>  
> -	/* see rcar_thermal_get_temp() */
> +	mutex_lock(&priv->lock);
>  	switch (trip) {
> -	case 0: /* +90 <= temp */
> -		*temp = MCELSIUS(90);
> +	case 0:
> +		*temp = priv->trip_ctemp_passive;
> +		break;
> +	case 1:
> +		*temp = priv->trip_ctemp_critical;
>  		break;
>  	default:
>  		dev_err(dev, "rcar driver trip error\n");
>  		return -EINVAL;
>  	}
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static int rcar_thermal_set_trip_temp(struct thermal_zone_device *zone,
> +				      int trip, unsigned long temp)
> +{
> +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +	/* Do not allow PASSIVE trip temperature > CRITICAL trip temperature */
> +	if (temp >= priv->trip_ctemp_critical)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +	priv->trip_ctemp_passive = temp;
> +	mutex_unlock(&priv->lock);
>  
>  	return 0;
>  }
> @@ -274,11 +304,52 @@ static int rcar_thermal_notify(struct thermal_zone_device *zone,
>  	return 0;
>  }
>  
> +static int rcar_thermal_bind(struct thermal_zone_device *zone,
> +			   struct thermal_cooling_device *cdev)
> +{
> +	int ret;
> +
> +	ret = thermal_zone_bind_cooling_device(zone, 0, cdev,
> +	/* bind with min and max states defined by cpu_cooling */
> +						THERMAL_NO_LIMIT,
> +						THERMAL_NO_LIMIT);
> +	ret += thermal_zone_bind_cooling_device(zone, 1, cdev,
> +	/* bind with min and max states defined by cpu_cooling */
> +						THERMAL_NO_LIMIT,
> +						THERMAL_NO_LIMIT);
> +
> +	return ret;
> +}
> +
> +/* Unbind callback functions for thermal zone */
> +static int rcar_thermal_unbind(struct thermal_zone_device *zone,
> +			     struct thermal_cooling_device *cdev)
> +{
> +	int ret;
> +
> +	ret = thermal_zone_unbind_cooling_device(zone, 0, cdev);
> +	ret += thermal_zone_unbind_cooling_device(zone, 1, cdev);
> +
> +	return ret;
> +}
> +
> +static int rcar_thermal_get_mode(struct thermal_zone_device *zone,
> +			 enum thermal_device_mode *mode)
> +{
> +	*mode = THERMAL_DEVICE_ENABLED;
> +
> +	return 0;
> +}
> +
>  static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
> +	.get_mode       = rcar_thermal_get_mode,
>  	.get_temp	= rcar_thermal_get_temp,
>  	.get_trip_type	= rcar_thermal_get_trip_type,
>  	.get_trip_temp	= rcar_thermal_get_trip_temp,
> +	.set_trip_temp	= rcar_thermal_set_trip_temp,
>  	.notify		= rcar_thermal_notify,
> +	.bind           = rcar_thermal_bind,
> +	.unbind         = rcar_thermal_unbind,
>  };
>  
>  /*
> @@ -375,6 +446,12 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	int i;
>  	int ret = -ENODEV;
>  	int idle = IDLE_INTERVAL;
> +	struct cpumask clip_cpus;
> +
> +	if (!cpufreq_get_current_driver()) {
> +		dev_dbg(dev, "no cpufreq driver yet, deferring probe\n");
> +		return -EPROBE_DEFER;
> +	}
>  
>  	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
>  	if (!common) {
> @@ -456,13 +533,24 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  
>  		priv->common = common;
>  		priv->id = i;
> +		priv->trip_ctemp_passive = TRIP_CTEMP_PASSIVE;
> +		priv->trip_ctemp_critical = TRIP_CTEMP_CRITICAL;
>  		mutex_init(&priv->lock);
>  		INIT_LIST_HEAD(&priv->list);
>  		INIT_DELAYED_WORK(&priv->work, rcar_thermal_work);
>  		rcar_thermal_update_temp(priv);
>  
> +		cpumask_set_cpu(0, &clip_cpus);
> +		priv->cpucooldev = cpufreq_cooling_register(&clip_cpus);
> +		if (IS_ERR(priv->cpucooldev)) {
> +			ret = PTR_ERR(priv->cpucooldev);
> +			dev_err(dev, "failed to register cpufreq cooling device (%d)\n",
> +				ret);
> +			goto error_unpm;
> +		}
> +
>  		priv->zone = thermal_zone_device_register("rcar_thermal",
> -						1, 0, priv,
> +						2, 1, priv,
>  						&rcar_thermal_zone_ops, NULL, 0,
>  						idle);
>  		if (IS_ERR(priv->zone)) {
> @@ -478,7 +566,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, common);
> -
>  	dev_info(dev, "%d sensor probed\n", i);
>  
>  	return 0;
> @@ -513,6 +600,8 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  			rcar_thermal_irq_disable(priv);
>  	}
>  
> +	cpufreq_cooling_unregister(priv->cpucooldev);
> +
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  


