From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: Re: [linux-sunxi] [PATCH] thermal: Add support for Sunxi THS on the
 Allwinner H3
Date: Thu, 19 Nov 2015 09:09:32 +0100
Message-ID: <20151119080932.GA32146@Red>
References: <20151118205147.GA19779@maud.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34265 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203AbbKSIJj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 03:09:39 -0500
Content-Disposition: inline
In-Reply-To: <20151118205147.GA19779@maud.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josef Gajdusek <atx@atx.name>
Cc: linux-sunxi@googlegroups.com, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, gpatchesrdh@mveas.com, mturquette@linaro.org, hdegoede@redhat.com, sboyd@codeaurora.org, mturquette@baylibre.com, emilio@elopez.com.ar, linux@arm.linux.org.uk, edubezval@gmail.com, rui.zhang@intel.com, wens@csie.org, maxime.ripard@free-electrons.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org

On Wed, Nov 18, 2015 at 09:51:48PM +0100, Josef Gajdusek wrote:
> This patch adds support for the Sunxi thermal sensor on the Allwinner H3.
> Also adds declaration of the H3 THS clock to clk-sunxi.c ignoring the
> dividers as they are not continuous (clk-divider.c cannot be used as it
> does not support setting an enable bit).
> Should be easily extendable for the A33/A83T/... as they have similar but
> not completely identical sensors.
> 
> Signed-off-by: Josef Gajdusek <atx@atx.name>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
>  .../devicetree/bindings/thermal/sunxi-ths.txt      |  24 ++
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  27 +++
>  drivers/clk/sunxi/clk-sunxi.c                      |  16 ++
>  drivers/thermal/Kconfig                            |   7 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/sunxi_ths.c                        | 263 +++++++++++++++++++++
>  7 files changed, 339 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunxi-ths.txt
>  create mode 100644 drivers/thermal/sunxi_ths.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 23e7bce..6d63b35 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -73,6 +73,7 @@ Required properties:
>  	"allwinner,sun8i-h3-usb-clk" - for usb gates + resets on H3
>  	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
>  	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
> +	"allwinner,sun8i-h3-ths-clk" - for THS on H3
>  
>  Required properties for all clocks:
>  - reg : shall be the control register address for the clock.
> diff --git a/Documentation/devicetree/bindings/thermal/sunxi-ths.txt b/Documentation/devicetree/bindings/thermal/sunxi-ths.txt
> new file mode 100644
> index 0000000..75c9211
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sunxi-ths.txt
> @@ -0,0 +1,24 @@
> +* sunxi THS
> +
> +Required properties:
> +- compatible : "allwinner,sun8i-h3-ths"
> +- reg : Address range of the thermal registers and location of the calibration
> +        value
> +- resets : Must contain an entry for each entry in reset-names.
> +           see ../reset/reset.txt for details
> +- reset-names : Must include the name "ahb"
> +- clocks : Must contain an entry for each entry in clock-names.
> +- clock-names : Must contain "ahb" for the bus gate and "ths" for the THS
> +  clock
> +
> +Example:
> +ths: ths@01c25000 {
> +	#thermal-sensor-cells = <0>;
> +	compatible = "allwinner,sun8i-h3-ths";
> +	reg = <0x01c25000 0x88>, <0x01c14234 0x4>;
> +	interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +	resets = <&bus_rst 136>;
> +	reset-names = "ahb";
> +	clocks = <&bus_gates 72>, <&ths_clk>;
> +	clock-names = "ahb", "ths";
> +};
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 0faa38a..b82881d 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -77,6 +77,14 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu_thermal: cpu_thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&ths 0>;
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> @@ -236,6 +244,14 @@
>  					"ahb1_ephy", "ahb1_dbg";
>  		};
>  
> +		ths_clk: clk@01c20074 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun8i-h3-ths-clk";
> +			reg = <0x01c20074 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "ths";
> +		};
> +
>  		mmc0_clk: clk@01c20088 {
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun4i-a10-mmc-clk";
> @@ -522,6 +538,17 @@
>  			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		ths: ths@01c25000 {
> +			#thermal-sensor-cells = <0>;
> +			compatible = "allwinner,sun8i-h3-ths";
> +			reg = <0x01c25000 0x88>, <0x01c14234 0x4>;
> +			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&bus_rst 104>;
> +			reset-names = "ahb";
> +			clocks = <&bus_gates 72>, <&ths_clk>;
> +			clock-names = "ahb", "ths";
> +		};
> +
>  		uart0: serial@01c28000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x01c28000 0x400>;
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 6293c65..637401a 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -604,6 +604,13 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
>  	*p = calcp;
>  }
>  
> +static void sun8i_h3_get_ths_factors(u32 *freq, u32 parent_rate,
> +				      u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +	/* Ignore the dividers as they are not continuous */
> +	*freq = parent_rate;
> +}
> +
>  /**
>   * sunxi_factors_clk_setup() - Setup function for factor clocks
>   */
> @@ -668,6 +675,8 @@ static struct clk_factors_config sun4i_apb1_config = {
>  	.pwidth = 2,
>  };
>  
> +static struct clk_factors_config sun8i_h3_ths_config = {};
> +
>  /* user manual says "n" but it's really "p" */
>  static struct clk_factors_config sun7i_a20_out_config = {
>  	.mshift = 8,
> @@ -734,6 +743,12 @@ static const struct factors_data sun7i_a20_out_data __initconst = {
>  	.getter = sun7i_a20_get_out_factors,
>  };
>  
> +static const struct factors_data sun8i_h3_ths_data __initconst = {
> +	.enable = 31,
> +	.table = &sun8i_h3_ths_config,
> +	.getter = sun8i_h3_get_ths_factors,
> +};
> +
>  static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
>  						   const struct factors_data *data)
>  {
> @@ -1127,6 +1142,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
>  	{.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
>  	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
>  	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
> +	{.compatible = "allwinner,sun8i-h3-ths-clk", .data = &sun8i_h3_ths_data,},
>  	{}
>  };
>  
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index c463c89..0111d4d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -365,6 +365,13 @@ config INTEL_PCH_THERMAL
>  	  Thermal reporting device will provide temperature reading,
>  	  programmable trip points and other information.
>  
> +config SUNXI_THS
> +	tristate "Sunxi THS driver"
> +	depends on ARCH_SUNXI
> +	depends on OF
> +	help
> +	  Enable this to support thermal reporting on some newer Allwinner SoC.
> +
>  menu "Texas Instruments thermal drivers"
>  depends on ARCH_HAS_BANDGAP || COMPILE_TEST
>  source "drivers/thermal/ti-soc-thermal/Kconfig"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index cfae6a6..3a25e3c 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -48,3 +48,4 @@ obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
>  obj-$(CONFIG_ST_THERMAL)	+= st/
>  obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> +obj-$(CONFIG_SUNXI_THS)		+= sunxi_ths.o
> diff --git a/drivers/thermal/sunxi_ths.c b/drivers/thermal/sunxi_ths.c
> new file mode 100644
> index 0000000..650cd39
> --- /dev/null
> +++ b/drivers/thermal/sunxi_ths.c
> @@ -0,0 +1,263 @@
> +/*
> + * Sunxi THS driver
> + *
> + * Copyright (C) 2015 Josef Gajdusek
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
I do not see any sign of irq in this code, so perhaps linux/irq.h and linux/interrupt.h are useless.

> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>

...

> +struct sunxi_ths_data {
> +	struct sunxi_ths_type *type;
> +	struct reset_control *reset;
> +	struct clk *clk;
> +	struct clk *busclk;
> +	void __iomem *regs;
> +	void __iomem *calreg;
> +	struct platform_device *pdev;
> +	struct thermal_zone_device *tzd;
> +	int irq;
/* This variable is never used */
> +};
> +
> +struct sunxi_ths_type {
> +	int (*init)(struct sunxi_ths_data *);
> +	int (*get_temp)(struct sunxi_ths_data *, int *out);
> +};
> +
> +static int sunxi_ths_reg_to_temperature(int32_t reg, int divisor, int minus)
> +{
> +	return minus - (reg * 1000000) / divisor;
> +}
Use s32 instead of int32_t
Perhaps this is a sign that you do not have used checkpatch --strict

> +
> +static int sunxi_ths_get_temp(void *_data, int *out)
> +{
> +	struct sunxi_ths_data *data = _data;
> +
> +	return data->type->get_temp(data, out);
> +}
> +
> +static int sunxi_ths_h3_init(struct sunxi_ths_data *data)
> +{
> +	if (data->calreg)
> +		writel(readl(data->calreg) & 0xfff, data->regs + THS_H3_CDATA);
> +	/* Magical constants mostly taken from Allwinner 3.4 kernel.
> +	 * Seem to work fine, though this could be configurable in DT/sysft
> +	 */
> +	writel(0xff << THS_H3_CTRL0_SENSOR_ACQ0,
> +			data->regs + THS_H3_CTRL0);
> +	writel((0x3f << THS_H3_CTRL2_SENSOR_ACQ1) | BIT(THS_H3_CTRL2_SENSE_EN),
> +			data->regs + THS_H3_CTRL2);
> +	writel((0x390 << THS_H3_INT_CTRL_THERMAL_PER) | BIT(THS_H3_INT_CTRL_DATA_IRQ_EN),
> +			data->regs + THS_H3_INT_CTRL);
> +	writel(BIT(THS_H3_FILTER_EN) | (0x2 << THS_H3_FILTER_TYPE),
> +			data->regs + THS_H3_FILTER);
> +	return 0;
> +}
> +
> +static int sunxi_ths_h3_get_temp(struct sunxi_ths_data *data, int *out)
> +{
> +	*out = sunxi_ths_reg_to_temperature(readl(data->regs + THS_H3_DATA),
> +			8253, 217000);
You could use a temp variable for avoiding this 80column wrap.
You could explain also from where 8253 and 217000 come from.

> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sunxi_ths_thermal_ops = {
> +	.get_temp = sunxi_ths_get_temp,
> +};
> +
> +static const struct sunxi_ths_type sunxi_ths_device_h3 = {
> +	.init = sunxi_ths_h3_init,
> +	.get_temp = sunxi_ths_h3_get_temp,
> +};
> +
> +static const struct of_device_id sunxi_ths_id_table[] = {
> +	{
> +		.compatible = "allwinner,sun8i-h3-ths",
> +		.data = &sunxi_ths_device_h3,
> +	},
> +	{
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_ths_id_table);
> +
> +static int sunxi_ths_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match;
> +	struct sunxi_ths_data *data;
> +	struct resource *res;
> +	int ret;
> +
> +	match = of_match_node(sunxi_ths_id_table, np);
> +	if (!match)
> +		return -ENXIO;
I think -ENXIO is not the correct return code.

> +
> +	data =
> +		devm_kzalloc(&pdev->dev, sizeof(struct sunxi_ths_data), GFP_KERNEL);
Prefer sizeof(*data)
Again use checkpatch --strict

Regards

