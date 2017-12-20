From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 07/11] thermal: armada: Add support for Armada CP110
Date: Wed, 20 Dec 2017 11:56:51 +0100
Message-ID: <87r2rpfz0s.fsf@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
        <20171219135719.9531-8-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54450 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbdLTK5D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 05:57:03 -0500
In-Reply-To: <20171219135719.9531-8-miquel.raynal@free-electrons.com> (Miquel
        Raynal's message of "Tue, 19 Dec 2017 14:57:15 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

Hi Miquel,
 
 On mar., déc. 19 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Baruch Siach <baruch@tkos.co.il>
>
> The CP110 component is integrated in the Armada 8k and 7k lines of
> processors.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> [<miquel.raynal@free-electrons.com>: renamed the register pointers as
> well as some definitions related to the new register names and
> simplified the init sequence for Armada 380]
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Here again, on Armada 7040 DB and Machitobin, the temperature value
looks coherent:

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Gregory


> ---
>  drivers/thermal/armada_thermal.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index c7dcac39cbf9..3785b5248bf5 100644
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
> +
>  struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
> @@ -153,12 +156,11 @@ static void armada380_init_sensor(struct platform_device *pdev,
>  {
>  	u32 reg = readl_relaxed(priv->control1);
>  
> -	/* Reset hardware once */
> -	if (!(reg & A380_HW_RESET)) {
> -		reg |= A380_HW_RESET;
> -		writel(reg, priv->control1);
> -		msleep(10);
> -	}
> +	/* Disable the HW/SW reset */
> +	reg |= CONTROL1_EXT_TSEN_HW_RESETn;
> +	reg &= ~CONTROL1_EXT_TSEN_SW_RESET;
> +	writel(reg, priv->control1);
> +	msleep(10);
>  }
>  
>  static void armada_ap806_init_sensor(struct platform_device *pdev,
> @@ -279,6 +281,19 @@ static const struct armada_thermal_data armada_ap806_data = {
>  	.needs_control0 = true,
>  };
>  
> +static const struct armada_thermal_data armada_cp110_data = {
> +	.is_valid = armada_is_valid,
> +	.init_sensor = armada380_init_sensor,
> +	.is_valid_bit = BIT(10),
> +	.temp_shift = 0,
> +	.temp_mask = 0x3ff,
> +	.coef_b = 1172499100ULL,
> +	.coef_m = 2000096ULL,
> +	.coef_div = 4201,
> +	.inverted = true,
> +	.needs_control0 = true,
> +};
> +
>  static const struct of_device_id armada_thermal_id_table[] = {
>  	{
>  		.compatible = "marvell,armadaxp-thermal",
> @@ -301,6 +316,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
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

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
