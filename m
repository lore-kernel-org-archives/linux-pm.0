From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 08/17] thermal: exynos: dts: Add default definition of
 the TMU sensor parameter
Date: Fri, 2 Jan 2015 14:26:28 -0400
Message-ID: <20150102182625.GB12310@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-9-git-send-email-l.majewski@samsung.com>
 <20150102181139.GA12130@developer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150102181139.GA12130@developer>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2015 at 02:11:41PM -0400, Eduardo Valentin wrote:
> Lukasz,
>=20
> On Wed, Dec 10, 2014 at 01:09:47PM +0100, Lukasz Majewski wrote:
> > Exynos 4 and 5 family of SoCs uses almost identical TMU sensor to measu=
re the
> > on chip temperature. For this reason it is possible to group TMU config=
uration
> > parameters in one dts file.
> >=20
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v2:
> > - None
> > ---
> >  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 24 +++++++++++++++=
++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> >=20
> > diff --git a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi b/arch/a=
rm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> > new file mode 100644
> > index 0000000..ee6d8bb
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> > @@ -0,0 +1,24 @@
> > +/*
> > + * Device tree sources for Exynos4412 TMU sensor configuration
> > + *
> > + * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <dt-bindings/thermal/thermal_exynos.h>
> > +
> > +#thermal-sensor-cells =3D <0>;
> > +gain =3D <8>;
> > +reference_voltage =3D <16>;
> > +noise_cancel_mode =3D <4>;
> > +efuse_value =3D <55>;
> > +min_efuse_value =3D <40>;
> > +max_efuse_value =3D <100>;
> > +first_point_trim =3D <25>;
> > +second_point_trim =3D <85>;
> > +default_temp_offset =3D <50>;
> > +cal_type =3D <TYPE_ONE_POINT_TRIMMING>;
>=20
> Are the above properties specific to exynos? For specific DT entries,
> they need to be marked with a prefix. Please read the 'Device Specific
> Data' section of Device tree Documentation [1].
>=20
> [1] - http://devicetree.org/Device_Tree_Usage


BTW, you have to update:
Documentation/devicetree/bindings/thermal/exynos-thermal.txt


> > --=20
> > 2.0.0.rc2
> >=20



--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpuLJAAoJEMLUO4d9pOJWp8sH/jqJ2+mWHZCNl3vsbiyJJ0Zx
RuCZoNF5tgZwvc5Kq43uptIhK4jvk1Jo08MbJXJ+viyYry4B1U9NlZCaKLX+SQmS
lAUCtcNEuadAIOzuyGi3CxDZt38c+iAObFzFf/5L8rmqUZhHcCv1wJNW4jsBzDis
EaYmkMxQ4CzWSeY5Wi971W4t47REqalO7Zhqp6omfeYAKsrlF13kewQn3f+X6eZZ
bE4uSxqp6TIdccsIjkAkigHeGxnhMQeyNwiG+8MN7+UbUoBv8up0RGw5bJ8TNGyS
S3YlHvMwme0vkeHDUaodDj9ANWFwQi6e7hbr0YkyUUQAQOtOFiAQuVx/qq4bXoY=
=/k+P
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
