From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: Re: [PATCH 3/3] power: supply: Add support MAX1721x battery monitor
Date: Thu, 8 Jun 2017 20:44:35 +0300
Message-ID: <52712c86-9ef9-cfe3-49b3-5ff7db49ad44@rambler.ru>
References: <20170602070629.8210-1-minimumlaw@rambler.ru>
 <20170602070629.8210-4-minimumlaw@rambler.ru>
 <20170608124827.tvgfbrnlaeavpqs7@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan3.mail.rambler.ru ([81.19.78.109]:15127 "EHLO
        huan3.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdFHRoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 13:44:39 -0400
In-Reply-To: <20170608124827.tvgfbrnlaeavpqs7@earth>
Content-Language: ru
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


08.06.17 15:48, Sebastian Reichel wrote:
> On Fri, Jun 02, 2017 at 10:06:29AM +0300, Alex A. Mihaylov wrote:
>> diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supply/max1721x_battery.c
>> new file mode 100644
>> index 0000000000..aa0effec3d
>> --- /dev/null
>> +++ b/drivers/power/supply/max1721x_battery.c
>> @@ -0,0 +1,357 @@
>> +/*
>> + * 1-wire client/driver for the Maxim Semicondactor
>> + * MAX17211/MAX17215 Standalone Fuel Gauge IC
>> + *
>> + * Copyright (C) 2017 OAO Radioavionica
>> + * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/param.h>
> param?
Ok, sorry. This really not need. I remove this in next revision.
>> +#include <linux/pm.h>
>> +#include <linux/regmap.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/idr.h>
>> +
>> +#include "../../w1/w1.h"
> This will conflict with public w1 interface patch
> https://www.spinics.net/lists/kernel/msg2524566.html
>
> This patch should be on top of that patch.
Ok. No problem. I can fix this here. I can fix this in regmap-w1. Just 
tell me which of the patches will be applied first. If the one to which 
you refer, I will resend the patches immediately after it appears at 
least in -rc.
>> +#include "../../w1/slaves/w1_max1721x.h"
> Let's merge those defines into the driver. They
> are not used anywhere else.
Theory, Maxim integrated have MAX17201/MAX17205 with I2C interface. This 
may required for feature i2c driver.
>> +
>> +/* Model Gauge M5 Register Memory Map access */
>> +static const struct regmap_range max1721x_regs_allow[] = {
>> +	/* M5 Model Gauge Algorithm area */
>> +	regmap_reg_range(0x00, 0x23),
>> +	regmap_reg_range(0x27, 0x2F),
>> +	regmap_reg_range(0x32, 0x32),
>> +	regmap_reg_range(0x35, 0x36),
>> +	regmap_reg_range(0x38, 0x3A),
>> +	regmap_reg_range(0x3D, 0x3F),
>> +	regmap_reg_range(0x42, 0x42),
>> +	regmap_reg_range(0x45, 0x46),
>> +	regmap_reg_range(0x4A, 0x4A),
>> +	regmap_reg_range(0x4D, 0x4D),
>> +	regmap_reg_range(0xB0, 0xB0),
>> +	regmap_reg_range(0xB4, 0xB4),
>> +	regmap_reg_range(0xB8, 0xBE),
>> +	regmap_reg_range(0xD1, 0xDA),
>> +	regmap_reg_range(0xDC, 0xDF),
>> +	/* Factory settins area */
>> +	regmap_reg_range(0x180, 0x1DF),
>> +	{ }
>> +};
>> +
>> +static const struct regmap_range max1721x_regs_deny[] = {
>> +	regmap_reg_range(0x24, 0x26),
>> +	regmap_reg_range(0x30, 0x31),
>> +	regmap_reg_range(0x33, 0x34),
>> +	regmap_reg_range(0x37, 0x37),
>> +	regmap_reg_range(0x3B, 0x3C),
>> +	regmap_reg_range(0x40, 0x41),
>> +	regmap_reg_range(0x43, 0x44),
>> +	regmap_reg_range(0x47, 0x49),
>> +	regmap_reg_range(0x4B, 0x4C),
>> +	regmap_reg_range(0x4E, 0xAF),
>> +	regmap_reg_range(0xB1, 0xB3),
>> +	regmap_reg_range(0xB5, 0xB7),
>> +	regmap_reg_range(0xBF, 0xD0),
>> +	regmap_reg_range(0xDB, 0xDB),
>> +	regmap_reg_range(0xE0, 0x17F),
>> +	{ }
>> +};
>> +
>> +static const struct regmap_access_table max1721x_regs = {
>> +	.yes_ranges	= max1721x_regs_allow,
>> +	.n_yes_ranges	= ARRAY_SIZE(max1721x_regs_allow),
>> +	.no_ranges	= max1721x_regs_deny,
>> +	.n_no_ranges	= ARRAY_SIZE(max1721x_regs_deny),
>> +};
> It should be enough to specify the yes_range. Unspecified
> values will be no implicitly.
I can remove this. I just desribe all registers hole described in 
datasheet. I hope this reduce memory in regmap infrastructure.
>> +/* W1 regmap config */
>> +static const struct regmap_config max1721x_regmap_w1_config = {
>> +	.reg_bits = 16,
>> +	.val_bits = 16,
>> +	.volatile_table = &max1721x_regs,
>> +	.max_register = MAX1721X_MAX_REG_NR,
>> +};
> Are the non-volatile registers missing? Then you probably also
> want to specify .rd_table with the same access table, so that
> dumping registers via debugfs work correctly. Did you try to
> cat /sys/kernel/debug/regmap/<your-device>/registers?
Ok, I try this. Non-volatile registers present (Rsense, manufaturer, 
device name, serial number). I not read this register until probe step, 
so I not put them into nonvolatile regmap table. But I can do this. May 
be it's more correctly, than desribe registers hole.
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
>> +MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauage IC driver");
>> +MODULE_ALIAS("platform:max1721x-battery");
> Otherwise looks good.
BTW. I try send RFC with alternative realisation of this driver into 
linux-pm:
[1] http://marc.info/?l=linux-pm&m=149422406914440
[2] http://marc.info/?l=linux-pm&m=149422407014444

This code maped to thermal zones, not used platform device and put 
max172xx-battery.h into include/linux/power. All know troubel in [1].
