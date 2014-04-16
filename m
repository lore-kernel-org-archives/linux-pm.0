From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 4/6] thermal: armada: Support Armada 375 SoC
Date: Wed, 16 Apr 2014 11:38:19 -0400
Message-ID: <20140416153819.GF28159@titan.lakedaemon.net>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-5-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27941 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319AbaDPPiv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 11:38:51 -0400
Content-Disposition: inline
In-Reply-To: <1397657720-10893-5-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

Ezequiel,

On Wed, Apr 16, 2014 at 11:15:18AM -0300, Ezequiel Garcia wrote:
> Now that a generic infrastructure is in place, it's possible to support
> the new Armada 375 SoC thermal sensor. This sensor is similar to the one
> available in the already supported SoCs, with its specific temperature formula
> and specific sensor initialization.
> 
> In addition, we also add support for the Z1 SoC stepping, which needs
> an initialization-quirk to work properly.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/thermal/armada-thermal.txt |  7 ++
>  drivers/thermal/armada_thermal.c                   | 83 ++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> index fff93d5..745d241 100644
> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -4,8 +4,15 @@ Required properties:
>  
>  - compatible:	Should be set to one of the following:
>  		marvell,armada370-thermal
> +		marvell,armada375-thermal
> +		marvell,armada375-z1-thermal
>  		marvell,armadaxp-thermal
>  
> +		Note: As the name suggests, "marvell,armada375-z1-thermal"
> +		applies for the SoC Z1 stepping only. The operating system
> +		may auto-detect the SoC stepping and update the compatible
> +		at runtime.
> +
>  - reg:		Device's register space.
>  		Two entries are expected, see the examples below.
>  		The first one is required for the sensor register;
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 3e4d8ef..a37942b 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -35,6 +35,15 @@
>  #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
>  #define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
>  
> +#define A375_Z1_CAL_RESET_LSB		0x8011e214
> +#define A375_Z1_CAL_RESET_MSB		0x30a88019
> +#define A375_Z1_WORKAROUND_BIT		BIT(9)
> +
> +#define TSEN40_UNIT_CONTROL_OFFSET	27
> +#define TSEN40_UNIT_CONTROL_MASK	0x7
> +#define TSEN40_READOUT_INVERT		BIT(15)
> +#define TSEN40_HW_RESETn		BIT(8)
> +
>  struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
> @@ -106,6 +115,50 @@ static void armada370_init_sensor(struct armada_thermal_priv *priv)
>  	mdelay(10);
>  }
>  
> +static void armada375_init_sensor(struct armada_thermal_priv *priv)
> +{
> +	unsigned long reg;
> +
> +	reg = readl(priv->control + 4);
> +	reg &= ~(TSEN40_UNIT_CONTROL_MASK << TSEN40_UNIT_CONTROL_OFFSET);
> +	reg &= ~TSEN40_READOUT_INVERT;
> +	reg &= ~TSEN40_HW_RESETn;
> +
> +	writel(reg, priv->control + 4);
> +	mdelay(20);
> +
> +	reg |= TSEN40_HW_RESETn;
> +	writel(reg, priv->control + 4);
> +	mdelay(50);
> +}
> +
> +static void armada375_z1_init_sensor(struct armada_thermal_priv *priv)
> +{
> +	unsigned long reg;
> +


> +	/*
> +	 * On A375 Z1 SoC silicon revision the default (reset) values
> +	 * must be written.
> +	 */
> +	writel(A375_Z1_CAL_RESET_LSB, priv->control);
> +	writel(A375_Z1_CAL_RESET_MSB, priv->control + 0x4);

this...

> +
> +	reg = readl(priv->control + 4);
> +	reg &= ~(TSEN40_UNIT_CONTROL_MASK << TSEN40_UNIT_CONTROL_OFFSET);
> +	reg &= ~TSEN40_READOUT_INVERT;
> +	reg &= ~TSEN40_HW_RESETn;
> +


> +	/* This is only needed on A375 Z1 SoC silicon revision */
> +	reg |= A375_Z1_WORKAROUND_BIT;

and this seem to be the only differences between the two init functions.

It also appears to be the only reason for having two data structs below.
Is it worth checking for the compatible string in the init function so
you only have one init and one data struct?

> +
> +	writel(reg, priv->control + 4);
> +	mdelay(20);
> +
> +	reg |= TSEN40_HW_RESETn;
> +	writel(reg, priv->control + 4);
> +	mdelay(50);
> +}
> +
>  static bool armada_is_valid(struct armada_thermal_priv *priv)
>  {
>  	unsigned long reg = readl_relaxed(priv->sensor);
> @@ -163,6 +216,28 @@ static const struct armada_thermal_data armada370_data = {
>  	.coef_div = 13825,
>  };
>  



> +static const struct armada_thermal_data armada375_data = {
> +	.is_valid = armada_is_valid,
> +	.init_sensor = armada375_init_sensor,
> +	.is_valid_offset = 10,
> +	.temp_offset = 0,
> +	.temp_mask = 0x1ff,
> +	.coef_b = 3171900000UL,
> +	.coef_m = 10000000UL,
> +	.coef_div = 13616,
> +};
> +
> +static const struct armada_thermal_data armada375_z1_data = {
> +	.is_valid = armada_is_valid,
> +	.init_sensor = armada375_z1_init_sensor,
> +	.is_valid_offset = 10,
> +	.temp_offset = 0,
> +	.temp_mask = 0x1ff,
> +	.coef_b = 3171900000UL,
> +	.coef_m = 10000000UL,
> +	.coef_div = 13616,
> +};

thx,

Jason.

> +
>  static const struct of_device_id armada_thermal_id_table[] = {
>  	{
>  		.compatible = "marvell,armadaxp-thermal",
> @@ -173,6 +248,14 @@ static const struct of_device_id armada_thermal_id_table[] = {
>  		.data       = &armada370_data,
>  	},
>  	{
> +		.compatible = "marvell,armada375-thermal",
> +		.data       = &armada375_data,
> +	},
> +	{
> +		.compatible = "marvell,armada375-z1-thermal",
> +		.data       = &armada375_z1_data,
> +	},
> +	{
>  		/* sentinel */
>  	},
>  };
> -- 
> 1.9.1
> 
