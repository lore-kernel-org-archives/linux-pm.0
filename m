From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
Date: Wed, 29 Mar 2017 08:54:05 +0200
Message-ID: <813dc1d8-89b4-9c0e-c1cc-e76efde2be1f@free-electrons.com>
References: <20170328173013.16539-1-icenowy@aosc.io>
 <20170328173013.16539-3-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328173013.16539-3-icenowy-h8G6r0blFSE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 28/03/2017 19:30, Icenowy Zheng wrote:
> This adds support for the Allwinner H3 thermal sensor.
> 
> Allwinner H3 has a thermal sensor like the one in A33, but have its
> registers nearly all re-arranged, sample clock moved to CCU and a pair
> of bus clock and reset added. It's also the base of newer SoCs' thermal
> sensors.
> 
> An option is added to gpadc_data struct, to indicate whether this device
> is a new-generation Allwinner thermal sensor.
> 
> The thermal sensors on A64 and H5 is like the one on H3, but with of
> course different formula factors.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 130 ++++++++++++++++++++++++++++++++------
>  include/linux/mfd/sun4i-gpadc.h   |  33 +++++++++-
>  2 files changed, 141 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 74705aa37982..7512b1cae877 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -22,6 +22,7 @@
>   * shutdown for not being used.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -31,6 +32,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/thermal.h>
>  #include <linux/delay.h>
>  
> @@ -56,6 +58,7 @@ struct gpadc_data {
>  	unsigned int	tp_adc_select;
>  	unsigned int	(*adc_chan_select)(unsigned int chan);
>  	unsigned int	adc_chan_mask;
> +	bool		gen2_ths;
>  };
>  

Instead of a boolean, give the TEMP_DATA register address.

>  static const struct gpadc_data sun4i_gpadc_data = {
> @@ -88,7 +91,20 @@ static const struct gpadc_data sun6i_gpadc_data = {
>  static const struct gpadc_data sun8i_a33_gpadc_data = {
>  	.temp_offset = -1662,
>  	.temp_scale = 162,
> -	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
> +	.tp_mode_en = SUN8I_A23_GPADC_CTRL1_CHOP_TEMP_EN,
> +};

Separate patch for this?

> +
> +static const struct gpadc_data sun8i_h3_gpadc_data = {
> +	/*
> +	 * The original formula on the datasheet seems to be wrong.
> +	 * These factors are calculated based on the formula in the BSP
> +	 * kernel, which is originally Tem = 217 - (T / 8.253), in which Tem
> +	 * is the temperature in Celsius degree and T is the raw value
> +	 * from the sensor.
> +	 */
> +	.temp_offset = -1791,
> +	.temp_scale = -121,
> +	.gen2_ths = true,
>  };
>  
>  struct sun4i_gpadc_iio {
> @@ -103,6 +119,9 @@ struct sun4i_gpadc_iio {
>  	atomic_t			ignore_temp_data_irq;
>  	const struct gpadc_data		*data;
>  	bool				no_irq;
> +	struct clk			*ths_bus_clk;
> +	struct clk			*ths_clk;
> +	struct reset_control		*reset;
>  	/* prevents concurrent reads of temperature and ADC */
>  	struct mutex			mutex;
>  };
> @@ -274,7 +293,11 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>  	if (info->no_irq) {
>  		pm_runtime_get_sync(indio_dev->dev.parent);
>  
> -		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
> +		if (info->data->gen2_ths)
> +			regmap_read(info->regmap, SUN8I_H3_GPADC_TEMP_DATA,
> +				    val);
> +		else
> +			regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
>  

Instead of gen2_ths, use the TEMP_DATA register address.

>  		pm_runtime_mark_last_busy(indio_dev->dev.parent);
>  		pm_runtime_put_autosuspend(indio_dev->dev.parent);
> @@ -386,10 +409,15 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>  
> -	/* Disable the ADC on IP */
> -	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
> -	/* Disable temperature sensor on IP */
> -	regmap_write(info->regmap, SUN4I_GPADC_TPR, 0);
> +	if (info->data->gen2_ths) {
> +		/* Disable temperature sensor */
> +		regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL2, 0);
> +	} else {
> +		/* Disable the ADC on IP */
> +		regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
> +		/* Disable temperature sensor on IP */
> +		regmap_write(info->regmap, SUN4I_GPADC_TPR, 0);
> +	}
>  

Either use another register address or add a suspend function to struct
gpadc_data which will be different for each version of the IP.

>  	return 0;
>  }
> @@ -398,19 +426,36 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
>  {
>  	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>  
> -	/* clkin = 6MHz */
> -	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
> -		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
> -		     SUN4I_GPADC_CTRL0_FS_DIV(7) |
> -		     SUN4I_GPADC_CTRL0_T_ACQ(63));
> -	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, info->data->tp_mode_en);
> -	regmap_write(info->regmap, SUN4I_GPADC_CTRL3,
> -		     SUN4I_GPADC_CTRL3_FILTER_EN |
> -		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
> -	/* period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~0.6s */
> -	regmap_write(info->regmap, SUN4I_GPADC_TPR,
> -		     SUN4I_GPADC_TPR_TEMP_ENABLE |
> -		     SUN4I_GPADC_TPR_TEMP_PERIOD(800));
> +	if (info->data->gen2_ths) {
> +		regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL2,
> +			     SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN |
> +			     SUN8I_H3_GPADC_CTRL2_T_ACQ1(31));
> +		regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
> +			     SUN4I_GPADC_CTRL0_T_ACQ(31));
> +		regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL3,
> +			     SUN4I_GPADC_CTRL3_FILTER_EN |
> +			     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
> +		regmap_write(info->regmap, SUN8I_H3_GPADC_INTC,
> +			     SUN8I_H3_GPADC_INTC_TEMP_PERIOD(800));
> +	} else {
> +		/* clkin = 6MHz */
> +		regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
> +			     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
> +			     SUN4I_GPADC_CTRL0_FS_DIV(7) |
> +			     SUN4I_GPADC_CTRL0_T_ACQ(63));
> +		regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
> +			     info->data->tp_mode_en);
> +		regmap_write(info->regmap, SUN4I_GPADC_CTRL3,
> +			     SUN4I_GPADC_CTRL3_FILTER_EN |
> +			     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
> +		/*
> +		 * period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin;
> +		 * ~0.6s
> +		 */
> +		regmap_write(info->regmap, SUN4I_GPADC_TPR,
> +			     SUN4I_GPADC_TPR_TEMP_ENABLE |
> +			     SUN4I_GPADC_TPR_TEMP_PERIOD(800));
> +	}
>  

Same here as suspend function?

>  	return 0;
>  }
> @@ -494,6 +539,10 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
>  		.compatible = "allwinner,sun8i-a33-ths",
>  		.data = &sun8i_a33_gpadc_data,
>  	},
> +	{
> +		.compatible = "allwinner,sun8i-h3-ths",
> +		.data = &sun8i_h3_gpadc_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  
> @@ -529,6 +578,43 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> +	if (info->data->gen2_ths) {
> +		info->reset = devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(info->reset)) {
> +			ret = PTR_ERR(info->reset);
> +			return ret;
> +		}
> +
> +		ret = reset_control_deassert(info->reset);
> +		if (ret)
> +			return ret;
> +
> +		info->ths_bus_clk = devm_clk_get(&pdev->dev, "bus");
> +		if (IS_ERR(info->ths_bus_clk)) {
> +			ret = PTR_ERR(info->ths_bus_clk);
> +			return ret;
> +		}
> +
> +		ret = clk_prepare_enable(info->ths_bus_clk);
> +		if (ret)
> +			return ret;
> +
> +		info->ths_clk = devm_clk_get(&pdev->dev, "ths");
> +		if (IS_ERR(info->ths_clk)) {
> +			ret = PTR_ERR(info->ths_clk);
> +			return ret;
> +		}
> +
> +		/* Running at 6MHz */
> +		ret = clk_set_rate(info->ths_clk, 6000000);
> +		if (ret)
> +			return ret;
> +
> +		ret = clk_prepare_enable(info->ths_clk);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (!IS_ENABLED(CONFIG_THERMAL_OF))
>  		return 0;
>  
> @@ -691,6 +777,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
>  	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
>  		iio_map_array_unregister(indio_dev);
>  
> +	if (info->data->gen2_ths) {
> +		clk_disable_unprepare(info->ths_clk);
> +		clk_disable_unprepare(info->ths_bus_clk);
> +		reset_control_deassert(info->reset);
> +	}
> +

I'm not really fond of using this boolean as I don't see it being
possibly reused for any other SoCs that has a GPADC or THS.

Here, you could make use of a list/array of clk which then can be reused
for other SoCs just by changing the list. Add a default rate to the
gpadc_data structure and you're go to go.

>  	return 0;
>  }
>  
> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> index 139872c2e0fe..f794a2988a93 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -38,9 +38,12 @@
>  #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
>  #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
>  
> -/* TP_CTRL1 bits for sun8i SoCs */
> -#define SUN8I_GPADC_CTRL1_CHOP_TEMP_EN			BIT(8)
> -#define SUN8I_GPADC_CTRL1_GPADC_CALI_EN			BIT(7)
> +/* TP_CTRL1 bits for sun8i A23/A33 SoCs */
> +#define SUN8I_A23_GPADC_CTRL1_CHOP_TEMP_EN		BIT(8)
> +#define SUN8I_A23_GPADC_CTRL1_GPADC_CALI_EN		BIT(7)
> +

Different patch for these?

Thanks,
Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
