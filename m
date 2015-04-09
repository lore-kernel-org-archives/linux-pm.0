From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Samsung Thermal for v4.1 merge window
Date: Thu, 9 Apr 2015 10:36:34 -0700
Message-ID: <20150409173632.GA11022@localhost.localdomain>
References: <20150409180917.4d177432@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35325 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbbDIRgY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2015 13:36:24 -0400
Content-Disposition: inline
In-Reply-To: <20150409180917.4d177432@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lukasz,

On Thu, Apr 09, 2015 at 06:09:17PM +0200, Lukasz Majewski wrote:
> Dear Eduardo,
>=20
> Please find my pull request for Samsung Thermal targeting v4.1 merge
> window.
>=20
> The following changes since commit
> 96d927aa14deb1c4bf6bfd758776ad942463865d:
>=20
>   thermal: cpu_cooling: Fix power calculation when CPUs are offline
>   (2015-04-07 11:01:22 -0700)
>=20
> are available in the git repository at:
>=20
>   git@github.com:lmajewski/linux-samsung-thermal.git next
>=20
> for you to fetch changes up to 8e256d78739e5f47ed79a9c7fdb7d5346526dd85:
>=20
>   thermal: exynos: Add the support for Exynos5433 TMU (2015-04-09
>   17:34:10 +0200)
>=20
> ----------------------------------------------------------------
> Chanwoo Choi (1):
>       thermal: exynos: Add the support for Exynos5433 TMU
>=20
>  drivers/thermal/samsung/exynos_tmu.c | 187
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++--
>  drivers/thermal/samsung/exynos_tmu.h |   1 +=20
>=20
> 2 files changed, 186 insertions(+), 2 deletions(-)

Pulled. Thanks.

BR,

>=20
>=20
> Test HW: Odroid U3.
> Build GCC: 4.9.2
> SHA1: 8e256d78739e5f47ed79a9c7fdb7d5346526dd85
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVJricAAoJEMLUO4d9pOJW3PsIAJxnQjpUoklOqpbzlPGDh6YR
y4LWwn6OSprKam9O3xyuEkpjxRoQ0NswJ4ABD1Yr9rrmhqxN0KBQ3eHTStKEPOg0
qOI6qodmiv4eXHK0uKn+795HwxVRyLAX1/Q3KzV4B4CEq2pgZOWNMGrgd+zbhwHD
ACa5Q26Hh/dYMo5OfY8OZm6qGmPUC1CakYAh9gjloQX+ScVKgocbl77r66fgzuZQ
ua/GUMC5hkmG+yLQvMpDu3y3PawKsQvYU+KwyyNQwwTDRL94c27T/rUxggmtkdkX
KyRi1OTO8KHNv8IllgFCgsA98Q01pBqvMVlN8tQo5G2mEhIjnPHvYP07cPXAfdo=
=XwLZ
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
