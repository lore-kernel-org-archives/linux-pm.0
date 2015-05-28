From: Felipe Balbi <balbi@ti.com>
Subject: Re: randconfig build error with next-20150528, in
 drivers/power/twl4030_charger.c
Date: Thu, 28 May 2015 13:46:42 -0500
Message-ID: <20150528184642.GB25787@saruman.tx.rr.com>
References: <CA+r1ZhjGZqh0ZOdkne3Pf1Ht2Vyf3+HzFPzrqVPDMRfiT6prxA@mail.gmail.com>
 <20150528175700.GB31619@earth>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54390 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbbE1StA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 14:49:00 -0400
Content-Disposition: inline
In-Reply-To: <20150528175700.GB31619@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Jim Davis <jim.epost@gmail.com>, NeilBrown <neilb@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Felipe Balbi <balbi@ti.com>

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2015 at 07:57:00PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> [+CC NeilBrown]
> [+CC Felipe Balbi]
>=20
> On Thu, May 28, 2015 at 10:05:55AM -0700, Jim Davis wrote:
> > drivers/power/twl4030_charger.c: In function =E2=80=98twl4030_bci_probe=
=E2=80=99:
> > drivers/power/twl4030_charger.c:648:23: error: implicit declaration of =
function
> > =E2=80=98devm_usb_get_phy_by_node=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> >     bci->transceiver =3D devm_usb_get_phy_by_node(
> >                        ^
> > drivers/power/twl4030_charger.c:648:21: warning: assignment makes point=
er from i
> > nteger without a cast [-Wint-conversion]
> >     bci->transceiver =3D devm_usb_get_phy_by_node(
> >                      ^
>=20
> This has been introduced by the following commit from Neil Brown:
>=20
> power: twl4030_charger: find associated phy by more reliable means.

no, this was introduced by the commit which introduced
devm_usb_get_phy_by_node() (also by Neil) and has already been fixed by
Arnd. I have the patch in my 'next' branch and it should show up on
tomorrow's linux-next.

--=20
balbi

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVZ2KSAAoJEIaOsuA1yqRE7bYP/2oQLjpg2NMmlxoCm/9Ly3a4
+Khb+ulPAR9M6V9refZajybJNtJjFqWvBMCHcfdCuftGzSp7dCs3nPHVdkT3uiSH
zsWScoE4zxcMGZpx3J48tspKXplqkQEETXgSuDmMh5pm1V8mFKia6+VwpLduuIIK
tWOlcS7ET/qOLYv2IAyXXblJIjhpzMRXyvqlXu1CXjS7XkSHTNvcDhu+0zXjQ5Ns
Mckoa+87ou0DJFGEBlp1quCxiD2mkroP63oYe7UXgKrk6xQI9ehcZdxN9QPF5N0/
msRofYy2a7PTdhhqzEX60oXISwrPoZrv4YibRbcmAgIzq/34VLXH4RTCRgYUVUYM
pt7SFvNfpVnQTR5VgmDHKxGKonlgXF067WzsFb9NFDqiKJbs9mj7rFIkPq0+hBnp
oFWR9fyeNIw2FUH/JJBwdUbZkRtv8DtiSR4a9MIAkz7MUd50j6IGetbXQbOLNOg+
oKwgptm4l/9lhBAcxzgqigZVznkB90yzdMP2TzpdYO39OB2M1tsZjstL7bhvnMO5
wOctaQasWYiFyzIBfzBJo7Ys2rtdzm56VOpgv1QJHSSUHtymCun+7zId+tl8dbiu
6r4naBWPSruBLzCmjNwrHJjrHWkjA6m/jthmyzMBJ/llb5f+HQtEAMnVDiPU/ZZl
bmToSVOmdZKPFuEP1ZQc
=1Dkj
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
