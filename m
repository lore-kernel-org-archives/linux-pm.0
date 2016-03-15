From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V7 05/12] thermal: tegra: add Tegra210 specific SOC_THERM
 driver
Date: Tue, 15 Mar 2016 12:54:44 -0700
Message-ID: <20160315195443.GD26619@localhost.localdomain>
References: <1457665825-29837-1-git-send-email-wni@nvidia.com>
 <20160314185739.GA1872@localhost.localdomain>
 <56E7B2E8.8070100@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35279 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934911AbcCOTys (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 15:54:48 -0400
Content-Disposition: inline
In-Reply-To: <56E7B2E8.8070100@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 02:59:52PM +0800, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 02:57, Eduardo Valentin wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Mar 11, 2016 at 11:10:25AM +0800, Wei Ni wrote:
> >> Add Tegra210 specific SOC_THERM driver.
> >>
> >> Signed-off-by: Wei Ni <wni@nvidia.com>
> >> ---
> >>  drivers/thermal/tegra/Makefile            |   1 +
> >>  drivers/thermal/tegra/soctherm-fuse.c     |  11 ++
> >>  drivers/thermal/tegra/soctherm.c          |   6 ++
> >>  drivers/thermal/tegra/soctherm.h          |   4 +
> >>  drivers/thermal/tegra/tegra210-soctherm.c | 173 +++++++++++++++++++++=
+++++++++
> >=20
> > No Kconfig change?
>=20
> Yes, we doesn't need Kconfig change.
>=20
> As discussed with Thierry in [V1,03/10] thermal: tegra: split tegra_socth=
erm
> driver, he said:
> "I'd like to do this differently to reduce the number of Kconfig symbols.
> The alternate proposal would be for the TEGRA_SOCTHERM symbol to remain
> as it is and then build in driver support depending on the selected
> ARCH_TEGRA_*_SOC options."
>=20
> So we only have "config TEGRA_SOCTHERM" in the Kconfig, and in Makefile, =
we add
> tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D tegra124-soctherm.o
> tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D tegra210-soctherm.o


makes sense to me.


--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6GiBAAoJEMLUO4d9pOJWsd8H/AvSPyPqKdDWZ5Mvxkg/NLDW
pVP5iKLW0btUOKBSP31v9T431aGgKXi2EBsHwVakZLTJ0kxmoqAqI4u4pRGtNHNJ
5VgVe+pgw8IXeMYzGqlcIRoMPdRZjiZ4OBzrkX9t1lgD7nQRQsdG9hCA7ec8g2fT
2eT1XlYz8UFSFQfilgwt5jKWOnK2DWvNvu4XzXG8CyDQ07S7jPT5dJzkCD0f9Zj8
MCDQQkTryOBoM5mGD4iVc3jL5XKQTaFGjrzSfAPlWFrcQnKdARtwepndbxwy3FdW
6LxRfxnG43d/jjGSMfeZr9ejJJJuOElys49IpshGfzFYSENSDJISX27T1TWYGR8=
=yDIT
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
