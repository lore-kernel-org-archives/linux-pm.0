From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/8 v3] thermal: rcar: enable to use thermal-zone on DT
Date: Tue, 8 Dec 2015 09:20:10 -0600
Message-ID: <20151208152010.GA25452@rob-hp-laptop>
References: <87y4d6672t.wl%kuninori.morimoto.gx@renesas.com>
 <87r3iy66za.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r3iy66za.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 07, 2015 at 07:44:09AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch enables to use thermal-zone on DT if it was call as
> "renesas,rcar-thermal-gen2".
> Previous style is still supported by "renesas,rcar-thermal".
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - compatible "renesas,rcar-thermal-gen2" -> "renesas,rcar-gen2-thermal"
> 
>  .../devicetree/bindings/thermal/rcar-thermal.txt   | 37 +++++++++++++++++-

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/thermal/rcar_thermal.c                     | 44 +++++++++++++++++++---
>  2 files changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> index 332e625..601a54d 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -1,8 +1,9 @@
>  * Renesas R-Car Thermal
>  
>  Required properties:
> -- compatible		: "renesas,thermal-<soctype>", "renesas,rcar-thermal"
> -			  as fallback.
> +- compatible		: "renesas,thermal-<soctype>",
> +			   "renesas,rcar-gen2-thermal" (with thermal-zone) or
> +			   "renesas,rcar-thermal" (without thermal-zone) as fallback.
>  			  Examples with soctypes are:
>  			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
>  			    - "renesas,thermal-r8a7779" (R-Car H1)
> @@ -36,3 +37,35 @@ thermal@e61f0000 {
>  		0xe61f0300 0x38>;
>  	interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
>  };
> +
> +Example (with thermal-zone):
> +
> +thermal-zones {
> +	cpu_thermal: cpu-thermal {
> +		polling-delay-passive	= <1000>;
> +		polling-delay		= <5000>;
> +
> +		thermal-sensors = <&thermal>;
> +
> +		trips {
> +			cpu-crit {
> +				temperature	= <1150000>;
> +				hysteresis	= <0>;
> +				type		= "critical";
> +			};
> +		};
> +		cooling-maps {
> +		};
> +	};
> +};
> +
> +thermal: thermal@e61f0000 {
> +	compatible =	"renesas,thermal-r8a7790",
> +			"renesas,rcar-gen2-thermal",
> +			"renesas,rcar-thermal";
> +	reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
> +	interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
> +	power-domains = <&cpg_clocks>;
> +	#thermal-sensor-cells = <0>;
> +};
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 52493b4..a8c88f4 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -23,6 +23,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reboot.h>
> @@ -81,8 +82,10 @@ struct rcar_thermal_priv {
>  # define rcar_force_update_temp(priv)	0
>  #endif
>  
> +#define USE_OF_THERMAL	1
>  static const struct of_device_id rcar_thermal_dt_ids[] = {
>  	{ .compatible = "renesas,rcar-thermal", },
> +	{ .compatible = "renesas,rcar-gen2-thermal", .data = (void *)USE_OF_THERMAL },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rcar_thermal_dt_ids);
> @@ -206,9 +209,8 @@ err_out_unlock:
>  	return ret;
>  }
>  
> -static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
> +static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv, int *temp)
>  {
> -	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
>  	int tmp;
>  
>  	if (!rcar_has_irq_support(priv) || rcar_force_update_temp(priv)) {
> @@ -233,6 +235,20 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
>  	return 0;
>  }
>  
> +static int rcar_thermal_of_get_temp(void *data, int *temp)
> +{
> +	struct rcar_thermal_priv *priv = data;
> +
> +	return rcar_thermal_get_current_temp(priv, temp);
> +}
> +
> +static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
> +{
> +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +	return rcar_thermal_get_current_temp(priv, temp);
> +}
> +
>  static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
>  				      int trip, enum thermal_trip_type *type)
>  {
> @@ -289,6 +305,10 @@ static int rcar_thermal_notify(struct thermal_zone_device *zone,
>  	return 0;
>  }
>  
> +static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops = {
> +	.get_temp	= rcar_thermal_of_get_temp,
> +};
> +
>  static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
>  	.get_temp	= rcar_thermal_get_temp,
>  	.get_trip_type	= rcar_thermal_get_trip_type,
> @@ -325,14 +345,20 @@ static void rcar_thermal_work(struct work_struct *work)
>  
>  	priv = container_of(work, struct rcar_thermal_priv, work.work);
>  
> -	rcar_thermal_get_temp(priv->zone, &cctemp);
> +	ret = rcar_thermal_get_current_temp(priv, &cctemp);
> +	if (ret < 0)
> +		return;
> +
>  	ret = rcar_thermal_update_temp(priv);
>  	if (ret < 0)
>  		return;
>  
>  	rcar_thermal_irq_enable(priv);
>  
> -	rcar_thermal_get_temp(priv->zone, &nctemp);
> +	ret = rcar_thermal_get_current_temp(priv, &nctemp);
> +	if (ret < 0)
> +		return;
> +
>  	if (nctemp != cctemp)
>  		thermal_zone_device_update(priv->zone);
>  }
> @@ -410,6 +436,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	struct rcar_thermal_priv *priv;
>  	struct device *dev = &pdev->dev;
>  	struct resource *res, *irq;
> +	const struct of_device_id *of_id = of_match_device(rcar_thermal_dt_ids, dev);
> +	unsigned long of_data = (unsigned long)of_id->data;
>  	int mres = 0;
>  	int i;
>  	int ret = -ENODEV;
> @@ -470,7 +498,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto error_unregister;
>  
> -		priv->zone = thermal_zone_device_register("rcar_thermal",
> +		if (of_data == USE_OF_THERMAL)
> +			priv->zone = thermal_zone_of_sensor_register(
> +						dev, i, priv,
> +						&rcar_thermal_zone_of_ops);
> +		else
> +			priv->zone = thermal_zone_device_register(
> +						"rcar_thermal",
>  						1, 0, priv,
>  						&rcar_thermal_zone_ops, NULL, 0,
>  						idle);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
