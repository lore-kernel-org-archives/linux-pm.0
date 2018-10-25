From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 00/11] AXP8x3 AC and battery power supply support
Date: Thu, 25 Oct 2018 15:30:17 +0200
Message-ID: <20181025133017.2rdnbgmvdlx67kcz@earth.universe>
References: <20181023185330.10472-1-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ix4k4ufla4fevamq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--ix4k4ufla4fevamq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Patches 1, 2 & 9 look good to me and do not seem to have any
dependencies. I plan to merge them after the merge window
for 4.20 closes.

-- Sebastian

On Tue, Oct 23, 2018 at 09:53:19PM +0300, Oskari Lemmela wrote:
> AXP813 AC power supply support with input current and
> voltage limiting support.
>=20
> AXP803 AC and battery power supply support.
>=20
> Changes in v5:
> * Return correct input current limit for values 0x6 and 0x7
> * Add specific compatibles for AXP803
> * Change commit messages
> * Add Vasily Khoruzhick Pinebook DTS patch
>=20
> Changes in v4:
> * Change order of axp20x-gpio in axp20x.c
> * Fix indentation and spaces to tabs in axp20x.c
>=20
> Changes in v3:
> * Reorder ac_power_supply DT node
> * Rename axp20x_ac_power_set_property function
> * Split mfd commit=20
>=20
> Changes in v2:
> * Reuse axp813 compatibles for axp803
> * Refactor axp20x_ac_power.c
>=20
> Oskari Lemmela (10):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   dt-bindings: power: supply: axp20x: add AXP803 power bindings
>   dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
>   dt-bindings: iio: adc: add AXP803 ADC bindings
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
>=20
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: pinebook: enable power supplies
>=20
>  .../devicetree/bindings/gpio/gpio-axp209.txt  |  2 +
>  .../bindings/iio/adc/axp20x_adc.txt           |  2 +
>  .../bindings/power/supply/axp20x_ac_power.txt |  4 +
>  .../bindings/power/supply/axp20x_battery.txt  |  1 +
>  arch/arm/boot/dts/axp81x.dtsi                 |  5 +
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 33 +++++++
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  8 ++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
>  drivers/mfd/axp20x.c                          | 20 ++++
>  drivers/power/supply/axp20x_ac_power.c        | 94 +++++++++++++++++++
>  include/linux/mfd/axp20x.h                    |  1 +
>  11 files changed, 178 insertions(+)
>=20
> --=20
> 2.17.1
>=20

--ix4k4ufla4fevamq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvRxWcACgkQ2O7X88g7
+pqoYBAAml3HrRrerjuL11bRxxoJSeTc/PBvyYsHevJyPQTmFLHninb0wnrdGOJJ
bGXD4y4w/EPusLhkGCfmVmWuPTPZG4wnf5gJfHBOmFoTOcmjF68ASShpavKbCUH/
WEMp8mYT+o2eCSWbIuKrEb+6T+PI3ue8i+LpEx4B9i5nb2qg69zR//V1YP7CRK0E
rp1YUX4cIuBzxGSyi3SEbJGFOhrHeckCeWAvPi8DDlP7pXssO2qquAkb2tGzvJNF
UUz3JVlB4MOWNxhscTZIzQ2GDKGrcKNqqwK+PFPt5ewvr3bY/tJcmGc+IBPcrqls
zWPeex8tincMb5o6f4HuBwK0EDIR4wlne88km/OSRaW065wSE6xF377IlUmEkdam
1PNPYbGr6hckdATIgNeMtNPsd8b13zNQGWYcp718+lPo+Bbmqb5sYh8whU80s734
h6JIbfv5H4kr/r/4qcW13QU991bz6o0cMCmw9m0IikR5WI/PGL+Lu3R4u3jPU/+U
iCFNr5/oPBPBTg9epvSf9tGqu1PlbZtxJN2T5vpf67KKaUKczdb4+b86ZDxMcTAe
/ruSHYohiS3FD1JGT/S/s0cn0Q5qsN3pRMOaBnuaMgD/YIQpAPMmnD3xVCLg+3wD
ymj/0XhXTMnAXvNdasIVofcNuUmX/VtCEgCb0A/gJGiPTo9+xNA=
=0RM0
-----END PGP SIGNATURE-----

--ix4k4ufla4fevamq--
