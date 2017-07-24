From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 02/10] regulator: add support for SY8106A regulator
Date: Mon, 24 Jul 2017 11:03:24 +0800
Message-ID: <CAGb2v640bB27M_Xd4r-oQ=acgfpHEwoV2tSk3vH0VZc7R-de6w@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io> <20170723102749.17323-3-icenowy@aosc.io>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBFOH2XFQKGQEKZVT3HA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170723102749.17323-3-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
> From: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
>
> SY8106A is an I2C attached single output regulator made by Silergy Corp,
> which is used on several Allwinner H3/H5 SBCs to control the power
> supply of the ARM cores.
>
> Add a driver for it.
>
> Signed-off-by: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
> [Icenowy: Change commit message]
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  drivers/regulator/Kconfig             |   8 +-
>  drivers/regulator/Makefile            |   2 +-
>  drivers/regulator/sy8106a-regulator.c | 163 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 171 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/regulator/sy8106a-regulator.c
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 99b9362331b5..1efa73e18d07 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -764,6 +764,13 @@ config REGULATOR_STW481X_VMMC
>           This driver supports the internal VMMC regulator in the STw481x
>           PMIC chips.
>
> +config REGULATOR_SY8106A
> +       tristate "Silergy SY8106A regulator"
> +       depends on I2C && (OF || COMPILE_TEST)
> +       select REGMAP_I2C
> +       help
> +         This driver supports SY8106A single output regulator.
> +
>  config REGULATOR_TPS51632
>         tristate "TI TPS51632 Power Regulator"
>         depends on I2C
> @@ -938,4 +945,3 @@ config REGULATOR_WM8994
>           WM8994 CODEC.
>
>  endif
> -
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 95b1e86ae692..f5120252f86a 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_REGULATOR_S2MPS11) +=3D s2mps11.o
>  obj-$(CONFIG_REGULATOR_S5M8767) +=3D s5m8767.o
>  obj-$(CONFIG_REGULATOR_SKY81452) +=3D sky81452-regulator.o
>  obj-$(CONFIG_REGULATOR_STW481X_VMMC) +=3D stw481x-vmmc.o
> +obj-$(CONFIG_REGULATOR_SY8106A) +=3D sy8106a-regulator.o
>  obj-$(CONFIG_REGULATOR_TI_ABB) +=3D ti-abb-regulator.o
>  obj-$(CONFIG_REGULATOR_TPS6105X) +=3D tps6105x-regulator.o
>  obj-$(CONFIG_REGULATOR_TPS62360) +=3D tps62360-regulator.o
> @@ -120,5 +121,4 @@ obj-$(CONFIG_REGULATOR_WM8350) +=3D wm8350-regulator.=
o
>  obj-$(CONFIG_REGULATOR_WM8400) +=3D wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8994) +=3D wm8994-regulator.o
>
> -
>  ccflags-$(CONFIG_REGULATOR_DEBUG) +=3D -DDEBUG
> diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy=
8106a-regulator.c
> new file mode 100644
> index 000000000000..1df889f68b3d
> --- /dev/null
> +++ b/drivers/regulator/sy8106a-regulator.c
> @@ -0,0 +1,163 @@
> +/*
> + * sy8106a-regulator.c - Regulator device driver for SY8106A
> + *
> + * Copyright (C) 2016 Ond=C5=99ej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Library General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Library General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#define SY8106A_REG_VOUT1_SEL          0x01
> +#define SY8106A_REG_VOUT_COM           0x02
> +#define SY8106A_REG_VOUT1_SEL_MASK     0x7f
> +#define SY8106A_DISABLE_REG            BIT(0)
> +#define SY8106A_GO_BIT                 BIT(7)
> +
> +struct sy8106a {
> +       struct regulator_dev *rdev;
> +       struct regmap *regmap;
> +};
> +
> +static const struct regmap_config sy8106a_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +};
> +
> +static int sy8106a_set_voltage_sel(struct regulator_dev *rdev, unsigned =
int sel)
> +{
> +       /* We use our set_voltage_sel in order to avoid unnecessary I2C
> +        * chatter, because the regulator_get_voltage_sel_regmap using
> +        * apply_bit would perform 4 unnecessary transfers instead of one=
,
> +        * increasing the chance of error.
> +        */
> +       return regmap_write(rdev->regmap, rdev->desc->vsel_reg,
> +                           sel | SY8106A_GO_BIT);

There should also be an explanation of what the "go bit" does.
In this case it enables control of the voltage over I2C.

> +}
> +
> +static const struct regulator_ops sy8106a_ops =3D {
> +       .is_enabled =3D regulator_is_enabled_regmap,
> +       .set_voltage_sel =3D sy8106a_set_voltage_sel,
> +       .set_voltage_time_sel =3D regulator_set_voltage_time_sel,
> +       .get_voltage_sel =3D regulator_get_voltage_sel_regmap,
> +       .list_voltage =3D regulator_list_voltage_linear,

No enable/disable ops?

> +};
> +
> +/* Default limits measured in millivolts and milliamps */
> +#define SY8106A_MIN_MV         680
> +#define SY8106A_MAX_MV         1950
> +#define SY8106A_STEP_MV                10
> +
> +static const struct regulator_desc sy8106a_reg =3D {
> +       .name =3D "SY8106A",
> +       .id =3D 0,
> +       .ops =3D &sy8106a_ops,
> +       .type =3D REGULATOR_VOLTAGE,
> +       .n_voltages =3D ((SY8106A_MAX_MV - SY8106A_MIN_MV) / SY8106A_STEP=
_MV) + 1,
> +       .min_uV =3D (SY8106A_MIN_MV * 1000),
> +       .uV_step =3D (SY8106A_STEP_MV * 1000),
> +       .vsel_reg =3D SY8106A_REG_VOUT1_SEL,
> +       .vsel_mask =3D SY8106A_REG_VOUT1_SEL_MASK,
> +       .enable_reg =3D SY8106A_REG_VOUT_COM,
> +       .enable_mask =3D SY8106A_DISABLE_REG,
> +       .disable_val =3D SY8106A_DISABLE_REG,
> +       .enable_is_inverted =3D 1,

As the regulator core helpers currently are, there is no way to disable
this regulator. regulator_disable_regmap looks like:

        if (rdev->desc->enable_is_inverted) {
                val =3D rdev->desc->enable_val;
                if (!val)
                        val =3D rdev->desc->enable_mask;
        } else {
                val =3D rdev->desc->disable_val;
        }

        return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
                                  rdev->desc->enable_mask, val);

Note the fallback to enable_mask if enable_val is not set. The enable
helper has a similar structure. This regulator uses an enable value
of 0, and disable value of 1, it is impossible to get it right. As
it is now, it doesn't really make sense to me.

The code was introduced in ca5d1b3524b4 ("regulator: helpers: Modify
helpers enabling multi-bit control"). I wonder if it was an unintended
consequence of the change? (original author CC-ed)

> +       .owner =3D THIS_MODULE,
> +};
> +
> +/*
> + * I2C driver interface functions
> + */
> +static int sy8106a_i2c_probe(struct i2c_client *i2c,
> +                           const struct i2c_device_id *id)
> +{
> +       struct sy8106a *chip;
> +       struct device *dev =3D &i2c->dev;
> +       struct regulator_dev *rdev =3D NULL;
> +       struct regulator_config config =3D { };
> +       unsigned int selector;
> +       int error;
> +
> +       chip =3D devm_kzalloc(&i2c->dev, sizeof(struct sy8106a), GFP_KERN=
EL);
> +       if (!chip)
> +               return -ENOMEM;
> +
> +       chip->regmap =3D devm_regmap_init_i2c(i2c, &sy8106a_regmap_config=
);
> +       if (IS_ERR(chip->regmap)) {
> +               error =3D PTR_ERR(chip->regmap);
> +               dev_err(&i2c->dev, "Failed to allocate register map: %d\n=
",
> +                       error);
> +               return error;
> +       }
> +
> +       config.dev =3D &i2c->dev;
> +       config.regmap =3D chip->regmap;
> +       config.driver_data =3D chip;
> +
> +       config.of_node =3D dev->of_node;
> +       config.init_data =3D of_get_regulator_init_data(dev, dev->of_node=
,
> +                                                     &sy8106a_reg);
> +
> +       if (!config.init_data)
> +               return -ENOMEM;
> +
> +       /* Probe regulator */
> +       error =3D regmap_read(chip->regmap, SY8106A_REG_VOUT1_SEL, &selec=
tor);
> +       if (error) {
> +               dev_err(&i2c->dev, "Failed to read voltage at probe time:=
 %d\n", error);
> +               return error;
> +       }
> +
> +       rdev =3D devm_regulator_register(&i2c->dev, &sy8106a_reg, &config=
);
> +       if (IS_ERR(rdev)) {
> +               error =3D PTR_ERR(rdev);
> +               dev_err(&i2c->dev, "Failed to register SY8106A regulator:=
 %d\n", error);
> +               return error;
> +       }
> +
> +       chip->rdev =3D rdev;
> +
> +       i2c_set_clientdata(i2c, chip);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sy8106a_i2c_of_match[] =3D {
> +       { .compatible =3D "silergy,sy8106a" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, sy8106a_i2c_of_match);
> +
> +static const struct i2c_device_id sy8106a_i2c_id[] =3D {
> +       { "sy8106a", 0 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id);
> +
> +static struct i2c_driver sy8106a_regulator_driver =3D {
> +       .driver =3D {
> +               .name =3D "sy8106a",
> +               .of_match_table =3D of_match_ptr(sy8106a_i2c_of_match),
> +       },
> +       .probe =3D sy8106a_i2c_probe,
> +       .id_table =3D sy8106a_i2c_id,
> +};
> +
> +module_i2c_driver(sy8106a_regulator_driver);
> +
> +MODULE_AUTHOR("Ond=C5=99ej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("Regulator device driver for Silergy SY8106A");
> +MODULE_LICENSE("GPL v2");

This should be "GPL", to match what the license at the very top says.

Regards
ChenYu

> --
> 2.13.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
