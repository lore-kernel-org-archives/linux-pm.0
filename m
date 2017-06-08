From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 3/3] power: supply: Add support MAX1721x battery monitor
Date: Thu, 8 Jun 2017 21:17:26 +0200
Message-ID: <20170608191726.dg3awuoiftundmi2@earth>
References: <20170602070629.8210-1-minimumlaw@rambler.ru>
 <20170602070629.8210-4-minimumlaw@rambler.ru>
 <20170608124827.tvgfbrnlaeavpqs7@earth>
 <52712c86-9ef9-cfe3-49b3-5ff7db49ad44@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lv3lguy6smhblmek"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50934 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdFHTRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 15:17:35 -0400
Content-Disposition: inline
In-Reply-To: <52712c86-9ef9-cfe3-49b3-5ff7db49ad44@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--lv3lguy6smhblmek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, Jun 08, 2017 at 08:44:35PM +0300, Alex A. Mihaylov wrote:
> 08.06.17 15:48, Sebastian Reichel wrote:
> > On Fri, Jun 02, 2017 at 10:06:29AM +0300, Alex A. Mihaylov wrote:
> > > diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/=
supply/max1721x_battery.c
> > > new file mode 100644
> > > index 0000000000..aa0effec3d
> > > --- /dev/null
> > > +++ b/drivers/power/supply/max1721x_battery.c
> > > @@ -0,0 +1,357 @@
> > > +/*
> > > + * 1-wire client/driver for the Maxim Semicondactor
> > > + * MAX17211/MAX17215 Standalone Fuel Gauge IC
> > > + *
> > > + * Copyright (C) 2017 OAO Radioavionica
> > > + * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/param.h>
> > param?
> Ok, sorry. This really not need. I remove this in next revision.
> > > +#include <linux/pm.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/power_supply.h>
> > > +#include <linux/idr.h>
> > > +
> > > +#include "../../w1/w1.h"
> > This will conflict with public w1 interface patch
> > https://www.spinics.net/lists/kernel/msg2524566.html
> >=20
> > This patch should be on top of that patch.
> Ok. No problem. I can fix this here. I can fix this in regmap-w1. Just te=
ll
> me which of the patches will be applied first. If the one to which you
> refer, I will resend the patches immediately after it appears at least in
> -rc.
> > > +#include "../../w1/slaves/w1_max1721x.h"
> > Let's merge those defines into the driver. They
> > are not used anywhere else.
> Theory, Maxim integrated have MAX17201/MAX17205 with I2C interface. This =
may
> required for feature i2c driver.

This would end up in the same driver with only probe function being
different.

> > > +
> > > +/* Model Gauge M5 Register Memory Map access */
> > > +static const struct regmap_range max1721x_regs_allow[] =3D {
> > > +	/* M5 Model Gauge Algorithm area */
> > > +	regmap_reg_range(0x00, 0x23),
> > > +	regmap_reg_range(0x27, 0x2F),
> > > +	regmap_reg_range(0x32, 0x32),
> > > +	regmap_reg_range(0x35, 0x36),
> > > +	regmap_reg_range(0x38, 0x3A),
> > > +	regmap_reg_range(0x3D, 0x3F),
> > > +	regmap_reg_range(0x42, 0x42),
> > > +	regmap_reg_range(0x45, 0x46),
> > > +	regmap_reg_range(0x4A, 0x4A),
> > > +	regmap_reg_range(0x4D, 0x4D),
> > > +	regmap_reg_range(0xB0, 0xB0),
> > > +	regmap_reg_range(0xB4, 0xB4),
> > > +	regmap_reg_range(0xB8, 0xBE),
> > > +	regmap_reg_range(0xD1, 0xDA),
> > > +	regmap_reg_range(0xDC, 0xDF),
> > > +	/* Factory settins area */
> > > +	regmap_reg_range(0x180, 0x1DF),
> > > +	{ }
> > > +};
> > > +
> > > +static const struct regmap_range max1721x_regs_deny[] =3D {
> > > +	regmap_reg_range(0x24, 0x26),
> > > +	regmap_reg_range(0x30, 0x31),
> > > +	regmap_reg_range(0x33, 0x34),
> > > +	regmap_reg_range(0x37, 0x37),
> > > +	regmap_reg_range(0x3B, 0x3C),
> > > +	regmap_reg_range(0x40, 0x41),
> > > +	regmap_reg_range(0x43, 0x44),
> > > +	regmap_reg_range(0x47, 0x49),
> > > +	regmap_reg_range(0x4B, 0x4C),
> > > +	regmap_reg_range(0x4E, 0xAF),
> > > +	regmap_reg_range(0xB1, 0xB3),
> > > +	regmap_reg_range(0xB5, 0xB7),
> > > +	regmap_reg_range(0xBF, 0xD0),
> > > +	regmap_reg_range(0xDB, 0xDB),
> > > +	regmap_reg_range(0xE0, 0x17F),
> > > +	{ }
> > > +};
> > > +
> > > +static const struct regmap_access_table max1721x_regs =3D {
> > > +	.yes_ranges	=3D max1721x_regs_allow,
> > > +	.n_yes_ranges	=3D ARRAY_SIZE(max1721x_regs_allow),
> > > +	.no_ranges	=3D max1721x_regs_deny,
> > > +	.n_no_ranges	=3D ARRAY_SIZE(max1721x_regs_deny),
> > > +};
> > It should be enough to specify the yes_range. Unspecified
> > values will be no implicitly.
> I can remove this. I just desribe all registers hole described in datashe=
et.
> I hope this reduce memory in regmap infrastructure.

That's what I suspected.

> > > +/* W1 regmap config */
> > > +static const struct regmap_config max1721x_regmap_w1_config =3D {
> > > +	.reg_bits =3D 16,
> > > +	.val_bits =3D 16,
> > > +	.volatile_table =3D &max1721x_regs,
> > > +	.max_register =3D MAX1721X_MAX_REG_NR,
> > > +};
> > Are the non-volatile registers missing? Then you probably also
> > want to specify .rd_table with the same access table, so that
> > dumping registers via debugfs work correctly. Did you try to
> > cat /sys/kernel/debug/regmap/<your-device>/registers?
> Ok, I try this. Non-volatile registers present (Rsense, manufaturer, devi=
ce
> name, serial number). I not read this register until probe step, so I not
> put them into nonvolatile regmap table. But I can do this. May be it's mo=
re
> correctly, than desribe registers hole.

Register hole table should be used for the rd_table. You can skip
configuration of the volatile_table, if you do not enable caching
via max1721x_regmap_w1_config.cache_type. Enabling the caching is
only sensible, if you do not mark all registers as volatile ;)

> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
> > > +MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauage IC driver");
> > > +MODULE_ALIAS("platform:max1721x-battery");
> > Otherwise looks good.
> BTW. I try send RFC with alternative realisation of this driver into
> linux-pm:
> [1] http://marc.info/?l=3Dlinux-pm&m=3D149422406914440
> [2] http://marc.info/?l=3Dlinux-pm&m=3D149422407014444

Ah I skipped this one, since there was a newer revision.
Yes, this is what I had in mind when I talked about merging
the w1 driver into the power-supply driver.

> This code maped to thermal zones, not used platform device and put
> max172xx-battery.h into include/linux/power. All know troubel in [1].

So here are answers to your questions

> 1. Endian for W1-regmap
> Code writen for use nativ endian for host (master) device. But waiting for
> little-endian slave divice. I don't know W1 slave device with big-endian
> addrees or data format. May be regmap_bus or regmap_config will be checked
> for host/device endian requirements?

regmap_bus.reg_format_endian_default provides a default endianess for
the bus, which can be overwritten via regmap_config.val_format_endian.
Since Mark queued your patch everything seems to be alright (I did not
review it).

> 2. W1 Family/device infrastructure
> All present power_supply class drivers in vanilla kernel use w1-slave dev=
ices.
> All of them create platform_device with name "chip-battery.X.auto", and=
=20
> power_supply class driver use this platform device. Why used this way? I
> write code, allocated power_supply at W1 slave (family) device register.
> This work as expected.

Historical reasons. The patch [0], which I already mentioned is the
first step to move bq27xxx w1 driver into the power-supply subsystem.

> 3. Device names
> All W1 device have unical 64 bit ID (8-bit family, 48-bit serial number,
> 8 bit CRC). W1 infrastructure show 56 bits (family-serial_nimber) as w1
> slave device name. I use this (unical) device name as power_supply battery
> name. This work. But in /sys/class/power_supply is placed machine readabe=
=20
> subdir "26-HexDigString", instead of human-readable "chip-battery.X.auto".
> But in /sys/class/power_supply/26-HexDigString/type file still content
> human-readable type "Battery".
> Thermal zone working, but in /sys/class/thermal/thermal_zoneX/type also
> placed "26-HexDigString", instead of "chip-battery.X.auto".
> I can rename "26-HexDigString" to "battery-26-HexDigString" or=20
> "26-HexDigString-battery", but this exceeded 20 chars thermal zone device
> name. So, thermal zone will have to be disabled.

I think max1721x-<serial> would be better. If the name is too long, just
disable the thermal zone for now. We have more w1/psy drivers, that have pr=
oblems
due to the thermal zone device name length limitation.

[0] https://www.spinics.net/lists/kernel/msg2524566.html

-- Sebastian

--lv3lguy6smhblmek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5osMACgkQ2O7X88g7
+ppaURAAicCmsrZ60qNueUinu5PtcVNmt5BddcEn7ziCcXJ4sssLMWw3Pcnx6zHu
TtB53yrD0Mx8g47rSDf6wLr1gOhPxTwbPzFwEgvjmVrb5vtOMinIPR2YJtqq4ytR
G4cvpWEvYU8Oq79riGkN0+Q470QPUrWEWDNHAL2NDPVMwoC/qShCa5ET3QDMRlv2
LxoWbhyQOfTgRQcgM95Z/8p9VaPhIQ5xYCdcd520d8sunZemupWw7QJYpEtcEzfm
duF2MgZShS8EW2UKtK+6RhfOe//lKBIJhxDF6Eo2rSLW8gO6G/ivPjA6qHMZHgM2
GwAiuHaaVwAXdyFEoWdgK0761tbByJaninULMi8K+d9KF0KuK0GLtySapkCfdZiU
lHa0uerZQlDxvXh2A35oSyeL4QkRQ64OgwZZ42sppt/LWh2MN9B6xujBMatnoH1V
HGe8wzNz/WRLRl6vOh839MizUpTSXbFY/UI0+y9HiwomQrxiKZZ6/RzbEWghRI2p
vxB/jP77lYqUXvLV8Gc7rGm1Cd1tY3ehhL+gkgDYxRlqOvp5YOPjsRZh/luGuJt9
rtyEmA9mAuuV2fHeiKOs8cbfy55wm1+Ivn0esg0sQh8u5ECOT0DGbD3JcctGwcq+
AIhi8YkSkkvBSiJ9D80SPNyQpjYKvIgVF5YsOIVFSW3cqC900mg=
=RJfa
-----END PGP SIGNATURE-----

--lv3lguy6smhblmek--
