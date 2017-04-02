From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH v2 3/4] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
Date: Sun, 2 Apr 2017 16:29:55 +0200
Message-ID: <09000fca-7eec-0f9f-0bee-923f3b41cbd8@free-electrons.com>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-4-icenowy@aosc.io>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBZMVQTDQKGQEMHUL47I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170402133304.56824-4-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: icenowy-h8G6r0blFSE@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Icenowy,

On 02/04/2017 15:33, Icenowy Zheng wrote:
> This adds support for the Allwinner H3 thermal sensor.
> 
> Allwinner H3 has a thermal sensor like the one in A33, but have its
> registers nearly all re-arranged, sample clock moved to CCU and a pair
> of bus clock and reset added. It's also the base of newer SoCs' thermal
> sensors.
> 
> Some new options is added to gpadc_data struct, to mark the difference
> between the old GPADCs and THS's and the new THS's.
> 
> The thermal sensors on A64 and H5 is like the one on H3, but with of
> course different formula factors.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
[...]
> +static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
> +{
>  	/* clkin = 6MHz */
>  	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
>  		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
>  		     SUN4I_GPADC_CTRL0_FS_DIV(7) |
>  		     SUN4I_GPADC_CTRL0_T_ACQ(63));
> -	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, info->data->tp_mode_en);
> +	regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
> +		     info->data->tp_mode_en);
>  	regmap_write(info->regmap, SUN4I_GPADC_CTRL3,
>  		     SUN4I_GPADC_CTRL3_FILTER_EN |
>  		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
> -	/* period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~0.6s */
> +	/*
> +	 * period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin;
> +	 * ~0.6s
> +	 */

Nothing's changed, I don't remember checkpatch complaining about those
lines. What's wrong with the original ones?

[...]
>  
> +	if (info->data->has_bus_rst) {
> +		info->reset = devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(info->reset)) {
> +			ret = PTR_ERR(info->reset);
> +			return ret;
> +		}
> +
> +		ret = reset_control_deassert(info->reset);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (info->data->has_bus_clk) {
> +		info->ths_bus_clk = devm_clk_get(&pdev->dev, "bus");
> +		if (IS_ERR(info->ths_bus_clk)) {
> +			ret = PTR_ERR(info->ths_bus_clk);
> +			return ret;
> +		}
> +
> +		ret = clk_prepare_enable(info->ths_bus_clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (info->data->has_ths_clk) {
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

I think you're missing the clk_disable_unprepare when one of the clk_foo
func fails.

I've never dealt with reset control but it seems odd to have a
reset_control_deassert in the probe and in the remove functions.

>  	if (!IS_ENABLED(CONFIG_THERMAL_OF))
>  		return 0;
>  
> @@ -691,6 +817,15 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
>  	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
>  		iio_map_array_unregister(indio_dev);
>  
> +	if (info->data->has_ths_clk)
> +		clk_disable_unprepare(info->ths_clk);
> +
> +	if (info->data->has_bus_clk)
> +		clk_disable_unprepare(info->ths_bus_clk);
> +
> +	if (info->data->has_bus_rst)
> +		reset_control_deassert(info->reset);
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> index d31d962bb7d8..36046a0d91f3 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -39,9 +39,13 @@
>  #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
>  
>  /* TP_CTRL1 bits for sun8i A23/A33 SoCs */
> +/* TP_CTRL1 bits for sun8i A23/A33 SoCs */

Spurious change?

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
