From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 03/14] thermal: Add support for sun8i THS on Allwinner H3
Date: Fri, 24 Jun 2016 11:09:00 +0800
Message-ID: <CAGb2v66sFfbD0rTaeeR9CBZFaXLiCKV4DrqKi4Yhc3+u2q+UMw@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com> <20160623192104.18720-4-megous@megous.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:48186 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbcFXDJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 23:09:24 -0400
In-Reply-To: <20160623192104.18720-4-megous@megous.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: megous@megous.com
Cc: dev <dev@linux-sunxi.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, open list <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

Hi,

On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
> From: Ondrej Jirman <megous@megous.com>
>

The subject could read:

  thermal: sun8i_ths: Add support for the thermal sensor on Allwinner H=
3

> This patch adds support for the sun8i thermal sensor on
> Allwinner H3 SoC.
>
> Signed-off-by: Ond=C5=99ej Jirman <megous@megous.com>
> ---
>  drivers/thermal/Kconfig     |   7 ++
>  drivers/thermal/Makefile    |   1 +
>  drivers/thermal/sun8i_ths.c | 295 ++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 drivers/thermal/sun8i_ths.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2d702ca..3de0f8d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -351,6 +351,13 @@ config MTK_THERMAL
>           Enable this option if you want to have support for thermal =
management
>           controller present in Mediatek SoCs
>
> +config SUN8I_THS
> +       tristate "sun8i THS driver"

Explain THS.

> +       depends on MACH_SUN8I
> +       depends on OF
> +       help
> +         Enable this to support thermal reporting on some newer Allw=
inner SoCs.
> +
>  menu "Texas Instruments thermal drivers"
>  depends on ARCH_HAS_BANDGAP || COMPILE_TEST
>  depends on HAS_IOMEM
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 10b07c1..7261ee8 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -51,3 +51,4 @@ obj-$(CONFIG_TEGRA_SOCTHERM)  +=3D tegra/
>  obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)      +=3D mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)      +=3D thermal-generic-adc.o
> +obj-$(CONFIG_SUN8I_THS)                +=3D sun8i_ths.o
> diff --git a/drivers/thermal/sun8i_ths.c b/drivers/thermal/sun8i_ths.=
c
> new file mode 100644
> index 0000000..618ccc3
> --- /dev/null
> +++ b/drivers/thermal/sun8i_ths.c
> @@ -0,0 +1,295 @@
> +/*
> + * sun8i THS driver

Explain THS.

> + *
> + * Copyright (C) 2016 Ond=C5=99ej Jirman
> + * Based on the work of Josef Gajdusek <atx@atx.name>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
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
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/printk.h>
> +
> +#define THS_H3_CTRL0           0x00
> +#define THS_H3_CTRL2           0x40
> +#define THS_H3_INT_CTRL                0x44
> +#define THS_H3_STAT            0x48
> +#define THS_H3_FILTER          0x70
> +#define THS_H3_CDATA           0x74
> +#define THS_H3_DATA            0x80
> +
> +#define THS_H3_CTRL0_SENSOR_ACQ0_OFFS   0
> +#define THS_H3_CTRL0_SENSOR_ACQ0(x) \
> +        ((x) << THS_H3_CTRL0_SENSOR_ACQ0_OFFS)
> +#define THS_H3_CTRL2_SENSE_EN_OFFS      0
> +#define THS_H3_CTRL2_SENSE_EN \
> +        BIT(THS_H3_CTRL2_SENSE_EN_OFFS)
> +#define THS_H3_CTRL2_SENSOR_ACQ1_OFFS   16
> +#define THS_H3_CTRL2_SENSOR_ACQ1(x) \
> +        ((x) << THS_H3_CTRL2_SENSOR_ACQ1_OFFS)
> +
> +#define THS_H3_INT_CTRL_DATA_IRQ_EN_OFFS        8
> +#define THS_H3_INT_CTRL_DATA_IRQ_EN \
> +               BIT(THS_H3_INT_CTRL_DATA_IRQ_EN_OFFS)
> +#define THS_H3_INT_CTRL_THERMAL_PER_OFFS        12
> +#define THS_H3_INT_CTRL_THERMAL_PER(x) \
> +               ((x) << THS_H3_INT_CTRL_THERMAL_PER_OFFS)
> +
> +#define THS_H3_STAT_DATA_IRQ_STS_OFFS   8
> +#define THS_H3_STAT_DATA_IRQ_STS \
> +        BIT(THS_H3_STAT_DATA_IRQ_STS_OFFS)
> +
> +#define THS_H3_FILTER_TYPE_OFFS 0
> +#define THS_H3_FILTER_TYPE(x) \
> +        ((x) << THS_H3_FILTER_TYPE_OFFS)
> +#define THS_H3_FILTER_EN_OFFS   2
> +#define THS_H3_FILTER_EN \
> +        BIT(THS_H3_FILTER_EN_OFFS)

Is it really necessary to split the lines of all the macros?
It makes it harder to find and read stuff.

You're also not using any of the *_OFFS macros in the actual code,
so just drop them.

> +
> +#define THS_H3_CLK_IN 40000000  /* Hz */
> +#define THS_H3_DATA_PERIOD 330  /* ms */
> +
> +#define THS_H3_FILTER_TYPE_VALUE               2  /* average over 2^=
(n+1) samples */
> +#define THS_H3_FILTER_DIV                      (1 << (THS_H3_FILTER_=
TYPE_VALUE + 1))
> +#define THS_H3_INT_CTRL_THERMAL_PER_VALUE \
> +       (THS_H3_DATA_PERIOD * (THS_H3_CLK_IN / 1000) / THS_H3_FILTER_=
DIV / 4096 - 1)
> +#define THS_H3_CTRL0_SENSOR_ACQ0_VALUE         0x3f /* 16us */
> +#define THS_H3_CTRL2_SENSOR_ACQ1_VALUE         0x3f
> +
> +struct sun8i_ths_data {
> +       struct reset_control *reset;
> +       struct clk *clk;
> +       struct clk *busclk;
> +       void __iomem *regs;
> +       struct nvmem_cell *calcell;
> +       struct platform_device *pdev;
> +       struct thermal_zone_device *tzd;
> +       u32 temp;
> +};
> +
> +static int sun8i_ths_get_temp(void *_data, int *out)
> +{
> +       struct sun8i_ths_data *data =3D _data;
> +
> +       if (data->temp =3D=3D 0)
> +               return -EINVAL;
> +
> +       /* Formula and parameters from the Allwinner 3.4 kernel */
> +       *out =3D 217000 - (data->temp * 1000000) / 8253;
> +       return 0;
> +}
> +
> +static irqreturn_t sun8i_ths_irq_thread(int irq, void *_data)
> +{
> +       struct sun8i_ths_data *data =3D _data;
> +
> +       writel(THS_H3_STAT_DATA_IRQ_STS, data->regs + THS_H3_STAT);
> +
> +       data->temp =3D readl(data->regs + THS_H3_DATA);
> +       if (data->temp)
> +               thermal_zone_device_update(data->tzd);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int sun8i_ths_h3_init(struct platform_device *pdev,
> +                            struct sun8i_ths_data *data)
> +{
> +       int ret;
> +       size_t callen;
> +       s32 *caldata;
> +
> +       data->busclk =3D devm_clk_get(&pdev->dev, "ahb");
> +       if (IS_ERR(data->busclk)) {
> +               ret =3D PTR_ERR(data->busclk);
> +               dev_err(&pdev->dev, "failed to get ahb clk: %d\n", re=
t);
> +               return ret;
> +       }
> +
> +       data->clk =3D devm_clk_get(&pdev->dev, "ths");
> +       if (IS_ERR(data->clk)) {
> +               ret =3D PTR_ERR(data->clk);
> +               dev_err(&pdev->dev, "failed to get ths clk: %d\n", re=
t);
> +               return ret;
> +       }
> +
> +       data->reset =3D devm_reset_control_get(&pdev->dev, "ahb");

IIRC with the new shared reset control stuff merged, you are supposed
to specify whether you want a shared or exclusive one when you ask for
it.

Also you seem to be requesting some resources here, while others
directly in the probe function. Could you put them in the same place?
Maybe requesting all resources in the probe function, and this init
function turns everything on?

> +       if (IS_ERR(data->reset)) {
> +               ret =3D PTR_ERR(data->reset);
> +               dev_err(&pdev->dev, "failed to get reset: %d\n", ret)=
;
> +               return ret;
> +       }
> +
> +       if (data->calcell) {
> +               caldata =3D nvmem_cell_read(data->calcell, &callen);
> +               if (IS_ERR(caldata))
> +                       return PTR_ERR(caldata);

Check the returned length in case of a bogus cell?

> +
> +               writel(be32_to_cpu(*caldata), data->regs + THS_H3_CDA=
TA);
> +               kfree(caldata);
> +       }
> +
> +       ret =3D clk_prepare_enable(data->busclk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable bus clk: %d\n",=
 ret);
> +               return ret;
> +       }
> +
> +       ret =3D clk_prepare_enable(data->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable ths clk: %d\n",=
 ret);
> +               goto err_disable_bus;
> +       }
> +
> +       ret =3D reset_control_deassert(data->reset);
> +       if (ret) {
> +               dev_err(&pdev->dev, "reset deassert failed: %d\n", re=
t);
> +               goto err_disable_ths;
> +       }
> +
> +       ret =3D clk_set_rate(data->clk, THS_H3_CLK_IN);
> +       if (ret)
> +               goto err_disable_ths;
> +
> +       writel(THS_H3_CTRL0_SENSOR_ACQ0(THS_H3_CTRL0_SENSOR_ACQ0_VALU=
E),
> +               data->regs + THS_H3_CTRL0);
> +       writel(THS_H3_INT_CTRL_THERMAL_PER(THS_H3_INT_CTRL_THERMAL_PE=
R_VALUE) |
> +               THS_H3_INT_CTRL_DATA_IRQ_EN,
> +               data->regs + THS_H3_INT_CTRL);

This enables the interrupts. You already requested IRQs from the kernel=
, which
means as soon as this line executes, interrupts will start firing.

You should do this last, after you've finishing all the configuration,
i.e. move this after the next writel calls.

> +       writel(THS_H3_FILTER_EN | THS_H3_FILTER_TYPE(THS_H3_FILTER_TY=
PE_VALUE),
> +               data->regs + THS_H3_FILTER);
> +       writel(THS_H3_CTRL2_SENSOR_ACQ1(THS_H3_CTRL2_SENSOR_ACQ1_VALU=
E) |
> +               THS_H3_CTRL2_SENSE_EN,
> +               data->regs + THS_H3_CTRL2);
> +
> +       return 0;
> +
> +err_disable_ths:
> +       clk_disable_unprepare(data->clk);
> +err_disable_bus:
> +       clk_disable_unprepare(data->busclk);
> +
> +       return ret;
> +}
> +
> +static void sun8i_ths_h3_deinit(struct sun8i_ths_data *data)
> +{
> +       reset_control_assert(data->reset);
> +       clk_disable_unprepare(data->clk);
> +       clk_disable_unprepare(data->busclk);
> +}
> +
> +static const struct thermal_zone_of_device_ops sun8i_ths_thermal_ops=
 =3D {
> +       .get_temp =3D sun8i_ths_get_temp,
> +};
> +
> +static const struct of_device_id sun8i_ths_id_table[] =3D {
> +       {
> +               .compatible =3D "allwinner,sun8i-h3-ths",
> +       },

Nit. You could fit it in one line.

> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_ths_id_table);
> +
> +static int sun8i_ths_probe(struct platform_device *pdev)
> +{
> +       struct sun8i_ths_data *data;
> +       struct resource *res;
> +       int ret;
> +       int irq;
> +
> +       data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->pdev =3D pdev;
> +
> +       data->calcell =3D devm_nvmem_cell_get(&pdev->dev, "calibratio=
n");
> +       if (IS_ERR(data->calcell)) {
> +               if (PTR_ERR(data->calcell) =3D=3D -EPROBE_DEFER)
> +                       return PTR_ERR(data->calcell);
> +
> +               data->calcell =3D NULL; /* No calibration data */
> +       }
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       data->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(data->regs)) {
> +               ret =3D PTR_ERR(data->regs);
> +               dev_err(&pdev->dev, "failed to ioremap THS registers:=
 %d\n", ret);
> +               return ret;
> +       }
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
> +               return irq;
> +       }
> +
> +       ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +                                       sun8i_ths_irq_thread, IRQF_ON=
ESHOT,
> +                                       dev_name(&pdev->dev), data);

Is a threaded irq required? The thermal core seems to use atomics,
so this shouldn't be necessary.

> +       if (ret)
> +               return ret;
> +
> +       ret =3D sun8i_ths_h3_init(pdev, data);
> +       if (ret)
> +               return ret;
> +
> +       data->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, 0, =
data,
> +                                                   &sun8i_ths_therma=
l_ops);
> +       if (IS_ERR(data->tzd)) {
> +               ret =3D PTR_ERR(data->tzd);
> +               dev_err(&pdev->dev, "failed to register thermal zone:=
 %d\n",
> +                               ret);
> +               goto err_deinit;
> +       }
> +
> +       platform_set_drvdata(pdev, data);
> +       return 0;
> +
> +err_deinit:
> +       sun8i_ths_h3_deinit(data);
> +       return ret;
> +}
> +
> +static int sun8i_ths_remove(struct platform_device *pdev)
> +{
> +       struct sun8i_ths_data *data =3D platform_get_drvdata(pdev);
> +
> +       thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> +       sun8i_ths_h3_deinit(data);
> +       return 0;
> +}
> +
> +static struct platform_driver sun8i_ths_driver =3D {
> +       .probe =3D sun8i_ths_probe,
> +       .remove =3D sun8i_ths_remove,
> +       .driver =3D {
> +               .name =3D "sun8i_ths",
> +               .of_match_table =3D sun8i_ths_id_table,
> +       },
> +};
> +
> +module_platform_driver(sun8i_ths_driver);
> +
> +MODULE_AUTHOR("Ond=C5=99ej Jirman <megous@megous.com>");
> +MODULE_DESCRIPTION("sun8i THS driver");

Explain THS.

Regards
ChenYu

> +MODULE_LICENSE("GPL v2");
> --
> 2.9.0
>
