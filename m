From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 02/14] thermal: sun8i_ths: Add support for the thermal
 sensor on Allwinner H3
Date: Sat, 25 Jun 2016 09:10:44 +0200
Message-ID: <20160625071044.GB4000@lukather>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-3-megous@megous.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160625034511.7966-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
To: megous@megous.com
Cc: dev@linux-sunxi.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Chen-Yu Tsai <wens@csie.org>, open list <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 25, 2016 at 05:44:59AM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> This patch adds support for the sun8i thermal sensor on
> Allwinner H3 SoC.
>=20
> Signed-off-by: Ond=C5=99ej Jirman <megous@megous.com>
> ---
> v2:
> - removed incorrect use of SID driver in sun8i_ths
> - read calibration data directly from iomem =20
> - better explanation for the thermal sensor driver
> - dt documentation fixes
> - dropped unncecessary macros and init code reorganization
> - moved resource aquisition from init to probe function
> - deassert reset after clock rate is set, not before
> - enable irq after all other registers are configured
> ---
>  drivers/thermal/Kconfig     |   7 ++
>  drivers/thermal/Makefile    |   1 +
>  drivers/thermal/sun8i_ths.c | 260 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 drivers/thermal/sun8i_ths.c
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2d702ca..d3209d9 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -351,6 +351,13 @@ config MTK_THERMAL
>  	  Enable this option if you want to have support for thermal management
>  	  controller present in Mediatek SoCs
> =20
> +config SUN8I_THS
> +	tristate "Thermal sensor driver for Allwinner H3"
> +	depends on MACH_SUN8I
> +	depends on OF
> +	help
> +	  Enable this to support thermal reporting on some newer Allwinner SoCs.
> +
>  menu "Texas Instruments thermal drivers"
>  depends on ARCH_HAS_BANDGAP || COMPILE_TEST
>  depends on HAS_IOMEM
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 10b07c1..7261ee8 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -51,3 +51,4 @@ obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra/
>  obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+=3D mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+=3D thermal-generic-adc.o
> +obj-$(CONFIG_SUN8I_THS)		+=3D sun8i_ths.o
> diff --git a/drivers/thermal/sun8i_ths.c b/drivers/thermal/sun8i_ths.c
> new file mode 100644
> index 0000000..9ba0f96
> --- /dev/null
> +++ b/drivers/thermal/sun8i_ths.c
> @@ -0,0 +1,260 @@
> +/*
> + * Thermal sensor driver for Allwinner H3 SoC
> + *
> + * Copyright (C) 2016 Ond=C5=99ej Jirman
> + * Based on the work of Josef Gajdusek <atx@atx.name>
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
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/printk.h>
> +
> +#define THS_H3_CTRL0		0x00
> +#define THS_H3_CTRL2		0x40
> +#define THS_H3_INT_CTRL		0x44
> +#define THS_H3_STAT		0x48
> +#define THS_H3_FILTER		0x70
> +#define THS_H3_CDATA		0x74
> +#define THS_H3_DATA		0x80
> +
> +#define THS_H3_CTRL0_SENSOR_ACQ0(x)     (x)
> +#define THS_H3_CTRL2_SENSE_EN           BIT(0)
> +#define THS_H3_CTRL2_SENSOR_ACQ1(x)     ((x) << 16)
> +#define THS_H3_INT_CTRL_DATA_IRQ_EN     BIT(8)
> +#define THS_H3_INT_CTRL_THERMAL_PER(x)  ((x) << 12)
> +#define THS_H3_STAT_DATA_IRQ_STS        BIT(8)
> +#define THS_H3_FILTER_TYPE(x)           ((x) << 0)
> +#define THS_H3_FILTER_EN                BIT(2)
> +
> +#define THS_H3_CLK_IN 40000000  /* Hz */
> +#define THS_H3_DATA_PERIOD 330  /* ms */
> +
> +#define THS_H3_FILTER_TYPE_VALUE		2  /* average over 2^(n+1) samples */
> +#define THS_H3_FILTER_DIV			(1 << (THS_H3_FILTER_TYPE_VALUE + 1))
> +#define THS_H3_INT_CTRL_THERMAL_PER_VALUE \
> +	(THS_H3_DATA_PERIOD * (THS_H3_CLK_IN / 1000) / THS_H3_FILTER_DIV / 4096=
 - 1)
> +#define THS_H3_CTRL0_SENSOR_ACQ0_VALUE		0x3f /* 16us */
> +#define THS_H3_CTRL2_SENSOR_ACQ1_VALUE		0x3f
> +
> +struct sun8i_ths_data {
> +	struct reset_control *reset;
> +	struct clk *clk;
> +	struct clk *busclk;
> +	void __iomem *regs;
> +	void __iomem *calreg;
> +	struct thermal_zone_device *tzd;
> +	u32 temp;
> +};
> +
> +static int sun8i_ths_get_temp(void *_data, int *out)
> +{
> +	struct sun8i_ths_data *data =3D _data;
> +
> +	if (data->temp =3D=3D 0)
> +		return -EINVAL;
> +
> +	/* Formula and parameters from the Allwinner 3.4 kernel */
> +	*out =3D 217000 - (int)((data->temp * 1000000) / 8253);
> +	return 0;
> +}
> +
> +static irqreturn_t sun8i_ths_irq_thread(int irq, void *_data)
> +{
> +	struct sun8i_ths_data *data =3D _data;
> +
> +	writel(THS_H3_STAT_DATA_IRQ_STS, data->regs + THS_H3_STAT);
> +
> +	data->temp =3D readl(data->regs + THS_H3_DATA);
> +	if (data->temp)
> +		thermal_zone_device_update(data->tzd);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sun8i_ths_h3_init(struct sun8i_ths_data *data)
> +{
> +	u32 caldata;
> +=09
> +	caldata =3D readl(data->calreg) & 0xfff;
> +	if (caldata !=3D 0)
> +		writel(caldata, data->regs + THS_H3_CDATA);
> +
> +	writel(THS_H3_CTRL0_SENSOR_ACQ0(THS_H3_CTRL0_SENSOR_ACQ0_VALUE),
> +		data->regs + THS_H3_CTRL0);
> +	writel(THS_H3_FILTER_EN | THS_H3_FILTER_TYPE(THS_H3_FILTER_TYPE_VALUE),
> +		data->regs + THS_H3_FILTER);
> +	writel(THS_H3_CTRL2_SENSOR_ACQ1(THS_H3_CTRL2_SENSOR_ACQ1_VALUE) |
> +		THS_H3_CTRL2_SENSE_EN,
> +		data->regs + THS_H3_CTRL2);
> +	writel(THS_H3_INT_CTRL_THERMAL_PER(THS_H3_INT_CTRL_THERMAL_PER_VALUE) |
> +		THS_H3_INT_CTRL_DATA_IRQ_EN,
> +		data->regs + THS_H3_INT_CTRL);
> +}
> +
> +static const struct thermal_zone_of_device_ops sun8i_ths_thermal_ops =3D=
 {
> +	.get_temp =3D sun8i_ths_get_temp,
> +};
> +
> +static int sun8i_ths_probe(struct platform_device *pdev)
> +{
> +	struct sun8i_ths_data *data;
> +	struct resource *res;
> +	int ret;
> +	int irq;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +        if (!res) {
> +                dev_err(&pdev->dev, "no memory resources defined\n");
> +                return -EINVAL;
> +        }
> +
> +	data->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->regs)) {
> +		ret =3D PTR_ERR(data->regs);
> +		dev_err(&pdev->dev, "failed to ioremap THS registers: %d\n", ret);
> +		return ret;
> +	}
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +        if (!res) {
> +                dev_err(&pdev->dev, "no calibration data memory resource=
 defined\n");
> +                return -EINVAL;
> +        }
> +
> +	data->calreg =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->calreg)) {
> +		ret =3D PTR_ERR(data->calreg);
> +		dev_err(&pdev->dev, "failed to ioremap THS registers: %d\n", ret);
> +		return ret;
> +	}

Why did you remove the SID use through the nvmem framework ?!

> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
> +		return irq;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					sun8i_ths_irq_thread, IRQF_ONESHOT,
> +					dev_name(&pdev->dev), data);
> +	if (ret)
> +		return ret;
> +
> +	data->busclk =3D devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(data->busclk)) {
> +		ret =3D PTR_ERR(data->busclk);
> +		dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	data->clk =3D devm_clk_get(&pdev->dev, "ths");
> +	if (IS_ERR(data->clk)) {
> +		ret =3D PTR_ERR(data->clk);
> +		dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	data->reset =3D devm_reset_control_get(&pdev->dev, "ahb");
> +	if (IS_ERR(data->reset)) {
> +		ret =3D PTR_ERR(data->reset);
> +		dev_err(&pdev->dev, "failed to get reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(data->busclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable bus clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable ths clk: %d\n", ret);
> +		goto err_disable_bus;
> +	}
> +
> +	ret =3D clk_set_rate(data->clk, THS_H3_CLK_IN);
> +	if (ret)
> +		goto err_disable_ths;
> +
> +	ret =3D reset_control_deassert(data->reset);
> +	if (ret) {
> +		dev_err(&pdev->dev, "reset deassert failed: %d\n", ret);
> +		goto err_disable_ths;
> +	}

Having runtime_pm support would be great.


> +	sun8i_ths_h3_init(data);
> +
> +	data->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, 0, data,
> +						    &sun8i_ths_thermal_ops);
> +	if (IS_ERR(data->tzd)) {
> +		ret =3D PTR_ERR(data->tzd);
> +		dev_err(&pdev->dev, "failed to register thermal zone: %d\n",
> +				ret);
> +		goto err_assert_reset;
> +	}

You reference data->tzd in your interrupt handler, and the interrupts
have been activated before initializing that field. That is likely to
cause a kernel crash when you receive an interrupt between your
request_irq and that call.

> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +
> +err_assert_reset:
> +	reset_control_assert(data->reset);
> +err_disable_ths:
> +	clk_disable_unprepare(data->clk);
> +err_disable_bus:
> +	clk_disable_unprepare(data->busclk);
> +	return ret;
> +}
> +
> +static int sun8i_ths_remove(struct platform_device *pdev)
> +{
> +	struct sun8i_ths_data *data =3D platform_get_drvdata(pdev);
> +
> +	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> +	reset_control_assert(data->reset);
> +	clk_disable_unprepare(data->clk);
> +	clk_disable_unprepare(data->busclk);
> +	return 0;
> +}
> +
> +static const struct of_device_id sun8i_ths_id_table[] =3D {
> +	{ .compatible =3D "allwinner,sun8i-h3-ths", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_ths_id_table);
> +
> +static struct platform_driver sun8i_ths_driver =3D {
> +	.probe =3D sun8i_ths_probe,
> +	.remove =3D sun8i_ths_remove,
> +	.driver =3D {
> +		.name =3D "sun8i_ths",
> +		.of_match_table =3D sun8i_ths_id_table,
> +	},
> +};
> +
> +module_platform_driver(sun8i_ths_driver);
> +
> +MODULE_AUTHOR("Ond=C5=99ej Jirman <megous@megous.com>");
> +MODULE_DESCRIPTION("Thermal sensor driver for Allwinner H3 SoC");
> +MODULE_LICENSE("GPL v2");

Looks quite good otherwise. It looks very similar to the older
touchscreen driver (without the touchscreen part).

Have you tried to merge the two?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXbi50AAoJEBx+YmzsjxAg1skQAIGPMl41DgxOK+6A5cesGrzL
++T+4zT8+p8FbqMuLalVuAprvZnZVlTYxqx8yldopghMGszHZ74R7Nf90lYv7Rl9
1UzT0/qYpzyHjQzRPAvzF4XgXZjWC3nGzXcPL6JwbGUpuS+NPpa+8Nppk4gW5YjI
y407F7do+0iffLVz9LqJXl2AeXdfZxmxkWfMKevECaiHWA8pGc+NXoqowrwdAVFW
kyk8vZMCjj8iLUCLQ6uwEBswuVl+dxCubuerZGBN9vcjJTrsF6ZrzaOycDvKUJuB
Y9MOz8bPr85s8FnD9hxIqLxcZzJP5S3Db1uTuxs//iRKs0N2RsfLHJn1qcT046O2
sYB04m8W57flKwP8MgcV8+imt9vnpT34qp0oevW4LrNIo1XGOxrfLKKjQsGr3hm4
cviJLNFSAX7GiEYJkI+Dqn8q9iUVLwVEl/ym44quIa/+1OqNnaSDX0IstkNFiiLj
tLgnDik2p3PAWtC0pGSG3NrX7x4FsqRucbD4QDHbWTaanEc8+Hhlmyyni0n0Wfer
9NMZf32wwGUM0UtUY0kUhb6G3t6d7uCX1YAYovqjlvXfRZA9mmHz+lYcdUXIgJJo
JGLmGrVvfEcoibkMZvSj5wtBjo7F45rhA442gJZT2+6rhJgaG6v8dTTLjM7IR5nT
PSxYizGotF9muR5CVaU1
=19jo
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
