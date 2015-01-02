From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 08/17] thermal: exynos: dts: Add default definition of
 the TMU sensor parameter
Date: Fri, 2 Jan 2015 14:11:41 -0400
Message-ID: <20150102181139.GA12130@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-9-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:61388 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbABSNz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 13:13:55 -0500
Content-Disposition: inline
In-Reply-To: <1418213396-743-9-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lukasz,

On Wed, Dec 10, 2014 at 01:09:47PM +0100, Lukasz Majewski wrote:
> Exynos 4 and 5 family of SoCs uses almost identical TMU sensor to measure=
 the
> on chip temperature. For this reason it is possible to group TMU configur=
ation
> parameters in one dts file.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v2:
> - None
> ---
>  arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 24 +++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
>=20
> diff --git a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi b/arch/arm=
/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> new file mode 100644
> index 0000000..ee6d8bb
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
> @@ -0,0 +1,24 @@
> +/*
> + * Device tree sources for Exynos4412 TMU sensor configuration
> + *
> + * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <dt-bindings/thermal/thermal_exynos.h>
> +
> +#thermal-sensor-cells =3D <0>;
> +gain =3D <8>;
> +reference_voltage =3D <16>;
> +noise_cancel_mode =3D <4>;
> +efuse_value =3D <55>;
> +min_efuse_value =3D <40>;
> +max_efuse_value =3D <100>;
> +first_point_trim =3D <25>;
> +second_point_trim =3D <85>;
> +default_temp_offset =3D <50>;
> +cal_type =3D <TYPE_ONE_POINT_TRIMMING>;

Are the above properties specific to exynos? For specific DT entries,
they need to be marked with a prefix. Please read the 'Device Specific
Data' section of Device tree Documentation [1].

[1] - http://devicetree.org/Device_Tree_Usage
> --=20
> 2.0.0.rc2
>=20

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUpt9SAAoJEMLUO4d9pOJWaAIH/1B3HG+gO7r+DleSD+WAnUMb
dsnWDIBBF8hNDvIEqLk+QsI+RQj3qNQa9WnIZZASdGWCgFdnc1rLWV9NGjUHYFDf
CoD1D1sFIeEZXkS2Nbd3+/1RabuELOZLSsTIErT8Zo3YO3cDEm8Jv6m+6VuuC2Fs
XPktuJTRul+PM4P+dUlJ3Z/EBM8SywEzZZriB0qcMAI6CPd7b1ZLQMMUiUJSyJRX
lRcX4vQxSVqpB0dtyTq3bqEVEJddYjduTBFMgMhbtsZ62rp0kU1vGDt5sdDTgvcd
BsFSEOjWq1oXS136SCokB1TsLVwEpkaySGDdiFxny/UQW9LYqs4JAvtA10Rp2dU=
=fggP
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
