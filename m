From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] power: supply: Add driver for TI BQ2416X battery charger
Date: Mon, 20 Mar 2017 06:58:45 +0100
Message-ID: <20170320055845.3o7nyhcu66ridheb@earth>
References: <1486429749-12973-1-git-send-email-wojciech.ziemba@verifone.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n5cxioe27ptctdfw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486429749-12973-1-git-send-email-wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wojciech Ziemba <wo.ziemba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--n5cxioe27ptctdfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 07, 2017 at 01:09:09AM +0000, Wojciech Ziemba wrote:
> There is interest in adding a Linux driver for TI BQ2416X battery
> charger.

This is a strange sentence to introduce a patch. If there wasn't
you wouldn't have sent a patch...

> The driver supports BQ24160 chip, thus can be easily extended
> for other BQ2416X family chargers.

Doesn't it already do? Do you mean "I only tested the driver using
bq24160"?

> Device exposes 'POWER_SUPPLY_PROP_*' properties

ok.

> and a number of knobs for controlling the charging process

missing sysfs ABI documentation. Most of them are probably either
not needed, or should become standard POWER_SUPPLY_PROP_ properties.

> as well as sends power supply change notification via power-supply
> subsystem.

ok.

> Signed-off-by: Wojciech Ziemba <wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/bq2416x.txt   |   71 +
>  drivers/power/supply/Kconfig                       |    7 +
>  drivers/power/supply/Makefile                      |    1 +
>  drivers/power/supply/bq2416x_charger.c             | 1871 ++++++++++++++=
++++++
>  include/dt-bindings/power/bq2416x_charger.h        |   23 +
>  include/linux/power/bq2416x_charger.h              |   80 +
>  6 files changed, 2053 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2416=
x.txt
>  create mode 100644 drivers/power/supply/bq2416x_charger.c
>  create mode 100644 include/dt-bindings/power/bq2416x_charger.h
>  create mode 100644 include/linux/power/bq2416x_charger.h
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2416x.txt b=
/Documentation/devicetree/bindings/power/supply/bq2416x.txt
> new file mode 100644
> index 0000000..8f4b814
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
> @@ -0,0 +1,71 @@
> +Binding for TI bq2416x Li-Ion Charger
> +
> +Required properties:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +- compatible: one of the following:
> + * "ti,bq24160"
> + * "ti,bq24160a"
> + * "ti,bq24161"
> + * "ti,bq24161b"
> + * "ti,bq24163"
> + * "ti,bq24168"
> +
> +- reg:			I2c address of the device.
> +- interrupt-parent:	The irq controller(phandle) connected to INT pin on =
BQ2416x
> +- interrupts:		The irq number assigned for INT pin.
> +
> +Optional properties:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +- interrupt-names:		Meanigfull irq name.

Drop this, it's not used.

> +- ti,charge-voltage:		Charge volatge [mV].
> +- ti,charge-current:		Charge current [mA].
> +- ti,termination-current:	Termination current [mA}.

These are battery dependent. You should get them from the
battery instead.

> +- ti,in-current-limit:		IN source current limit. enum:
> +				- IN_CURR_LIM_1500MA (0)
> +				- IN_CURR_LIM_2500MA (1)

This is probably needed. Just use an integer with the current
instead of the enum. The driver can just bail out if invalid
value was specified.

> +- ti,usb-current-limit:		USB source current limit. enum:
> +				- USB_CURR_LIM_100MA (0)
> +				- USB_CURR_LIM_150MA (1)
> +				- USB_CURR_LIM_500MA (2)
> +				- USB_CURR_LIM_800MA (3)
> +				- USB_CURR_LIM_900MA (4)
> +				- USB_CURR_LIM_1500MA (5)

Let's not add that to the DT binding. It should be auto-detected.
Additionally you can make the sysfs property writable.

> +- ti,status-pin-enable:		0 or 1. Enable charge status output STAT pin.
> +- ti,current-termination-enable:0 or 1. Enable charge current terminatio=
n.

If termination current is specified -> enable, otherwise -> disable,
so not needed.

> +- ti,usb-dpm-voltage:		USB dpm voltage [mV]. Refer to datasheet.
> +- ti,in-dpm-voltage:		IN dpm voltage [mV].

I will have to check datasheet before commenting about this one.

> +- ti,safety-timer:		Safety timer. enum:
> +			- TMR_27MIN (0)
> +			- TMR_6H (1)
> +			- TMR_9H (2)
> +			- TMR_OFF (3)

This does not belong into DT. Just always set it to 27 minutes and
properly reset the timer in the driver. You will also need a suspend
handler, that disables the timer (or wakeup every now and then to
reset it).

> +- ti,supplied-to:	string array: max 4. Names of devices to which
> +			the charger supplies.

There is a standard binding for this, which is documented here:

Documentation/devicetree/bindings/power/supply/power_supply.txt

> +Example:
> +=3D=3D=3D=3D=3D=3D=3D
> +#include <dt-bindings/power/bq2416x_charger.h>
> +
> +bq24160@6b {
> +	compatible =3D "ti,bq24160";
> +	reg =3D <0x6b>;
> +
> +	interrupt-parent =3D <&gpio5>;
> +	interrupts =3D <31 IRQ_TYPE_EDGE_RISING>;
> +	interrupt-names =3D "bq24160-charge-status-change";
> +
> +	ti,charge-voltage =3D <4300>;
> +	ti,charge-current =3D <1300>;
> +	ti,termination-current =3D <100>;
> +	ti,in-current-limit =3D <IN_CURR_LIM_1500MA>;
> +	ti,usb-current-limit =3D <USB_CURR_LIM_1500MA>;
> +	ti,status-pin-enable =3D <1>;
> +	ti,current-termination-enable =3D <1>;
> +	ti,usb-dpm-voltage =3D <4300>;
> +	ti,in-dpm-voltage =3D <4300>;
> +	ti,safety-timer =3D <TMR_6H>; /* charge max 6h */
> +	ti,supplied-to =3D "bq27621-0";
> +};
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 76806a0..575096e 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -413,6 +413,13 @@ config CHARGER_BQ2415X
>  	  You'll need this driver to charge batteries on e.g. Nokia
>  	  RX-51/N900.
> =20
> +config CHARGER_BQ2416X
> +	tristate "TI BQ2416x Dual-Input, Single Cell Switch-Mode Li-Ion charger"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for the TI BQ2416x battery charger.
> +	  The driver is configured to operate with a single lithium cell.
> +
>  config CHARGER_BQ24190
>  	tristate "TI BQ24190 battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 36c599d..73711e0 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+=3D qcom_smbb.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
> +obj-$(CONFIG_CHARGER_BQ2416X)	+=3D bq2416x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
> diff --git a/drivers/power/supply/bq2416x_charger.c b/drivers/power/suppl=
y/bq2416x_charger.c
> new file mode 100644
> index 0000000..fa13e55
> --- /dev/null
> +++ b/drivers/power/supply/bq2416x_charger.c
> @@ -0,0 +1,1871 @@
> +/*
> + * Driver for BQ2416X Li-Ion Battery Charger
> + *
> + * Copyright (C) 2015 Verifone, Inc.
> + *
> + * Author: Wojciech Ziemba <wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org>
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED AS IS AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * The bq2416x series is a 2.5A, Dual-Input, Single-Cell Switched-Mode
> + * Li-Ion Battery Charger with Power
> + * Path Management and I2C Interface

strange line wrapping above.

> + * This driver was tested on BQ24160.
> + *
> + * Datasheets:
> + * http://www.ti.com/product/bq24160
> + * http://www.ti.com/product/bq24160a
> + * http://www.ti.com/product/bq24161
> + * http://www.ti.com/product/bq24161b
> + * http://www.ti.com/product/bq24163
> + * http://www.ti.com/product/bq24168
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/regmap.h>
> +#include <linux/power_supply.h>
> +#include <linux/power/bq2416x_charger.h>

[...]

> diff --git a/include/linux/power/bq2416x_charger.h b/include/linux/power/=
bq2416x_charger.h
> new file mode 100644
> index 0000000..c561666
> --- /dev/null
> +++ b/include/linux/power/bq2416x_charger.h
> @@ -0,0 +1,80 @@
> +/*
> + * Driver for BQ2416X Li-Ion Battery Charger
> + *
> + * Copyright (C) 2015 Verifone, Inc.
> + *
> + * Author: Wojciech Ziemba <wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org>
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED AS IS AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * The bq2416x series is a 2.5A, Dual-Input, Single-Cell Switched-Mode
> + * Li-Ion Battery Charger with Power
> + * Path Management and I2C Interface
> + *
> + */
> +
> +#ifndef _BQ2416X_CHARGER_H
> +#define _BQ2416X_CHARGER_H
> +
> +/* IN(Wall) source limit */
> +enum in_curr_lim {
> +	IN_CURR_LIM_1500MA,
> +	IN_CURR_LIM_2500MA,
> +};
> +
> +/* USB source current limit */
> +enum usb_curr_lim {
> +	USB_CURR_LIM_100MA,
> +	USB_CURR_LIM_150MA,
> +	USB_CURR_LIM_500MA,
> +	USB_CURR_LIM_800MA,
> +	USB_CURR_LIM_900MA,
> +	USB_CURR_LIM_1500MA,
> +};
> +
> +/* Safety timer settings */
> +enum safe_tmr {
> +	TMR_27MIN,
> +	TMR_6H,
> +	TMR_9H,
> +	TMR_OFF,
> +};
> +
> +/**
> + * struct bq2416x_pdata - Platform data for bq2416x chip. It contains de=
fault
> + *			  board voltages and currents.
> + * @charge_voltage: charge voltage in [mV]
> + * @charge_current: charge current in [mA]
> + * @in_curr_limit: Current limit for IN source . Enum 1.5A or 2.5A
> + * @usb_curr_limit: Current limit for USB source Enum 100mA - 1500mA
> + * @curr_term_en: enable charge terination by current
> + * @term_current: charge termination current in [mA]
> + * @usb_dpm_voltage: USB DPM voltage [mV]
> + * @in_dpm_voltage: IN DPM voltage [mV]
> + * @stat_pin_en: status pin enable
> + * @safety_timer: safety timer enum: 27min, 6h, 9h, off.
> + * @num_supplicants: number of notify devices. Max 4.
> + * @supplied_to: array of names of supplied to devices
> + */
> +struct bq2416x_pdata {
> +	int charge_voltage;
> +	int charge_current;
> +	enum in_curr_lim in_curr_limit;
> +	enum usb_curr_lim usb_curr_limit;
> +	int curr_term_en;
> +	int term_current;
> +	int usb_dpm_voltage;
> +	int in_dpm_voltage;
> +	int stat_pin_en;
> +	enum safe_tmr safety_timer;
> +	int num_supplicants;
> +	const char *supplied_to[4];
> +};
> +
> +#endif /* _BQ2416X_CHARGER_H */

Please use device properties instead of platform_data (especially if
this is not yet used).

Apart from the comments I only skipped quickly over the driver. I
will have a more detailed look once the basic things are fixed.

-- Sebastian

--n5cxioe27ptctdfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPb5IACgkQ2O7X88g7
+ppk5g/+Mb9CXood1SdRT/lTQEp0BI3yo0aFc0aI9bxzfGo9GJb/ZOb9JO9PY5Hl
kMLfY5IwQzThsAoIbkJQAZHIQXJy0ZL520ivTfvRhI2UkRuU7IyRiz0xlpKLnM02
k7LsjPerBbHVo8hk7eTviSCFZtGLxvwM+H1eLEkEswQOKKXgHeDprPo69tLA/Dkn
J3fkbBUG3EPnphdjZ3R0jtrYsh7PLOM9sP2g9pQHqIRLZpxv/F8cUPNikwo2JhTs
hoOYUnoCS7BCplV+ySLfe1HM8CaWk4gvuwbeRYG0S92oofXjTeio8qHgic6YIYfW
UmOywlvEtkth91YHvU5N7J/WkIJ0G2aIP3RgUtYmxW8KRtG+jBnDdZtOzDNzDPhN
tz1VVVvFJLx/Mit3iOaB0XAcXqcbxxdTAnG5KV1TES1knwOU9X6ECF6EdVh7g1Bn
17CREdYOWtUwSd8cALrOFwOHtbI1f8+yeBgH8uKQhhofBd4wYW9fiQEM8glwfD6W
pyA4WJdNiwp4A8pGzOP+W1bSVaB85LwI6UzTfwA1TKF1ecji/ondbQ1w/xxT9mvg
ja8rVx7tegcWeIIUO5tl495qJM6TkrpqLnYrkiOo6l2ambsalcfEQXqqdkmMmxMC
FJRWdHa9OCgtN6qbSYrL/w7VahiAjdxCB5/bCmKiYRaMxfFM/Ek=
=e88/
-----END PGP SIGNATURE-----

--n5cxioe27ptctdfw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
