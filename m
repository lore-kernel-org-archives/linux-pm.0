From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/4] iio: adc: sun4i-gpadc-iio: rename
 A23/A33-specified registers to contain A23
Date: Mon, 3 Apr 2017 15:28:11 +0100
Message-ID: <20170403142811.bdbc6mspwofms6uo@dell>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-3-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170402133304.56824-3-icenowy-h8G6r0blFSE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sun, 02 Apr 2017, Icenowy Zheng wrote:

> As the H3 SoC, which is also in sun8i line, has totally different
> register map for the thermal sensor (a cut down version of GPADC), we
> should rename A23/A33-specified registers to contain A23, in order to
> prevent obfuscation with H3 registers. Currently these registers are
> only prefixed "SUN8I", not "SUN8I_A23".
> 
> Add "_A23" after "SUN8I" on the register names.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
> Splited from RFC v1's 2/3.
> 
>  drivers/iio/adc/sun4i-gpadc-iio.c | 2 +-
>  include/linux/mfd/sun4i-gpadc.h   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 74705aa37982..01cf806f47f8 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -88,7 +88,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
>  static const struct gpadc_data sun8i_a33_gpadc_data = {
>  	.temp_offset = -1662,
>  	.temp_scale = 162,
> -	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
> +	.tp_mode_en = SUN8I_A23_GPADC_CTRL1_CHOP_TEMP_EN,
>  };
>  
>  struct sun4i_gpadc_iio {
> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> index 139872c2e0fe..d31d962bb7d8 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -38,9 +38,9 @@
>  #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
>  #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
>  
> -/* TP_CTRL1 bits for sun8i SoCs */
> -#define SUN8I_GPADC_CTRL1_CHOP_TEMP_EN			BIT(8)
> -#define SUN8I_GPADC_CTRL1_GPADC_CALI_EN			BIT(7)
> +/* TP_CTRL1 bits for sun8i A23/A33 SoCs */
> +#define SUN8I_A23_GPADC_CTRL1_CHOP_TEMP_EN		BIT(8)
> +#define SUN8I_A23_GPADC_CTRL1_GPADC_CALI_EN		BIT(7)
>  
>  #define SUN4I_GPADC_CTRL2				0x08
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
