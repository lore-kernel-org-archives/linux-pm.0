From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v2] Add regulator driver for the bq2407x
 family of charger ICs.
Date: Thu, 25 Aug 2011 15:55:29 +0900
Message-ID: <CAJ0PZbQRGCHAQ1HxDmbf6uN8iz3CCcqjOVRtc63Cjn17EXak1A@mail.gmail.com>
References: <201108202224.52250.heiko@sntech.de>
	<201108232215.08788.heiko@sntech.de>
	<20110824090746.GP9232@opensource.wolfsonmicro.com>
	<201108242048.27461.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108242048.27461.heiko@sntech.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: linux-pm@lists.linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 25, 2011 at 3:48 AM, Heiko St=FCbner <heiko@sntech.de> wrote:
> This driver controls a TI bq2407x charger attached via GPIOs.
> The provided current regulator can enable/disable charging and
> select between 100 mA, 500 mA and a machine specific current limit.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>

Hello,

This looks like a bq24022 driver + max-current-mode ("USB standby"
seems not implemented in the driver). Wouldn't it be possible to patch
bq24022 driver so that the bq24022 driver becomes compatible with this
bq2407x?

2407x's EN1 =3D 24022's iset2
2407x's nce =3D 24022's nce

I think you may simply let the driver ignore EN2 (and max-current
mode) if the supplied EN2 in pdata is NULL, then, the driver will be
compatible for both.

Cheers,
MyungJoo

> ---
> Changes since v1:
> =A0- add private struct to keep track of gpio states
> =A0- get max_uA from regulator_init_data
> =A0 (no need to define it twice)
> =A0- disallow setting current limix below 100mA
>
> =A0drivers/regulator/Kconfig =A0 =A0 =A0 =A0 | =A0 =A08 +
> =A0drivers/regulator/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/regulator/bq2407x.c =A0 =A0 =A0 | =A0264 +++++++++++++++++++++=
++++++++++++++++
> =A0include/linux/regulator/bq2407x.h | =A0 35 +++++
> =A04 files changed, 308 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index c7fd2c0..921e271 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -72,6 +72,14 @@ config REGULATOR_BQ24022
> =A0 =A0 =A0 =A0 =A0charging select between 100 mA and 500 mA charging cur=
rent
> =A0 =A0 =A0 =A0 =A0limit.
>
> +config REGULATOR_BQ2407x
> + =A0 =A0 =A0 tristate "TI bq2407x Li-Ion Charger IC"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This driver controls a TI bq2407x Charger attached via
> + =A0 =A0 =A0 =A0 GPIOs. The provided current regulator can enable/disable
> + =A0 =A0 =A0 =A0 charging select between 100 mA, 500 mA and a machine sp=
ecific
> + =A0 =A0 =A0 =A0 charging current limit.
> +
> =A0config REGULATOR_MAX1586
> =A0 =A0 =A0 =A0tristate "Maxim 1586/1587 voltage regulator"
> =A0 =A0 =A0 =A0depends on I2C
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 040d5aa..ce65493 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) +=3D userspa=
ce-consumer.o
>
> =A0obj-$(CONFIG_REGULATOR_AD5398) +=3D ad5398.o
> =A0obj-$(CONFIG_REGULATOR_BQ24022) +=3D bq24022.o
> +obj-$(CONFIG_REGULATOR_BQ2407x) +=3D bq2407x.o
> =A0obj-$(CONFIG_REGULATOR_LP3971) +=3D lp3971.o
> =A0obj-$(CONFIG_REGULATOR_LP3972) +=3D lp3972.o
> =A0obj-$(CONFIG_REGULATOR_MAX1586) +=3D max1586.o
> diff --git a/drivers/regulator/bq2407x.c b/drivers/regulator/bq2407x.c
> new file mode 100644
> index 0000000..a8221d5
> --- /dev/null
> +++ b/drivers/regulator/bq2407x.c
> @@ -0,0 +1,264 @@
> +/*
> + * Support for TI bq2407x USB-friendly
> + * Li-Ion Charger connected via GPIOs.
> + *
> + * Copyright (c) 2011 Heiko Stuebner
> + *
> + * based on the bq24022 driver
> + * Copyright (c) 2008 Philipp Zabel
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/regulator/bq2407x.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +struct bq2407x {
> + =A0 =A0 =A0 struct regulator_dev =A0 =A0*rdev;
> +
> + =A0 =A0 =A0 int gpio_nce;
> + =A0 =A0 =A0 int gpio_en2;
> + =A0 =A0 =A0 int gpio_en1;
> +
> + =A0 =A0 =A0 int state_nce;
> + =A0 =A0 =A0 int state_en2;
> + =A0 =A0 =A0 int state_en1;
> +
> + =A0 =A0 =A0 int max_uA;
> +};
> +
> +
> +static int bq2407x_set_current_limit(struct regulator_dev *rdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 int min_uA, int max_uA)
> +{
> + =A0 =A0 =A0 struct bq2407x *bq =3D rdev_get_drvdata(rdev);
> +
> + =A0 =A0 =A0 if (bq->max_uA && bq->max_uA > 500000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && max_uA >=3D =
bq->max_uA) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "setting current limit to %=
d mA\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->max_uA / 1000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(bq->gpio_en2, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->state_en2 =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(bq->gpio_en1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->state_en1 =3D 0;
> + =A0 =A0 =A0 } else if (max_uA >=3D 500000) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "setting current limit to 5=
00 mA\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(bq->gpio_en2, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->state_en2 =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(bq->gpio_en1, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->state_en1 =3D 1;
> + =A0 =A0 =A0 } else if (max_uA >=3D 100000) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "setting current limit to 1=
00 mA\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(bq->gpio_en2, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->state_en2 =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(bq->gpio_en1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->state_en1 =3D 0;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(rdev_get_dev(rdev), "cannot set cur=
rent limit below 100 mA\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int bq2407x_get_current_limit(struct regulator_dev *rdev)
> +{
> + =A0 =A0 =A0 struct bq2407x *bq =3D rdev_get_drvdata(rdev);
> +
> + =A0 =A0 =A0 if (bq->state_en2 && bq->state_en1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 else if (bq->state_en2 && !bq->state_en1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return bq->max_uA;
> + =A0 =A0 =A0 else if (!bq->state_en2 && bq->state_en1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 500000;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 100000;
> +}
> +
> +static int bq2407x_enable(struct regulator_dev *rdev)
> +{
> + =A0 =A0 =A0 struct bq2407x *bq =3D rdev_get_drvdata(rdev);
> +
> + =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "enabling charger\n");
> +
> + =A0 =A0 =A0 gpio_set_value(bq->gpio_nce, 0);
> + =A0 =A0 =A0 bq->state_nce =3D 0;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int bq2407x_disable(struct regulator_dev *rdev)
> +{
> + =A0 =A0 =A0 struct bq2407x *bq =3D rdev_get_drvdata(rdev);
> +
> + =A0 =A0 =A0 dev_dbg(rdev_get_dev(rdev), "disabling charger\n");
> +
> + =A0 =A0 =A0 gpio_set_value(bq->gpio_nce, 1);
> + =A0 =A0 =A0 bq->state_nce =3D 1;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int bq2407x_is_enabled(struct regulator_dev *rdev)
> +{
> + =A0 =A0 =A0 struct bq2407x *bq =3D rdev_get_drvdata(rdev);
> +
> + =A0 =A0 =A0 return !bq->state_nce;
> +}
> +
> +static struct regulator_ops bq2407x_ops =3D {
> + =A0 =A0 =A0 .set_current_limit =3D bq2407x_set_current_limit,
> + =A0 =A0 =A0 .get_current_limit =3D bq2407x_get_current_limit,
> + =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =A0 =A0=3D bq2407x_enable,
> + =A0 =A0 =A0 .disable =A0 =A0 =A0 =A0 =A0 =3D bq2407x_disable,
> + =A0 =A0 =A0 .is_enabled =A0 =A0 =A0 =A0=3D bq2407x_is_enabled,
> +};
> +
> +static struct regulator_desc bq2407x_desc =3D {
> + =A0 =A0 =A0 .name =A0=3D "bq2407x",
> + =A0 =A0 =A0 .ops =A0 =3D &bq2407x_ops,
> + =A0 =A0 =A0 .type =A0=3D REGULATOR_CURRENT,
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> +};
> +
> +static int __init bq2407x_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct bq2407x_mach_info *pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 struct bq2407x *bq;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (!pdata || !pdata->gpio_nce || !pdata->gpio_en1 || !pdat=
a->gpio_en2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 bq =3D kzalloc(sizeof(struct bq2407x), GFP_KERNEL);
> + =A0 =A0 =A0 if (!bq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot allocate memory=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D gpio_request(pdata->gpio_nce, "ncharge_en");
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "couldn't request nCE G=
PIO: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_nce);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_ce;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D gpio_request(pdata->gpio_en2, "charge_mode_en2");
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "couldn't request EN2 G=
PIO: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_en2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_en2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D gpio_request(pdata->gpio_en1, "charge_mode_en1");
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "couldn't request EN1 G=
PIO: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_en1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_en1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* set initial current to 100mA and disable regulator */
> + =A0 =A0 =A0 ret =3D gpio_direction_output(pdata->gpio_en2, 0);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "couldn't set EN2 GPIO:=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_en1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 bq->gpio_en2 =A0=3D pdata->gpio_en2;
> + =A0 =A0 =A0 bq->state_en2 =3D 0;
> + =A0 =A0 =A0 ret =3D gpio_direction_output(pdata->gpio_en1, 0);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "couldn't set EN1 GPIO:=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_en1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 bq->gpio_en1 =A0=3D pdata->gpio_en1;
> + =A0 =A0 =A0 bq->state_en1 =3D 0;
> + =A0 =A0 =A0 ret =3D gpio_direction_output(pdata->gpio_nce, 1);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "couldn't set nCE GPIO:=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_en1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 bq->gpio_nce =A0=3D pdata->gpio_nce;
> + =A0 =A0 =A0 bq->state_nce =3D 1;
> +
> + =A0 =A0 =A0 /* get maximum current from regulator_init_data */
> + =A0 =A0 =A0 if (pdata->init_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->max_uA =3D pdata->init_data->constraint=
s.max_uA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "maximum current is %d =
mA\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bq->max_uA / 1000);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bq->rdev =3D regulator_register(&bq2407x_desc, &pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pdata->init_data, bq);
> + =A0 =A0 =A0 if (IS_ERR(bq->rdev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "couldn't register regu=
lator\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(bq->rdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, bq);
> + =A0 =A0 =A0 dev_dbg(&pdev->dev, "registered regulator\n");
> +
> + =A0 =A0 =A0 return 0;
> +err_reg:
> + =A0 =A0 =A0 gpio_free(pdata->gpio_en1);
> +err_en1:
> + =A0 =A0 =A0 gpio_free(pdata->gpio_en2);
> +err_en2:
> + =A0 =A0 =A0 gpio_free(pdata->gpio_nce);
> +err_ce:
> + =A0 =A0 =A0 kfree(bq);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit bq2407x_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct bq2407x *bq =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 regulator_unregister(bq->rdev);
> + =A0 =A0 =A0 gpio_free(bq->gpio_en1);
> + =A0 =A0 =A0 gpio_free(bq->gpio_en2);
> + =A0 =A0 =A0 gpio_free(bq->gpio_nce);
> +
> + =A0 =A0 =A0 kfree(bq);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver bq2407x_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "bq2407x",
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .remove =3D __devexit_p(bq2407x_remove),
> +};
> +
> +static int __init bq2407x_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_probe(&bq2407x_driver, bq2407x_probe=
);
> +}
> +
> +static void __exit bq2407x_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&bq2407x_driver);
> +}
> +
> +module_init(bq2407x_init);
> +module_exit(bq2407x_exit);
> +
> +MODULE_AUTHOR("Heiko Stuebner");
> +MODULE_DESCRIPTION("TI bq2407x Li-Ion Charger driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/regulator/bq2407x.h b/include/linux/regulator/=
bq2407x.h
> new file mode 100644
> index 0000000..14d6d93
> --- /dev/null
> +++ b/include/linux/regulator/bq2407x.h
> @@ -0,0 +1,35 @@
> +/*
> + * Support for TI bq2407x 1.5A USB-friendly
> + * Li-Ion Charger connected via GPIOs.
> + *
> + * Copyright (c) 2011 Heiko Stuebner
> + *
> + * based on the bq24022 driver
> + * Copyright (c) 2008 Philipp Zabel
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +struct regulator_init_data;
> +
> +/**
> + * bq2407x_mach_info - platform data for bq2407x
> + * @gpio_nce: GPIO line connected to the nCE pin, used to control chargi=
ng
> + * @gpio_en2: GPIO line connected to the EN2 pin, used to limit charging
> + * @gpio_en1: GPIO line connected to the EN1 pin, used to limit charging
> + * @max_uA: maximum current defined by resistor on ILIM connector
> + * Modes of operation:
> + * EN2 =3D 0, EN1 =3D 0: 100mA
> + * EN2 =3D 0, EN1 =3D 1: 500mA
> + * EN2 =3D 1, EN1 =3D 0: max_current
> + * EN2 =3D 1, EN1 =3D 1: Standby (usb suspend)
> + */
> +struct bq2407x_mach_info {
> + =A0 =A0 =A0 int gpio_nce;
> + =A0 =A0 =A0 int gpio_en2;
> + =A0 =A0 =A0 int gpio_en1;
> + =A0 =A0 =A0 struct regulator_init_data *init_data;
> +};
> --
> tg: (93ee7a9..) topic/drivers/bq2407x (depends on: master)
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>



-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
