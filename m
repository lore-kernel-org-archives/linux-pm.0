From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/8] power: Add an axp20x-usb-power driver
Date: Wed, 10 Jun 2015 08:29:57 +0100
Message-ID: <20150610072957.GV2982@x1>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-5-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36011 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932982AbbFJHaD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 03:30:03 -0400
Received: by wigg3 with SMTP id g3so38661340wig.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 00:30:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433885881-19809-5-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On Tue, 09 Jun 2015, Hans de Goede wrote:

> This adds a driver for the usb power_supply bits of the axp20x PMICs.
>=20
> I initially started writing my own driver, before coming aware of
> Bruno Pr=C3=A9mont's excellent earlier RFC with a driver for this.
>=20
> My driver was lacking CURRENT_MAX and VOLTAGE_MIN support Bruno's
> drvier has, so I've copied the code for those from his driver.
>=20
> Note that the AC-power-supply and battery charger bits will need sepa=
rate
> drivers. Each one needs its own devictree child-node so that other
> devicetree nodes can reference the right power-supply, and thus each =
one
> will get its own mfd-cell / platform_device and platform-driver.
>=20
> Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/power_supply/axp20x_usb_power.txt     |  34 +++

This needs to be submitted in a seperate patch.

>  drivers/power/Kconfig                              |   7 +
>  drivers/power/Makefile                             |   1 +
>  drivers/power/axp20x_usb_power.c                   | 241 +++++++++++=
++++++++++
>  include/linux/mfd/axp20x.h                         |  24 ++
>  5 files changed, 307 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/ax=
p20x_usb_power.txt
>  create mode 100644 drivers/power/axp20x_usb_power.c

[...]

> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index f4290ae..d7adb2e 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -11,6 +11,8 @@
>  #ifndef __LINUX_MFD_AXP20X_H
>  #define __LINUX_MFD_AXP20X_H
> =20
> +#include <linux/regmap.h>
> +
>  enum {
>  	AXP202_ID =3D 0,
>  	AXP209_ID,
> @@ -366,4 +368,26 @@ struct axp20x_fg_pdata {
>  	int thermistor_curve[MAX_THERM_CURVE_SIZE][2];
>  };
> =20
> +/* generic helper function for reading 9-16 bit wide regs */
> +static inline int axp20x_read_16bit(struct regmap *regmap,

This is only used twice and only in one file.

Do you know of any other uses of this call that will be upstreamed
shortly?

> +				    unsigned int reg, unsigned int width)

The function name is a bit misleading.

> +{
> +	unsigned int v, raw;
> +	int r;

'v' and 'r' are not good variable names.

> +	r =3D regmap_read(regmap, reg, &v);
> +	if (r)
> +		return r;
> +
> +	raw =3D v << (width - 8);

So 'reg' is expected to be top end loaded?

E.g A value of say 0x0101 (257) in 9 bits will look like this:

reg          reg + 1
1000 0000b   0000 0001b

> +	r =3D regmap_read(regmap, reg + 1, &v);
> +	if (r)
> +		return r;
> +
> +	raw |=3D v;
> +
> +	return raw;
> +}
> +
>  #endif /* __LINUX_MFD_AXP20X_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
