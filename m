From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/3] Fixes for twl4030 charger
Date: Sat, 5 Dec 2015 00:54:42 +0100
Message-ID: <20151204235442.GA22936@earth>
References: <cover.1446463652.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, gta04-owner@goldelico.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nikolaus,

On Mon, Nov 02, 2015 at 12:27:33PM +0100, H. Nikolaus Schaller wrote:
> Changes V2:
> * worked in comments by Nishanth Menon <nm@ti.com>
> * added another patch which solves a probing/boot stall problem (irq allo=
cation vs. -EPROBE_DEFER)
>=20
> V1:
> 4.3-rc1 introduced a new charger driver for the twl4030.
>=20
> While making it operable and testing on GTA04 and OpenPandora
> we have found some issues.
>=20
>=20
> H. Nikolaus Schaller (3):
>   drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
>   drivers:power:twl4030-charger: don't return after allocating irq
>   drivers:power:twl4030-charger: don't check if battery is present

PATCH 1 and 2 should be rebased to my current next branch.
They definetly do not take 2202e1fc5a into account. Also
take into account, that iio_channel_get() is not managed,
so you will have to free the channel, if your return an
error after it.

PATCH 3 introduces a new warning:

drivers/power/twl4030_charger.c:211:12: warning: =E2=80=98twl4030_is_batter=
y_present=E2=80=99 defined but not used [-Wunused-function]

-- Sebastian

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYie/AAoJENju1/PIO/qaJ4oQAJQtrF1EvRG4UBdpT+SCMfGD
lcw/eoPVWb7pXlMSbj0YYMYjeYXMxWpDKHU1zhiDqCIQexaB71xMPqqPRJNnmQMf
JkHEnehwzqNSkI51rISmj2sEXyfXWLmeER+aGFB3GESbh3b/RnHU6TtblXvfen4T
B41ETg+ukWfmC2WFfkNEYy2wseG7f+xp3oL6crT/5EL6DjACroS+f/LR4ORd9DXz
p8xsPBy8nPtroIP+SjsqFSrW7fdmuM2DUet74NI0/EamzlZh21LM5KOxTHw5xa29
pMdO+B2dYoyx5LDgOtcc+Sx6ymWCyNpaEz71tbMSsdE8FYxz6MSuma4o/5Ip4Dm/
Of9pfiNrwRhHmS6bc70XiSXiju80t7MD1/+bygdOd19mcbORx9LQ3/qZ9LDLpIFT
0w/pFZjI8PbI0pGcnElNLtKhSZvwR1sY3t+dumw0JvvHIKLDQCo3je9MSP3ulLOi
S8B9UaLaRb9ls8Uef6hH8K4pJ0NDi75FM8VS2fbKrVOij5z8/YRkItZ2CFDp2cC8
Ndl63O3p1V8xsJilBCh8+YXoBAi9ldYlamWswqyB1AzK7TCCFTuPKee6Mu8/kjdp
ZE4HgnE/b2eIby/8kdmuIeJGK+jPEvBm/r1p1lDEqHnUKg6x/93GZN8U6/PYZH/x
U9bDEaPCbtq6Q1oTJRHG
=I1UE
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
