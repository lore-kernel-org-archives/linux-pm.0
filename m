From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] thermal: Add support for Sunxi THS on the
 Allwinner H3
Date: Fri, 20 Nov 2015 17:59:00 +0100
Message-ID: <20151120165900.GK32142@lukather>
References: <20151118205147.GA19779@maud.lan>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T5F8Mpu1Sg8jtYtl"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBVVCXWZAKGQESTVPIHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151118205147.GA19779-G3LsmoRFMBI@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--T5F8Mpu1Sg8jtYtl
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi!

Thanks for your patch.

On Wed, Nov 18, 2015 at 09:51:48PM +0100, Josef Gajdusek wrote:
> This patch adds support for the Sunxi thermal sensor on the Allwinner H3.
> Also adds declaration of the H3 THS clock to clk-sunxi.c ignoring the
> dividers as they are not continuous (clk-divider.c cannot be used as it
> does not support setting an enable bit).
> Should be easily extendable for the A33/A83T/... as they have similar but
> not completely identical sensors.
> 
> Signed-off-by: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
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

Like other have pointed out, this should be split in several patches.

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

You'd rather use a divider table.

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

Allwinner H3 Thermal Sensor

> +	depends on ARCH_SUNXI

ARCH_SUN8I maybe ?

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

And call it sun8i_ths.

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

You don't need this header, it's meant for clock providers, as its
name suggest. You're only using the consumer API.

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>
> +
> +#define THS_H3_CTRL0			0x00
> +#define THS_H3_CTRL1			0x04
> +#define THS_H3_CDAT				0x14
> +#define THS_H3_CTRL2			0x40
> +#define THS_H3_INT_CTRL			0x44
> +#define THS_H3_STAT				0x48
> +#define THS_H3_ALARM_CTRL		0x50
> +#define THS_H3_SHUTDOWN_CTRL	0x60
> +#define THS_H3_FILTER			0x70
> +#define THS_H3_CDATA			0x74
> +#define THS_H3_DATA				0x80
> +
> +#define THS_H3_CTRL0_SENSOR_ACQ0		0
> +
> +#define THS_H3_CTRL1_ADC_CALI_EN		17
> +#define THS_H3_CTRL1_OP_BIAS			20
> +
> +#define THS_H3_CTRL2_SENSE_EN			0
> +#define THS_H3_CTRL2_SENSOR_ACQ1		16
> +
> +#define THS_H3_INT_CTRL_ALARM_INT_EN	0
> +#define THS_H3_INT_CTRL_SHUT_INT_EN		4
> +#define THS_H3_INT_CTRL_DATA_IRQ_EN		8
> +#define THS_H3_INT_CTRL_THERMAL_PER		12
> +
> +#define THS_H3_STAT_ALARM_INT_STS		0
> +#define THS_H3_STAT_SHUT_INT_STS		4
> +#define THS_H3_STAT_DATA_IRQ_STS		8
> +#define THS_H3_STAT_ALARM_OFF_STS		12
> +
> +#define THS_H3_ALARM_CTRL_ALARM0_T_HYST		0
> +#define THS_H3_ALARM_CTRL_ALARM0_T_HOT		16
> +
> +#define THS_H3_SHUTDOWN_CTRL_SHUT0_T_HOT	16

Usually, the masks are defined here, not the offsets, so that we can
use them directly in the code later, without risking to miss a BIT()
call.

> +
> +#define THS_H3_FILTER_TYPE				0
> +#define THS_H3_FILTER_EN				2
> +
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
> +};
> +
> +struct sunxi_ths_type {
> +	int (*init)(struct sunxi_ths_data *);
> +	int (*get_temp)(struct sunxi_ths_data *, int *out);
> +};

What do you need that structure for? Can't you just call the functions
directly?

> +
> +static int sunxi_ths_reg_to_temperature(int32_t reg, int divisor, int minus)
> +{
> +	return minus - (reg * 1000000) / divisor;
> +}
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

As pointed out by Chen-Yu, you should be using nvmem here.

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

Please define those values, even if they are not documented.

> +	return 0;
> +}
> +
> +static int sunxi_ths_h3_get_temp(struct sunxi_ths_data *data, int *out)
> +{
> +	*out = sunxi_ths_reg_to_temperature(readl(data->regs + THS_H3_DATA),
> +			8253, 217000);
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

It cannot fail, otherwise you wouldn't have probed in the first place.

> +
> +	data =
> +		devm_kzalloc(&pdev->dev, sizeof(struct sunxi_ths_data), GFP_KERNEL);

Why did you split this on an new line?

> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->type = (struct sunxi_ths_type *) match->data;
> +	data->pdev = pdev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->regs)) {
> +		ret = PTR_ERR(data->regs);
> +		dev_err(&pdev->dev, "failed to ioremap THS registers: %d\n", ret);
> +		return ret;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	data->calreg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->calreg))
> +		data->calreg = NULL; /* No calibration register */

Please use the nvmem framework here.

> +	data->busclk = devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(data->busclk)) {
> +		ret = PTR_ERR(data->busclk);
> +		dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	data->clk = devm_clk_get(&pdev->dev, "ths");
> +	if (IS_ERR(data->clk)) {
> +		ret = PTR_ERR(data->clk);
> +		dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	data->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");

Are you sure it's optional? In which cases?

> +	if (IS_ERR(data->reset)) {
> +		ret = PTR_ERR(data->reset);
> +		dev_err(&pdev->dev, "failed to get reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(data->busclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable bus clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(data->clk);

You probably don't need to enable the module clock all the time, but
only when reading values. Is there a callback in the thermal subsystem
that gets called when something start reading values? or can you sleep
in get_temp?

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable ths clk: %d\n", ret);
> +		goto err_disable_bus;
> +	}
> +
> +	ret = reset_control_deassert(data->reset);

If you're using an optional reset control, it will probably fail.

> +	if (ret) {
> +		dev_err(&pdev->dev, "reset deassert failed: %d\n", ret);
> +		goto err_disable_ths;
> +	}
> +
> +	ret = data->type->init(data);
> +	if (ret)
> +		goto err_reset_assert;
> +
> +	data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
> +									&sunxi_ths_thermal_ops);

Your wrapping is weird here too, it should be aligned on the opening
parenthesis.

> +	if (IS_ERR(data->tzd)) {
> +		ret = PTR_ERR(data->tzd);
> +		dev_err(&pdev->dev, "failed to register thermal zone: %d\n",
> +				ret);
> +		goto err_reset_assert;
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +
> +err_reset_assert:
> +	reset_control_assert(data->reset);
> +err_disable_ths:
> +	clk_disable_unprepare(data->clk);
> +err_disable_bus:
> +	clk_disable_unprepare(data->busclk);
> +	return ret;
> +}
> +
> +static int sunxi_ths_remove(struct platform_device *pdev)
> +{
> +	struct sunxi_ths_data *data = platform_get_drvdata(pdev);
> +
> +	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> +	reset_control_assert(data->reset);
> +	clk_disable_unprepare(data->clk);
> +	clk_disable_unprepare(data->busclk);
> +	return 0;
> +}
> +
> +static struct platform_driver sunxi_ths_driver = {
> +	.probe = sunxi_ths_probe,
> +	.remove = sunxi_ths_remove,
> +	.driver = {
> +		.name = "sunxi_ths",
> +		.of_match_table = sunxi_ths_id_table,
> +	},
> +};
> +
> +module_platform_driver(sunxi_ths_driver);
> +
> +MODULE_AUTHOR("Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>");
> +MODULE_DESCRIPTION("Sunxi THS driver");
> +MODULE_LICENSE("GPL v2");

It looks fine otherwise, thanks!
Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--T5F8Mpu1Sg8jtYtl--
