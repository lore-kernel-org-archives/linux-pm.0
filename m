From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 06/11] thermal: armada: Add support for Armada AP806
Date: Wed, 20 Dec 2017 11:56:20 +0100
Message-ID: <87vah1fz1n.fsf@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
        <20171219135719.9531-7-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171219135719.9531-7-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Tue, 19 Dec 2017 14:57:14 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Miquel,
 
 On mar., déc. 19 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
>
> The AP806 component is integrated in the Armada 8K and 7K lines of
> processors.
>
> The thermal sensor sample field on the status register is a signed
> value. Extend armada_get_temp() and the driver structure to handle
> signed values.
>
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> [<miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>: Changes when applying over the
> previous patches, including the register names changes, also switched
> the coefficients values to s64 instead of unsigned long to deal with
> negative values and used do_div instead of the traditionnal '/']
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

On Armada 7040 DB and Machitobin, the temperature value looks coherent:

Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Gregory


> ---
>  drivers/thermal/armada_thermal.c | 74 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ceebabf45c53..c7dcac39cbf9 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -47,6 +47,11 @@
>  #define CONTROL0_OFFSET			0x0
>  #define CONTROL1_OFFSET			0x4
>  
> +/* TSEN refers to the temperature sensors within the AP */
> +#define CONTROL0_TSEN_START		BIT(0)
> +#define CONTROL0_TSEN_RESET		BIT(1)
> +#define CONTROL0_TSEN_ENABLE		BIT(2)
> +
>  struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
> @@ -66,10 +71,11 @@ struct armada_thermal_data {
>  	bool (*is_valid)(struct armada_thermal_priv *);
>  
>  	/* Formula coeficients: temp = (b - m * reg) / div */
> -	unsigned long coef_b;
> -	unsigned long coef_m;
> -	unsigned long coef_div;
> +	s64 coef_b;
> +	s64 coef_m;
> +	u32 coef_div;
>  	bool inverted;
> +	bool signed_sample;
>  
>  	/* Register shift and mask to access the sensor temperature */
>  	unsigned int temp_shift;
> @@ -155,6 +161,18 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	}
>  }
>  
> +static void armada_ap806_init_sensor(struct platform_device *pdev,
> +				     struct armada_thermal_priv *priv)
> +{
> +	u32 reg;
> +
> +	reg = readl_relaxed(priv->control0);
> +	reg &= ~CONTROL0_TSEN_RESET;
> +	reg |= CONTROL0_TSEN_START | CONTROL0_TSEN_ENABLE;
> +	writel(reg, priv->control0);
> +	msleep(10);
> +}
> +
>  static bool armada_is_valid(struct armada_thermal_priv *priv)
>  {
>  	u32 reg = readl_relaxed(priv->status);
> @@ -166,8 +184,8 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  			  int *temp)
>  {
>  	struct armada_thermal_priv *priv = thermal->devdata;
> -	unsigned long reg;
> -	unsigned long m, b, div;
> +	u32 reg, div;
> +	s64 sample, b, m;
>  
>  	/* Valid check */
>  	if (priv->data->is_valid && !priv->data->is_valid(priv)) {
> @@ -178,6 +196,11 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  
>  	reg = readl_relaxed(priv->status);
>  	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
> +	if (priv->data->signed_sample)
> +		/* The most significant bit is the sign bit */
> +		sample = sign_extend32(reg, fls(priv->data->temp_mask) - 1);
> +	else
> +		sample = reg;
>  
>  	/* Get formula coeficients */
>  	b = priv->data->coef_b;
> @@ -185,9 +208,12 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  	div = priv->data->coef_div;
>  
>  	if (priv->data->inverted)
> -		*temp = ((m * reg) - b) / div;
> +		*temp = (m * sample) - b;
>  	else
> -		*temp = (b - (m * reg)) / div;
> +		*temp = b - (m * sample);
> +
> +	do_div(*temp, div);
> +
>  	return 0;
>  }
>  
> @@ -199,8 +225,8 @@ static const struct armada_thermal_data armadaxp_data = {
>  	.init_sensor = armadaxp_init_sensor,
>  	.temp_shift = 10,
>  	.temp_mask = 0x1ff,
> -	.coef_b = 3153000000UL,
> -	.coef_m = 10000000UL,
> +	.coef_b = 3153000000ULL,
> +	.coef_m = 10000000ULL,
>  	.coef_div = 13825,
>  };
>  
> @@ -210,8 +236,8 @@ static const struct armada_thermal_data armada370_data = {
>  	.is_valid_bit = BIT(9),
>  	.temp_shift = 10,
>  	.temp_mask = 0x1ff,
> -	.coef_b = 3153000000UL,
> -	.coef_m = 10000000UL,
> +	.coef_b = 3153000000ULL,
> +	.coef_m = 10000000ULL,
>  	.coef_div = 13825,
>  };
>  
> @@ -221,8 +247,8 @@ static const struct armada_thermal_data armada375_data = {
>  	.is_valid_bit = BIT(10),
>  	.temp_shift = 0,
>  	.temp_mask = 0x1ff,
> -	.coef_b = 3171900000UL,
> -	.coef_m = 10000000UL,
> +	.coef_b = 3171900000ULL,
> +	.coef_m = 10000000ULL,
>  	.coef_div = 13616,
>  	.needs_control0 = true,
>  };
> @@ -233,12 +259,26 @@ static const struct armada_thermal_data armada380_data = {
>  	.is_valid_bit = BIT(10),
>  	.temp_shift = 0,
>  	.temp_mask = 0x3ff,
> -	.coef_b = 1172499100UL,
> -	.coef_m = 2000096UL,
> +	.coef_b = 1172499100ULL,
> +	.coef_m = 2000096ULL,
>  	.coef_div = 4201,
>  	.inverted = true,
>  };
>  
> +static const struct armada_thermal_data armada_ap806_data = {
> +	.is_valid = armada_is_valid,
> +	.init_sensor = armada_ap806_init_sensor,
> +	.is_valid_bit = BIT(16),
> +	.temp_shift = 0,
> +	.temp_mask = 0x3ff,
> +	.coef_b = -150000LL,
> +	.coef_m = 423ULL,
> +	.coef_div = 1,
> +	.inverted = true,
> +	.signed_sample = true,
> +	.needs_control0 = true,
> +};
> +
>  static const struct of_device_id armada_thermal_id_table[] = {
>  	{
>  		.compatible = "marvell,armadaxp-thermal",
> @@ -257,6 +297,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
>  		.data       = &armada380_data,
>  	},
>  	{
> +		.compatible = "marvell,armada-ap806-thermal",
> +		.data       = &armada_ap806_data,
> +	},
> +	{
>  		/* sentinel */
>  	},
>  };
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
