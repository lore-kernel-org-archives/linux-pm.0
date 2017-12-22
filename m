From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 04/11] thermal: armada: Clarify control registers accesses
Date: Fri, 22 Dec 2017 16:33:53 +0100
Message-ID: <877eteepzy.fsf@free-electrons.com>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
        <20171222093226.23456-5-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171222093226.23456-5-miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Miquel
        Raynal's message of "Fri, 22 Dec 2017 10:32:19 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Miquel,
 
 On ven., déc. 22 2017, Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Bindings were incomplete for a long time by only exposing one of the two
> available control registers. To ease the migration to the full bindings
> (already in use for the Armada 375 SoC), rename the pointers for
> clarification. This way, it will only be needed to add another pointer
> to access the other control register when the time comes.
>
> This avoids dangerous situations where the offset 0 of the control
> area can be either one register or the other depending on the bindings
> used. After this change, device trees of other SoCs could be migrated to
> the "full" bindings if they may benefit from features from the
> unaccessible register, without any change in the driver.
>
> Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

I tested that there was no regression on an Armada XP based board:
PlatHome OpenBlocks AX3-4, and on an Armada 388 one: SolidRun Clearfog
A1. For both of them it was OK:

Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Gregory

> ---
>  drivers/thermal/armada_thermal.c | 76 ++++++++++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index f350d7efd35a..d58376eba6d9 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -39,12 +39,21 @@
>  #define A375_HW_RESETn			BIT(8)
>  #define A380_HW_RESET			BIT(8)
>  
> +/* Legacy bindings */
> +#define LEGACY_CONTROL_MEM_LEN		0x4
> +
> +/* Current bindings with the 2 control registers under the same memory area */
> +#define LEGACY_CONTROL1_OFFSET		0x0
> +#define CONTROL0_OFFSET			0x0
> +#define CONTROL1_OFFSET			0x4
> +
>  struct armada_thermal_data;
>  
>  /* Marvell EBU Thermal Sensor Dev Structure */
>  struct armada_thermal_priv {
>  	void __iomem *sensor;
> -	void __iomem *control;
> +	void __iomem *control0;
> +	void __iomem *control1;
>  	struct armada_thermal_data *data;
>  };
>  
> @@ -66,27 +75,28 @@ struct armada_thermal_data {
>  	unsigned int temp_shift;
>  	unsigned int temp_mask;
>  	u32 is_valid_bit;
> +	bool needs_control0;
>  };
>  
>  static void armadaxp_init_sensor(struct platform_device *pdev,
>  				 struct armada_thermal_priv *priv)
>  {
> -	unsigned long reg;
> +	u32 reg;
>  
> -	reg = readl_relaxed(priv->control);
> +	reg = readl_relaxed(priv->control1);
>  	reg |= PMU_TDC0_OTF_CAL_MASK;
> -	writel(reg, priv->control);
> +	writel(reg, priv->control1);
>  
>  	/* Reference calibration value */
>  	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
>  	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> -	writel(reg, priv->control);
> +	writel(reg, priv->control1);
>  
>  	/* Reset the sensor */
> -	reg = readl_relaxed(priv->control);
> -	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
> +	reg = readl_relaxed(priv->control1);
> +	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control1);
>  
> -	writel(reg, priv->control);
> +	writel(reg, priv->control1);
>  
>  	/* Enable the sensor */
>  	reg = readl_relaxed(priv->sensor);
> @@ -97,19 +107,19 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
>  static void armada370_init_sensor(struct platform_device *pdev,
>  				  struct armada_thermal_priv *priv)
>  {
> -	unsigned long reg;
> +	u32 reg;
>  
> -	reg = readl_relaxed(priv->control);
> +	reg = readl_relaxed(priv->control1);
>  	reg |= PMU_TDC0_OTF_CAL_MASK;
> -	writel(reg, priv->control);
> +	writel(reg, priv->control1);
>  
>  	/* Reference calibration value */
>  	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
>  	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> -	writel(reg, priv->control);
> +	writel(reg, priv->control1);
>  
>  	reg &= ~PMU_TDC0_START_CAL_MASK;
> -	writel(reg, priv->control);
> +	writel(reg, priv->control1);
>  
>  	msleep(10);
>  }
> @@ -117,30 +127,30 @@ static void armada370_init_sensor(struct platform_device *pdev,
>  static void armada375_init_sensor(struct platform_device *pdev,
>  				  struct armada_thermal_priv *priv)
>  {
> -	unsigned long reg;
> +	u32 reg;
>  
> -	reg = readl(priv->control + 4);
> +	reg = readl(priv->control1);
>  	reg &= ~(A375_UNIT_CONTROL_MASK << A375_UNIT_CONTROL_SHIFT);
>  	reg &= ~A375_READOUT_INVERT;
>  	reg &= ~A375_HW_RESETn;
>  
> -	writel(reg, priv->control + 4);
> +	writel(reg, priv->control1);
>  	msleep(20);
>  
>  	reg |= A375_HW_RESETn;
> -	writel(reg, priv->control + 4);
> +	writel(reg, priv->control1);
>  	msleep(50);
>  }
>  
>  static void armada380_init_sensor(struct platform_device *pdev,
>  				  struct armada_thermal_priv *priv)
>  {
> -	unsigned long reg = readl_relaxed(priv->control);
> +	u32 reg = readl_relaxed(priv->control1);
>  
>  	/* Reset hardware once */
>  	if (!(reg & A380_HW_RESET)) {
>  		reg |= A380_HW_RESET;
> -		writel(reg, priv->control);
> +		writel(reg, priv->control1);
>  		msleep(10);
>  	}
>  }
> @@ -214,6 +224,7 @@ static const struct armada_thermal_data armada375_data = {
>  	.coef_b = 3171900000UL,
>  	.coef_m = 10000000UL,
>  	.coef_div = 13616,
> +	.needs_control0 = true,
>  };
>  
>  static const struct armada_thermal_data armada380_data = {
> @@ -253,6 +264,7 @@ MODULE_DEVICE_TABLE(of, armada_thermal_id_table);
>  
>  static int armada_thermal_probe(struct platform_device *pdev)
>  {
> +	void __iomem *control = NULL;
>  	struct thermal_zone_device *thermal;
>  	const struct of_device_id *match;
>  	struct armada_thermal_priv *priv;
> @@ -272,11 +284,31 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->sensor);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	priv->control = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(priv->control))
> -		return PTR_ERR(priv->control);
> +	control = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(control))
> +		return PTR_ERR(control);
>  
>  	priv->data = (struct armada_thermal_data *)match->data;
> +
> +	/*
> +	 * Legacy DT bindings only described "control1" register (also referred
> +	 * as "control MSB" on old documentation). New bindings cover
> +	 * "control0/control LSB" and "control1/control MSB" registers within
> +	 * the same resource, which is then of size 8 instead of 4.
> +	 */
> +	if (resource_size(res) == LEGACY_CONTROL_MEM_LEN) {
> +		/* ->control0 unavailable in this configuration */
> +		if (priv->data->needs_control0) {
> +			dev_err(&pdev->dev, "No access to control0 register\n");
> +			return -EINVAL;
> +		}
> +
> +		priv->control1 = control + LEGACY_CONTROL1_OFFSET;
> +	} else {
> +		priv->control0 = control + CONTROL0_OFFSET;
> +		priv->control1 = control + CONTROL1_OFFSET;
> +	}
> +
>  	priv->data->init_sensor(pdev, priv);
>  
>  	thermal = thermal_zone_device_register("armada_thermal", 0, 0,
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
