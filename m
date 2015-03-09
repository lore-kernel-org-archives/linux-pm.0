From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 1/2] power: rt5033_charger: Add RT5033 charger device
 driver
Date: Mon, 9 Mar 2015 11:10:12 +0100
Message-ID: <20150309101012.GA3914@earth>
References: <1425864191-4121-1-git-send-email-beomho.seo@samsung.com>
 <1425864191-4121-2-git-send-email-beomho.seo@samsung.com>
 <20150309015020.GA941@earth>
 <54FD177B.1050200@samsung.com>
 <54FD2766.2090401@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54653 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736AbbCIKKa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Mar 2015 06:10:30 -0400
Content-Disposition: inline
In-Reply-To: <54FD2766.2090401@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lee.jones@linaro.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2015 at 01:53:58PM +0900, Beomho Seo wrote:
> >> remove the special handling of POWER_SUPPLY_PROP_CURRENT_MAX in=20
> >> rt5033_get_charger_current() and do it like this:
> >>
> >> case POWER_SUPPLY_PROP_CURRENT_NOW:
> >>     val->intval =3D rt5033_get_charger_current(charger);
> >>     break;
> >> case POWER_SUPPLY_PROP_CURRENT_MAX:
> >>     val->intval =3D RT5033_CHG_MAX_CURRENT;
> >>     break;
> >>
> >=20
> > OK. I will change comply with your comment.
> >=20
>=20
> RT5033_CHG_MAX_CURRENT is register value(hex).
> So It is better:
>=20
> case POWER_SUPPLY_PROP_CURRENT_MAX:
> 	val->intval =3D RT5033_CHARGER_FAST_CURRENT_MAX;
>=20
> And then I will fix rt5033_get_charger_current function more readable.

Right, I copied the wrong value.

> [...]

-- Sebastian

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/XGCAAoJENju1/PIO/qayCIP/0JatnmGnRc5UpVDKGtAFxaJ
IETP03Rn7zFdfKl0Qbj7GUWPR4JNsxwU+LvQrx2e69q/qVLfJoionouEiHatEJVZ
ibkKYQ2OVYgrbQCV5PAAi2A5EPvmW2L9aiQXMBaWTscZnGeSNP7PP2JdNZKxpzmE
0EjhI1NB9fMMjD7aJAfQ6JyoCqwyMvjC4r1pIYOL7m9mZVabmxCQZ/F5M07+jmEL
7kKcXUkOv/xkSwwb0oLXUVLgNj6QEeFPJqSWkB+609vsPUP4Iim3d1zrm2fVq8UC
pNDIK9vGNfO2elQ2JuZ9vqvHhqxVnq0Grjun6FRNr0WSnuNeKsyWpnURSRnYneK2
RxX1jypObnnnwVrxFIpS6ORDhn+ZtVcNpSr+5azzDakwmgNGiVmiDHHN9+HUQxG3
87wP5MssD+pCxb2zXH8tK8uvCDSLJRNug176VBL4yXlYgZCPhFSONnJ4HLHxziU+
R+6CLZ3nF+mXnV9YkOJrIHAOgDKi+PeJ0aGH447MLYprXE7e308ebfTCFSBuql53
vty5UJVqIywqEKPhcJwew3uafezdB1ItTBBKB7hHBPbORaT075/GyBnKBknxvywf
iGMbZ6KoTtNCc1DHu6ITeY8XZJg58koo1R11sNK92jtgEjuVTn4H8Wv/Kp19o6S5
o3SlpOB7pdjJleG7zVYV
=N34s
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
