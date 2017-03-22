From: Wojciech Ziemba <Wojciech.Ziemba@VERIFONE.com>
Subject: Re: [PATCH] power: supply: Add driver for TI BQ2416X battery charger
Date: Wed, 22 Mar 2017 13:53:19 +0000
Message-ID: <BN6PR03MB2963F42E5F6AC2ECCDC5722B9F3C0@BN6PR03MB2963.namprd03.prod.outlook.com>
References: <1486429749-12973-1-git-send-email-wojciech.ziemba@verifone.com>,<20170320055845.3o7nyhcu66ridheb@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:25408
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759584AbdCVNyR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 09:54:17 -0400
In-Reply-To: <20170320055845.3o7nyhcu66ridheb@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Wojciech Ziemba <wo.ziemba@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,
On 20/03/17 05:58, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Feb 07, 2017 at 01:09:09AM +0000, Wojciech Ziemba wrote:
>> There is interest in adding a Linux driver for TI BQ2416X battery
>> charger.
> This is a strange sentence to introduce a patch. If there wasn't
> you wouldn't have sent a patch...

Will remove. Thanks.

>> The driver supports BQ24160 chip, thus can be easily extended
>> for other BQ2416X family chargers.
> Doesn't it already do? Do you mean "I only tested the driver using
> bq24160"?

The driver covers: bq24160, bq24160A, bq24161, bq24161B, bq24163, bq24168.
These have the same register set but are slightly different:
safety and watchdog timers, different USB source detection etc.

>> Device exposes 'POWER_SUPPLY_PROP_*' properties
> ok.
>
>> and a number of knobs for controlling the charging process
> missing sysfs ABI documentation. Most of them are probably either
> not needed, or should become standard POWER_SUPPLY_PROP_ properties.

Well, it is up to you. POWER_SUPPLY props are already there.
If any new POWER_SUPPLY props should be introduced, it is an open question.
I agree sysfs knobs could be not needed, but many PSY drivers
still use them. Couldn't them still be useful even if don't fit the model d=
irectly?
Especially for more specialized embedded systems?

>> as well as sends power supply change notification via power-supply
>> subsystem.
> ok.
>
>> Signed-off-by: Wojciech Ziemba <wojciech.ziemba@verifone.com>
>> ---
>>   .../devicetree/bindings/power/supply/bq2416x.txt   |   71 +
>>   drivers/power/supply/Kconfig                       |    7 +
>>   drivers/power/supply/Makefile                      |    1 +
>>   drivers/power/supply/bq2416x_charger.c             | 1871 ++++++++++++=
++++++++
>>   include/dt-bindings/power/bq2416x_charger.h        |   23 +
>>   include/linux/power/bq2416x_charger.h              |   80 +
>>   6 files changed, 2053 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/bq24=
16x.txt
>>   create mode 100644 drivers/power/supply/bq2416x_charger.c
>>   create mode 100644 include/dt-bindings/power/bq2416x_charger.h
>>   create mode 100644 include/linux/power/bq2416x_charger.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq2416x.txt =
b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
>> new file mode 100644
>> index 0000000..8f4b814
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
>> @@ -0,0 +1,71 @@
>> +Binding for TI bq2416x Li-Ion Charger
>> +
>> +Required properties:
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +- compatible: one of the following:
>> + * "ti,bq24160"
>> + * "ti,bq24160a"
>> + * "ti,bq24161"
>> + * "ti,bq24161b"
>> + * "ti,bq24163"
>> + * "ti,bq24168"
>> +
>> +- reg:                      I2c address of the device.
>> +- interrupt-parent: The irq controller(phandle) connected to INT pin on=
 BQ2416x
>> +- interrupts:               The irq number assigned for INT pin.
>> +
>> +Optional properties:
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +- interrupt-names:          Meanigfull irq name.
> Drop this, it's not used.

Ok. Thanks.

>> +- ti,charge-voltage:                Charge volatge [mV].
>> +- ti,charge-current:                Charge current [mA].
>> +- ti,termination-current:   Termination current [mA}.
> These are battery dependent. You should get them from the
> battery instead.

Ok.

>> +- ti,in-current-limit:              IN source current limit. enum:
>> +                            - IN_CURR_LIM_1500MA (0)
>> +                            - IN_CURR_LIM_2500MA (1)
> This is probably needed. Just use an integer with the current
> instead of the enum. The driver can just bail out if invalid
> value was specified.
>
>> +- ti,usb-current-limit:             USB source current limit. enum:
>> +                            - USB_CURR_LIM_100MA (0)
>> +                            - USB_CURR_LIM_150MA (1)
>> +                            - USB_CURR_LIM_500MA (2)
>> +                            - USB_CURR_LIM_800MA (3)
>> +                            - USB_CURR_LIM_900MA (4)
>> +                            - USB_CURR_LIM_1500MA (5)
> Let's not add that to the DT binding. It should be auto-detected.
> Additionally you can make the sysfs property writable.

I see. That would be perfect.

>> +- ti,status-pin-enable:             0 or 1. Enable charge status output=
 STAT pin.
>> +- ti,current-termination-enable:0 or 1. Enable charge current terminati=
on.
> If termination current is specified -> enable, otherwise -> disable,
> so not needed.

Ok.

>> +- ti,usb-dpm-voltage:               USB dpm voltage [mV]. Refer to data=
sheet.
>> +- ti,in-dpm-voltage:                IN dpm voltage [mV].
> I will have to check datasheet before commenting about this one.
>
>> +- ti,safety-timer:          Safety timer. enum:
>> +                    - TMR_27MIN (0)
>> +                    - TMR_6H (1)
>> +                    - TMR_9H (2)
>> +                    - TMR_OFF (3)
> This does not belong into DT. Just always set it to 27 minutes and
> properly reset the timer in the driver. You will also need a suspend
> handler, that disables the timer (or wakeup every now and then to
> reset it).

Do you mean, more flexible safety timer based on minimal 27min reset?
Will address wakeup in suspend, separately in this driver.

>> +- ti,supplied-to:   string array: max 4. Names of devices to which
>> +                    the charger supplies.
> There is a standard binding for this, which is documented here:
>
> Documentation/devicetree/bindings/power/supply/power_supply.txt

Ok. Thanks.

>> +Example:
>> +=3D=3D=3D=3D=3D=3D=3D
>> +#include <dt-bindings/power/bq2416x_charger.h>
>> +
>> +bq24160@6b {
>> +    compatible =3D "ti,bq24160";
>> +    reg =3D <0x6b>;
>> +
>> +    interrupt-parent =3D <&gpio5>;
>> +    interrupts =3D <31 IRQ_TYPE_EDGE_RISING>;
>> +    interrupt-names =3D "bq24160-charge-status-change";
>> +
>> +    ti,charge-voltage =3D <4300>;
>> +    ti,charge-current =3D <1300>;
>> +    ti,termination-current =3D <100>;
>> +    ti,in-current-limit =3D <IN_CURR_LIM_1500MA>;
>> +    ti,usb-current-limit =3D <USB_CURR_LIM_1500MA>;
>> +    ti,status-pin-enable =3D <1>;
>> +    ti,current-termination-enable =3D <1>;
>> +    ti,usb-dpm-voltage =3D <4300>;
>> +    ti,in-dpm-voltage =3D <4300>;
>> +    ti,safety-timer =3D <TMR_6H>; /* charge max 6h */
>> +    ti,supplied-to =3D "bq27621-0";
>> +};
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 76806a0..575096e 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -413,6 +413,13 @@ config CHARGER_BQ2415X
>>         You'll need this driver to charge batteries on e.g. Nokia
>>         RX-51/N900.
>>  =20
>> +config CHARGER_BQ2416X
>> +    tristate "TI BQ2416x Dual-Input, Single Cell Switch-Mode Li-Ion cha=
rger"
>> +    depends on I2C
>> +    help
>> +      Say Y here to enable support for the TI BQ2416x battery charger.
>> +      The driver is configured to operate with a single lithium cell.
>> +
>>   config CHARGER_BQ24190
>>       tristate "TI BQ24190 battery charger driver"
>>       depends on I2C
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefi=
le
>> index 36c599d..73711e0 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -63,6 +63,7 @@ obj-$(CONFIG_CHARGER_MAX8997)      +=3D max8997_charge=
r.o
>>   obj-$(CONFIG_CHARGER_MAX8998)      +=3D max8998_charger.o
>>   obj-$(CONFIG_CHARGER_QCOM_SMBB)    +=3D qcom_smbb.o
>>   obj-$(CONFIG_CHARGER_BQ2415X)      +=3D bq2415x_charger.o
>> +obj-$(CONFIG_CHARGER_BQ2416X)       +=3D bq2416x_charger.o
>>   obj-$(CONFIG_CHARGER_BQ24190)      +=3D bq24190_charger.o
>>   obj-$(CONFIG_CHARGER_BQ24257)      +=3D bq24257_charger.o
>>   obj-$(CONFIG_CHARGER_BQ24735)      +=3D bq24735-charger.o
>> diff --git a/drivers/power/supply/bq2416x_charger.c b/drivers/power/supp=
ly/bq2416x_charger.c
>> new file mode 100644
>> index 0000000..fa13e55
>> --- /dev/null
>> +++ b/drivers/power/supply/bq2416x_charger.c
>> @@ -0,0 +1,1871 @@
>> +/*
>> + * Driver for BQ2416X Li-Ion Battery Charger
>> + *
>> + * Copyright (C) 2015 Verifone, Inc.
>> + *
>> + * Author: Wojciech Ziemba <wojciech.ziemba@verifone.com>
>> + *
>> + * This package is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * THIS PACKAGE IS PROVIDED AS IS AND WITHOUT ANY EXPRESS OR
>> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
>> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * The bq2416x series is a 2.5A, Dual-Input, Single-Cell Switched-Mode
>> + * Li-Ion Battery Charger with Power
>> + * Path Management and I2C Interface
> strange line wrapping above.

ok.

>> + * This driver was tested on BQ24160.
>> + *
>> + * Datasheets:
>> + * http://www.ti.com/product/bq24160
>> + * http://www.ti.com/product/bq24160a
>> + * http://www.ti.com/product/bq24161
>> + * http://www.ti.com/product/bq24161b
>> + * http://www.ti.com/product/bq24163
>> + * http://www.ti.com/product/bq24168
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/regmap.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/power/bq2416x_charger.h>
> [...]
>
>> diff --git a/include/linux/power/bq2416x_charger.h b/include/linux/power=
/bq2416x_charger.h
>> new file mode 100644
>> index 0000000..c561666
>> --- /dev/null
>> +++ b/include/linux/power/bq2416x_charger.h
>> @@ -0,0 +1,80 @@
>> +/*
>> + * Driver for BQ2416X Li-Ion Battery Charger
>> + *
>> + * Copyright (C) 2015 Verifone, Inc.
>> + *
>> + * Author: Wojciech Ziemba <wojciech.ziemba@verifone.com>
>> + *
>> + * This package is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * THIS PACKAGE IS PROVIDED AS IS AND WITHOUT ANY EXPRESS OR
>> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
>> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * The bq2416x series is a 2.5A, Dual-Input, Single-Cell Switched-Mode
>> + * Li-Ion Battery Charger with Power
>> + * Path Management and I2C Interface
>> + *
>> + */
>> +
>> +#ifndef _BQ2416X_CHARGER_H
>> +#define _BQ2416X_CHARGER_H
>> +
>> +/* IN(Wall) source limit */
>> +enum in_curr_lim {
>> +    IN_CURR_LIM_1500MA,
>> +    IN_CURR_LIM_2500MA,
>> +};
>> +
>> +/* USB source current limit */
>> +enum usb_curr_lim {
>> +    USB_CURR_LIM_100MA,
>> +    USB_CURR_LIM_150MA,
>> +    USB_CURR_LIM_500MA,
>> +    USB_CURR_LIM_800MA,
>> +    USB_CURR_LIM_900MA,
>> +    USB_CURR_LIM_1500MA,
>> +};
>> +
>> +/* Safety timer settings */
>> +enum safe_tmr {
>> +    TMR_27MIN,
>> +    TMR_6H,
>> +    TMR_9H,
>> +    TMR_OFF,
>> +};
>> +
>> +/**
>> + * struct bq2416x_pdata - Platform data for bq2416x chip. It contains d=
efault
>> + *                    board voltages and currents.
>> + * @charge_voltage: charge voltage in [mV]
>> + * @charge_current: charge current in [mA]
>> + * @in_curr_limit: Current limit for IN source . Enum 1.5A or 2.5A
>> + * @usb_curr_limit: Current limit for USB source Enum 100mA - 1500mA
>> + * @curr_term_en: enable charge terination by current
>> + * @term_current: charge termination current in [mA]
>> + * @usb_dpm_voltage: USB DPM voltage [mV]
>> + * @in_dpm_voltage: IN DPM voltage [mV]
>> + * @stat_pin_en: status pin enable
>> + * @safety_timer: safety timer enum: 27min, 6h, 9h, off.
>> + * @num_supplicants: number of notify devices. Max 4.
>> + * @supplied_to: array of names of supplied to devices
>> + */
>> +struct bq2416x_pdata {
>> +    int charge_voltage;
>> +    int charge_current;
>> +    enum in_curr_lim in_curr_limit;
>> +    enum usb_curr_lim usb_curr_limit;
>> +    int curr_term_en;
>> +    int term_current;
>> +    int usb_dpm_voltage;
>> +    int in_dpm_voltage;
>> +    int stat_pin_en;
>> +    enum safe_tmr safety_timer;
>> +    int num_supplicants;
>> +    const char *supplied_to[4];
>> +};
>> +
>> +#endif /* _BQ2416X_CHARGER_H */
> Please use device properties instead of platform_data (especially if
> this is not yet used).

ok.

> Apart from the comments I only skipped quickly over the driver. I
> will have a more detailed look once the basic things are fixed.

Thank you. I Will prepare [RFC v2] addressing your and others comments.

> -- Sebastian

Thanks,
Wojciech=
