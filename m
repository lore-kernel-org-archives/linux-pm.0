From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v3 04/11] thermal: armada: Rationalize register accesses
Date: Fri, 15 Dec 2017 10:56:22 +0200
Message-ID: <20171215085622.6u4dmvyaph3mbb66@tarshish>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-5-miquel.raynal@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57969 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753622AbdLOI43 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 03:56:29 -0500
Content-Disposition: inline
In-Reply-To: <20171214103011.24713-5-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>

Hi Miquèl,

On Thu, Dec 14, 2017 at 11:30:04AM +0100, Miquel Raynal wrote:
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
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/thermal/armada_thermal.c | 86 +++++++++++++++++++++++++---------------
>  1 file changed, 55 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 26698f2d3ca7..e5b184cee79b 100644
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
> -	void __iomem *sensor;
> -	void __iomem *control;
> +	void __iomem *status;
> +	void __iomem *control0;
> +	void __iomem *control1;

The 'status' -> 'sensor' rename is not mentioned in the commit log. I'd say it 
is a matter for a separate patch.

Otherwise, good cleanup.

baruch

>  	struct armada_thermal_data *data;
>  };
>  
> @@ -71,45 +80,45 @@ struct armada_thermal_data {
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
> -	reg = readl_relaxed(priv->sensor);
> +	reg = readl_relaxed(priv->status);
>  	reg &= ~PMU_TM_DISABLE_MASK;
> -	writel(reg, priv->sensor);
> +	writel(reg, priv->status);
>  }
>  
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
> @@ -117,37 +126,37 @@ static void armada370_init_sensor(struct platform_device *pdev,
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
>  
>  static bool armada_is_valid(struct armada_thermal_priv *priv)
>  {
> -	unsigned long reg = readl_relaxed(priv->sensor);
> +	u32 reg = readl_relaxed(priv->status);
>  
>  	return reg & priv->data->is_valid_bit;
>  }
> @@ -156,7 +165,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  			  int *temp)
>  {
>  	struct armada_thermal_priv *priv = thermal->devdata;
> -	unsigned long reg;
> +	u32 reg;
>  	unsigned long m, b, div;
>  
>  	/* Valid check */
> @@ -166,7 +175,7 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
>  		return -EIO;
>  	}
>  
> -	reg = readl_relaxed(priv->sensor);
> +	reg = readl_relaxed(priv->status);
>  	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
>  
>  	/* Get formula coeficients */
> @@ -253,6 +262,7 @@ MODULE_DEVICE_TABLE(of, armada_thermal_id_table);
>  
>  static int armada_thermal_probe(struct platform_device *pdev)
>  {
> +	void __iomem *control = NULL;
>  	struct thermal_zone_device *thermal;
>  	const struct of_device_id *match;
>  	struct armada_thermal_priv *priv;
> @@ -267,14 +277,28 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(priv->sensor))
> -		return PTR_ERR(priv->sensor);
> +	priv->status = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->status))
> +		return PTR_ERR(priv->status);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	priv->control = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(priv->control))
> -		return PTR_ERR(priv->control);
> +	control = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(control))
> +		return PTR_ERR(control);
> +
> +	/*
> +	 * Legacy DT bindings only described "control1" register (also referred
> +	 * as "control MSB" on old documentation). New bindings cover
> +	 * "control0/control LSB" and "control1/control MSB" registers within
> +	 * the same resource, which is then of size 8 instead of 4.
> +	 */
> +	if ((res->end - res->start) == LEGACY_CONTROL_MEM_LEN) {
> +		/* ->control0 unavailable in this configuration */
> +		priv->control1 = control + LEGACY_CONTROL1_OFFSET;
> +	} else {
> +		priv->control0 = control + CONTROL0_OFFSET;
> +		priv->control1 = control + CONTROL1_OFFSET;
> +	}
>  
>  	priv->data = (struct armada_thermal_data *)match->data;
>  	priv->data->init_sensor(pdev, priv);

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
