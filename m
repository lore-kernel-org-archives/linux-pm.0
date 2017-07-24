From: icenowy@aosc.io
Subject: Re: [linux-sunxi] [PATCH 02/10] regulator: add support for SY8106A
 regulator
Date: Mon, 24 Jul 2017 11:38:53 +0800
Message-ID: <dce1ffc444edd9de64326e85152ee555@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-3-icenowy@aosc.io>
 <CAGb2v640bB27M_Xd4r-oQ=acgfpHEwoV2tSk3vH0VZc7R-de6w@mail.gmail.com>
 <a40cabec7eb7f4ae7bb35c4e3e6d3795@aosc.io>
 <CAGb2v65k3V74MepvFnOF7DRdhyOsSR+6Bgh5Vaf4U2bJ=9=qjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:55253 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbdGXDi4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Jul 2017 23:38:56 -0400
In-Reply-To: <CAGb2v65k3V74MepvFnOF7DRdhyOsSR+6Bgh5Vaf4U2bJ=9=qjg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ondrej Jirman <megous@megous.com>, devicetree <devicetree@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

在 2017-07-24 11:33，Chen-Yu Tsai 写道：
> On Mon, Jul 24, 2017 at 11:18 AM,  <icenowy@aosc.io> wrote:
>> 在 2017-07-24 11:03，Chen-Yu Tsai 写道：
>>> 
>>> On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> 
>>> wrote:
>>>> 
>>>> From: Ondrej Jirman <megous@megous.com>
>>>> 
>>>> SY8106A is an I2C attached single output regulator made by Silergy 
>>>> Corp,
>>>> which is used on several Allwinner H3/H5 SBCs to control the power
>>>> supply of the ARM cores.
>>>> 
>>>> Add a driver for it.
>>>> 
>>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>>> [Icenowy: Change commit message]
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> ---
>>>>  drivers/regulator/Kconfig             |   8 +-
>>>>  drivers/regulator/Makefile            |   2 +-
>>>>  drivers/regulator/sy8106a-regulator.c | 163
>>>> ++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 171 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/regulator/sy8106a-regulator.c
>>>> 
>>>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>>>> index 99b9362331b5..1efa73e18d07 100644
>>>> --- a/drivers/regulator/Kconfig
>>>> +++ b/drivers/regulator/Kconfig
>>>> @@ -764,6 +764,13 @@ config REGULATOR_STW481X_VMMC
>>>>           This driver supports the internal VMMC regulator in the 
>>>> STw481x
>>>>           PMIC chips.
>>>> 
>>>> +config REGULATOR_SY8106A
>>>> +       tristate "Silergy SY8106A regulator"
>>>> +       depends on I2C && (OF || COMPILE_TEST)
>>>> +       select REGMAP_I2C
>>>> +       help
>>>> +         This driver supports SY8106A single output regulator.
>>>> +
>>>>  config REGULATOR_TPS51632
>>>>         tristate "TI TPS51632 Power Regulator"
>>>>         depends on I2C
>>>> @@ -938,4 +945,3 @@ config REGULATOR_WM8994
>>>>           WM8994 CODEC.
>>>> 
>>>>  endif
>>>> -
>>>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>>>> index 95b1e86ae692..f5120252f86a 100644
>>>> --- a/drivers/regulator/Makefile
>>>> +++ b/drivers/regulator/Makefile
>>>> @@ -95,6 +95,7 @@ obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
>>>>  obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
>>>>  obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
>>>>  obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
>>>> +obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
>>>>  obj-$(CONFIG_REGULATOR_TI_ABB) += ti-abb-regulator.o
>>>>  obj-$(CONFIG_REGULATOR_TPS6105X) += tps6105x-regulator.o
>>>>  obj-$(CONFIG_REGULATOR_TPS62360) += tps62360-regulator.o
>>>> @@ -120,5 +121,4 @@ obj-$(CONFIG_REGULATOR_WM8350) += 
>>>> wm8350-regulator.o
>>>>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>>>>  obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
>>>> 
>>>> -
>>>>  ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
>>>> diff --git a/drivers/regulator/sy8106a-regulator.c
>>>> b/drivers/regulator/sy8106a-regulator.c
>>>> new file mode 100644
>>>> index 000000000000..1df889f68b3d
>>>> --- /dev/null
>>>> +++ b/drivers/regulator/sy8106a-regulator.c
>>>> @@ -0,0 +1,163 @@
>>>> +/*
>>>> + * sy8106a-regulator.c - Regulator device driver for SY8106A
>>>> + *
>>>> + * Copyright (C) 2016 Ondřej Jirman <megous@megous.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Library General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
>>>> GNU
>>>> + * Library General Public License for more details.
>>>> + */
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/regulator/driver.h>
>>>> +#include <linux/regulator/of_regulator.h>
>>>> +
>>>> +#define SY8106A_REG_VOUT1_SEL          0x01
>>>> +#define SY8106A_REG_VOUT_COM           0x02
>>>> +#define SY8106A_REG_VOUT1_SEL_MASK     0x7f
>>>> +#define SY8106A_DISABLE_REG            BIT(0)
>>>> +#define SY8106A_GO_BIT                 BIT(7)
>>>> +
>>>> +struct sy8106a {
>>>> +       struct regulator_dev *rdev;
>>>> +       struct regmap *regmap;
>>>> +};
>>>> +
>>>> +static const struct regmap_config sy8106a_regmap_config = {
>>>> +       .reg_bits = 8,
>>>> +       .val_bits = 8,
>>>> +};
>>>> +
>>>> +static int sy8106a_set_voltage_sel(struct regulator_dev *rdev, 
>>>> unsigned
>>>> int sel)
>>>> +{
>>>> +       /* We use our set_voltage_sel in order to avoid unnecessary 
>>>> I2C
>>>> +        * chatter, because the regulator_get_voltage_sel_regmap 
>>>> using
>>>> +        * apply_bit would perform 4 unnecessary transfers instead 
>>>> of
>>>> one,
>>>> +        * increasing the chance of error.
>>>> +        */
>>>> +       return regmap_write(rdev->regmap, rdev->desc->vsel_reg,
>>>> +                           sel | SY8106A_GO_BIT);
>>> 
>>> 
>>> There should also be an explanation of what the "go bit" does.
>>> In this case it enables control of the voltage over I2C.
>>> 
>>>> +}
>>>> +
>>>> +static const struct regulator_ops sy8106a_ops = {
>>>> +       .is_enabled = regulator_is_enabled_regmap,
>>>> +       .set_voltage_sel = sy8106a_set_voltage_sel,
>>>> +       .set_voltage_time_sel = regulator_set_voltage_time_sel,
>>>> +       .get_voltage_sel = regulator_get_voltage_sel_regmap,
>>>> +       .list_voltage = regulator_list_voltage_linear,
>>> 
>>> 
>>> No enable/disable ops?
>>> 
>>>> +};
>>>> +
>>>> +/* Default limits measured in millivolts and milliamps */
>>>> +#define SY8106A_MIN_MV         680
>>>> +#define SY8106A_MAX_MV         1950
>>>> +#define SY8106A_STEP_MV                10
>>>> +
>>>> +static const struct regulator_desc sy8106a_reg = {
>>>> +       .name = "SY8106A",
>>>> +       .id = 0,
>>>> +       .ops = &sy8106a_ops,
>>>> +       .type = REGULATOR_VOLTAGE,
>>>> +       .n_voltages = ((SY8106A_MAX_MV - SY8106A_MIN_MV) /
>>>> SY8106A_STEP_MV) + 1,
>>>> +       .min_uV = (SY8106A_MIN_MV * 1000),
>>>> +       .uV_step = (SY8106A_STEP_MV * 1000),
>>>> +       .vsel_reg = SY8106A_REG_VOUT1_SEL,
>>>> +       .vsel_mask = SY8106A_REG_VOUT1_SEL_MASK,
>>>> +       .enable_reg = SY8106A_REG_VOUT_COM,
>>>> +       .enable_mask = SY8106A_DISABLE_REG,
>>>> +       .disable_val = SY8106A_DISABLE_REG,
>>>> +       .enable_is_inverted = 1,
>>> 
>>> 
>>> As the regulator core helpers currently are, there is no way to 
>>> disable
>>> this regulator. regulator_disable_regmap looks like:
>> 
>> 
>> By reading the current code, I think removing the disable_val variable 
>> will
>> just make it work -- when enabling, the enable_reg will be set to 
>> disable_val
>> (as enable_is_inverted is 1), and disable_val is defaultly 0; when 
>> disabling,
>> the enable_reg will be set to enable_mask (fallbacked from enable_val, 
>> which
>> is also the default value 0), and the regulator successfully get 
>> disabled.
> 
> (Gmail is wrapping the lines :( )
> 
> enable_mask is set to SY8106A_DISABLE_REG, which equals disable_val 
> here,
> which is not 0. This is correct, as it is the bit mask passed to
> regmap_update_bits. So no, it does not work.

 From my personal understanding of the code, the behavior of 
enable_is_inverted
is that switch the roles of enable_val and disable_val, so if
enable_is_inverted is set, the regulator_disable_regmap function will 
write
enable_val (if it's 0, fallback to enable_mask) to the register, and
regulator_enable_regmap will write disable_val.

Maybe this design is used to ensure enable_val (then fallback to 
enable_mask)
is not 0.

> 
> It seems quite a lot of drivers depend on this fallback behavior 
> though.
> 
> ChenYu
> 
>> 
>>> 
>>>         if (rdev->desc->enable_is_inverted) {
>>>                 val = rdev->desc->enable_val;
>>>                 if (!val)
>>>                         val = rdev->desc->enable_mask;
>>>         } else {
>>>                 val = rdev->desc->disable_val;
>>>         }
>>> 
>>>         return regmap_update_bits(rdev->regmap, 
>>> rdev->desc->enable_reg,
>>>                                   rdev->desc->enable_mask, val);
>>> 
>>> Note the fallback to enable_mask if enable_val is not set. The enable
>>> helper has a similar structure. This regulator uses an enable value
>>> of 0, and disable value of 1, it is impossible to get it right. As
>>> it is now, it doesn't really make sense to me.
>>> 
>>> The code was introduced in ca5d1b3524b4 ("regulator: helpers: Modify
>>> helpers enabling multi-bit control"). I wonder if it was an 
>>> unintended
>>> consequence of the change? (original author CC-ed)
>>> 
>>>> +       .owner = THIS_MODULE,
>>>> +};
>>>> +
>>>> +/*
>>>> + * I2C driver interface functions
>>>> + */
>>>> +static int sy8106a_i2c_probe(struct i2c_client *i2c,
>>>> +                           const struct i2c_device_id *id)
>>>> +{
>>>> +       struct sy8106a *chip;
>>>> +       struct device *dev = &i2c->dev;
>>>> +       struct regulator_dev *rdev = NULL;
>>>> +       struct regulator_config config = { };
>>>> +       unsigned int selector;
>>>> +       int error;
>>>> +
>>>> +       chip = devm_kzalloc(&i2c->dev, sizeof(struct sy8106a),
>>>> GFP_KERNEL);
>>>> +       if (!chip)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       chip->regmap = devm_regmap_init_i2c(i2c, 
>>>> &sy8106a_regmap_config);
>>>> +       if (IS_ERR(chip->regmap)) {
>>>> +               error = PTR_ERR(chip->regmap);
>>>> +               dev_err(&i2c->dev, "Failed to allocate register map:
>>>> %d\n",
>>>> +                       error);
>>>> +               return error;
>>>> +       }
>>>> +
>>>> +       config.dev = &i2c->dev;
>>>> +       config.regmap = chip->regmap;
>>>> +       config.driver_data = chip;
>>>> +
>>>> +       config.of_node = dev->of_node;
>>>> +       config.init_data = of_get_regulator_init_data(dev, 
>>>> dev->of_node,
>>>> +                                                     &sy8106a_reg);
>>>> +
>>>> +       if (!config.init_data)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       /* Probe regulator */
>>>> +       error = regmap_read(chip->regmap, SY8106A_REG_VOUT1_SEL,
>>>> &selector);
>>>> +       if (error) {
>>>> +               dev_err(&i2c->dev, "Failed to read voltage at probe 
>>>> time:
>>>> %d\n", error);
>>>> +               return error;
>>>> +       }
>>>> +
>>>> +       rdev = devm_regulator_register(&i2c->dev, &sy8106a_reg, 
>>>> &config);
>>>> +       if (IS_ERR(rdev)) {
>>>> +               error = PTR_ERR(rdev);
>>>> +               dev_err(&i2c->dev, "Failed to register SY8106A 
>>>> regulator:
>>>> %d\n", error);
>>>> +               return error;
>>>> +       }
>>>> +
>>>> +       chip->rdev = rdev;
>>>> +
>>>> +       i2c_set_clientdata(i2c, chip);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id sy8106a_i2c_of_match[] = {
>>>> +       { .compatible = "silergy,sy8106a" },
>>>> +       { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, sy8106a_i2c_of_match);
>>>> +
>>>> +static const struct i2c_device_id sy8106a_i2c_id[] = {
>>>> +       { "sy8106a", 0 },
>>>> +       { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id);
>>>> +
>>>> +static struct i2c_driver sy8106a_regulator_driver = {
>>>> +       .driver = {
>>>> +               .name = "sy8106a",
>>>> +               .of_match_table = 
>>>> of_match_ptr(sy8106a_i2c_of_match),
>>>> +       },
>>>> +       .probe = sy8106a_i2c_probe,
>>>> +       .id_table = sy8106a_i2c_id,
>>>> +};
>>>> +
>>>> +module_i2c_driver(sy8106a_regulator_driver);
>>>> +
>>>> +MODULE_AUTHOR("Ondřej Jirman <megous@megous.com>");
>>>> +MODULE_DESCRIPTION("Regulator device driver for Silergy SY8106A");
>>>> +MODULE_LICENSE("GPL v2");
>>> 
>>> 
>>> This should be "GPL", to match what the license at the very top says.
>>> 
>>> Regards
>>> ChenYu
>>> 
>>>> --
>>>> 2.13.0
>>>> 
>>>> --
>>>> You received this message because you are subscribed to the Google 
>>>> Groups
>>>> "linux-sunxi" group.
>>>> To unsubscribe from this group and stop receiving emails from it, 
>>>> send an
>>>> email to linux-sunxi+unsubscribe@googlegroups.com.
>>>> For more options, visit https://groups.google.com/d/optout.
>>> 
>>> 
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> 
>> 
>> --
>> You received this message because you are subscribed to the Google 
>> Groups
>> "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send 
>> an
>> email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
