From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 06/11] thermal: armada: Add support for Armada CP110
Date: Thu, 14 Dec 2017 12:11:49 +0100
Message-ID: <87tvwto96y.fsf@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-7-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214103011.24713-7-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Thu, 14 Dec 2017 11:30:06 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Miquel,
 
 On jeu., déc. 14 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
>
> The CP110 component is integrated in the Armada 8k and 7k lines of
> processors.
>
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> [<miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>: renamed the register pointers]

Actually you did more thant this see below


> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/thermal/armada_thermal.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 279d01937bb8..f5c911524656 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -37,7 +37,6 @@
>  #define A375_UNIT_CONTROL_MASK		0x7
>  #define A375_READOUT_INVERT		BIT(15)
>  #define A375_HW_RESETn			BIT(8)
> -#define A380_HW_RESET			BIT(8)
>  
>  /* Legacy bindings */
>  #define LEGACY_CONTROL_MEM_LEN		0x4
> @@ -52,6 +51,10 @@
>  #define CONTROL0_TSEN_RESET		BIT(1)
>  #define CONTROL0_TSEN_ENABLE		BIT(2)
>  
> +/* EXT_TSEN refers to the external temperature sensors, out of the AP */
> +#define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
> +#define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
You added or rename these values

> +
>  struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
> @@ -153,11 +156,10 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  	u32 reg = readl_relaxed(priv->control1);
>  
>  	/* Reset hardware once */
> -	if (!(reg & A380_HW_RESET)) {
> -		reg |= A380_HW_RESET;
> -		writel(reg, priv->control1);
> -		msleep(10);
> -	}
> +	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
> +	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
> +	writel(reg, priv->control1);

And here you modified the behavior of this function.
Did you checked that it is valid for Armada 38x?

Given the comment we had, I thought we should not do anything if
CONTROL1_EXT_TSEN_HW_RESETn was not set.

By the way, if the new sequence is valid, this comment should be removed
or at least updated.

Gregory

> +	msleep(10);
>  }
>  
>  static void armada_ap806_init_sensor(struct platform_device *pdev,
> @@ -280,6 +282,18 @@ static const struct armada_thermal_data armada_ap806_data = {
>  	.signed_sample = true,
>  };
>  
> +static const struct armada_thermal_data armada_cp110_data = {
> +	.is_valid = armada_is_valid,
> +	.init_sensor = armada380_init_sensor,
> +	.is_valid_bit = BIT(10),
> +	.temp_shift = 0,
> +	.temp_mask = 0x3ff,
> +	.coef_b = 1172499100UL,
> +	.coef_m = 2000096UL,
> +	.coef_div = 4201,
> +	.inverted = true,
> +};
> +
>  static const struct of_device_id armada_thermal_id_table[] = {
>  	{
>  		.compatible = "marvell,armadaxp-thermal",
> @@ -302,6 +316,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
>  		.data       = &armada_ap806_data,
>  	},
>  	{
> +		.compatible = "marvell,armada-cp110-thermal",
> +		.data       = &armada_cp110_data,
> +	},
> +	{
>  		/* sentinel */
>  	},
>  };
> -- 
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
