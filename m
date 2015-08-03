From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Samsung Thermal FIXES for v4.2-rc1
Date: Sun, 2 Aug 2015 19:31:46 -0700
Message-ID: <20150803023145.GA30704@localhost.localdomain>
References: <20150706172657.3af87d97@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36237 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbbHCCbu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 22:31:50 -0400
Content-Disposition: inline
In-Reply-To: <20150706172657.3af87d97@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2015 at 05:26:57PM +0200, Lukasz Majewski wrote:
> Dear Eduardo,
>=20
> Please find my pull request for Samsung Thermal fixes (v4.2-rc1):
>=20
> The following changes since commit
> efa86858e1d8970411a140fa1e0c4dd18a8f2a89:
>=20
>   thermal: armada: Update Armada 380 thermal sensor coefficients
>   (2015-05-09 01:00:31 -0700)
>=20
> are available in the git repository at:
>=20
>   git@github.com:lmajewski/linux-samsung-thermal.git fixes
>=20
> for you to fetch changes up to e4dc28277205cfb02f8dd96fe694a1bcc2dc41b1:
>=20
>   thermal: exynos: Remove unused code related to platform_data on
>   probe() (2015-07-06 17:09:15 +0200)

I have rebased your work on top of my fixes branch. But everthing
applied fine.=20

Thanks a lot Lukasz.

>=20
> ----------------------------------------------------------------
> Chanwoo Choi (2):
>       thermal: exynos: Add the dependency of CONFIG_THERMAL_OF instead
> of CONFIG_OF thermal: exynos: Remove unused code related to
> platform_data on probe()
>=20
> Krzysztof Kozlowski (1):
>       thermal: exynos: Disable the regulator on probe failure
>=20
>  drivers/thermal/samsung/Kconfig      | 2 +-
>  drivers/thermal/samsung/exynos_tmu.c | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
>=20
>=20
> Test HW: Exynos4412 - Trats2 board.
> Build GCC: 4.9.2
> SHA1: e4dc28277205cfb02f8dd96fe694a1bcc2dc41b1
> [I've rebased on top of kernel_linux-soc-thermal/fixes branch at your
> repository]
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVvtKHAAoJEMLUO4d9pOJWrwEH/jEH9Xejdf10s6Pc/cvARXq/
8oolKwCXHmJ3v+iq6gbIc1t/6+uH/XVjRpi7jEomqKqD/bkurs1Z+GKwUilWEs2B
Ada3+x7Z8y3lU7wEzaiWBIOd6Qs8htWGX2CoaZ+D1AXliXanZyZO+2TzfSiNj+fy
o6kbGFtuVipj5Lkui9K6+QFZY0D0w8aLLm4O5rQrqiRCIXCrMA8j0YmuTxEp33mY
tLK4D+ztyswMvmTDnSEGj0askb9MsUxu6Ar7kIXs+kX8TAXhCqdkS1eCVSp7VCiM
9ECI7K1pioyDu1Mn1P94aXcLnYuHPWoQivbZW2P787t7zT665sYYd7z6sIObb/8=
=gdXc
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
