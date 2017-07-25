From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC v1 2/6] power: supply: bq27xxx: Add chip IDs for previously
 shadowed chips
Date: Tue, 25 Jul 2017 14:52:53 +0200
Message-ID: <20170725125253.lr3dko4k3crpih6z@earth>
References: <20170709021700.14354-1-liam@networkimprov.net>
 <20170709021700.14354-3-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ayryj3rmmiaio4te"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdGYMw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 08:52:58 -0400
Content-Disposition: inline
In-Reply-To: <20170709021700.14354-3-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--ayryj3rmmiaio4te
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 08, 2017 at 07:16:56PM -0700, Liam Breck wrote:
> For the existing feature set, these chips act like ones already listed,
> so they had been given false but functional IDs. We will be adding featur=
es
> which obsolete that shadowing, so the following IDs are added:
> BQ2752X, 531, 542, 546, 742, 425, 441, 621
>=20
> So as not to disturb code that relies on the shadowing,
> bq27xxx_chip_data[n].acts_like now gives the previous ID for the above
> chips. That field will no longer be necessary when the code in question c=
an
> test for specific options (to be provided in later patches) with:
> (BQ27XXX_O_XYZ & di->opts)

As stated in the other patch it should be (di->opts & BQ27XXX_O_XYZ)

> No functional changes to the driver.
>=20
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>
> [...]
>
> +	[BQ2752X]   =3D BQ27XXX_DATA(52x,   BQ2751X, 0),
> +	[BQ27531]   =3D BQ27XXX_DATA(531,   BQ27530, 0),
> +	[BQ27542]   =3D BQ27XXX_DATA(542,   BQ27541, 0),
> +	[BQ27546]   =3D BQ27XXX_DATA(546,   BQ27541, 0),
> +	[BQ27742]   =3D BQ27XXX_DATA(742,   BQ27541, 0),
> +	[BQ27425]   =3D BQ27XXX_DATA(425,   BQ27421, 0),
> +	[BQ27441]   =3D BQ27XXX_DATA(441,   BQ27421, 0),
> +	[BQ27621]   =3D BQ27XXX_DATA(621,   BQ27421, 0),

Let's get rid of the chip id mapping directly. I deleted everything
but the mapped IDs above. This is what I get for a simple git grep:

drivers/power/supply $ git grep -nE "BQ2751X|BQ27530|BQ27541"
bq27xxx_battery.c:204:  [BQ2751X] =3D {
bq27xxx_battery.c:384:  [BQ27530] =3D {
bq27xxx_battery.c:404:  [BQ27541] =3D {
bq27xxx_battery.c:786:  BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
bq27xxx_battery.c:795:  BQ27XXX_PROP(BQ27530, bq27530_battery_props),
bq27xxx_battery.c:796:  BQ27XXX_PROP(BQ27541, bq27541_battery_props),
bq27xxx_battery.c:1523: case BQ2751X:
bq27xxx_battery.c:1532: case BQ27541:
bq27xxx_battery.c:1535: case BQ27530:
bq27xxx_battery.c:1548: if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27=
421)
bq27xxx_battery_i2c.c:232:      { "bq27510", BQ2751X },
bq27xxx_battery_i2c.c:233:      { "bq27520", BQ2751X },
bq27xxx_battery_i2c.c:242:      { "bq27530", BQ27530 },
bq27xxx_battery_i2c.c:243:      { "bq27531", BQ27530 },
bq27xxx_battery_i2c.c:244:      { "bq27541", BQ27541 },
bq27xxx_battery_i2c.c:245:      { "bq27542", BQ27541 },
bq27xxx_battery_i2c.c:246:      { "bq27546", BQ27541 },
bq27xxx_battery_i2c.c:247:      { "bq27742", BQ27541 },

Ignoring the chip data defines, that are not affected, this leaves
the following affected lines:

bq27xxx_battery.c:1523: case BQ2751X:
bq27xxx_battery.c:1532: case BQ27541:
bq27xxx_battery.c:1535: case BQ27530:
bq27xxx_battery.c:1548: if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27=
421)

FWIW I do not follow you, that introducing the flags for
those is more error prone, than the ID mapping. If you
don't want to add the flags please just add the new IDs
to the check in bq27xxx_battery_over/undertemp().

-- Sebastian

--ayryj3rmmiaio4te
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3PyIACgkQ2O7X88g7
+poI7w//Zr9P0DXZfvADwFQGR8KiosnErid05QfOKKONwJUDOGuBXn6u4CbqkPY+
y66LkNGUh+Il35T6jLC1DeqbEqm/4KmAx0NY+otKeEZA4kIrZAl5ImtKiKLnLILE
32TJjfS5MHKK3M3uay6RztfmiJPLYfMeE+n9n6CxfKy+rGZQSS/ftgvRAKX8At1g
4qVuhsLcDSe+EXNe8MeVSYagGa43d6/2kzEUxFq60vdNg86vqbE60SdEBsIPOxFY
9ON/r5mWmeHRqULov27b8bzSx8FdhCE/Bwq0Pwwblrf0H0+bcayS46EuoUSMwa2R
COy5WHPx6qAtTIKnc6ALY/Ghz1X/i1AHNjbYcxO20zZd5gvShHytCmr7XexfEAlE
paTqo+pe3yDmZJlEH4D7jkGVq9C2plFds/E3oM18fAetPeVlertF/X6X7+4glagd
3kkP8c78T58CthM2/rQQK4J/h1FyNrGw7gm0lBNMp8yMa3HHBmRZv3dGzW6wyY0f
vz4N+O9UXfLwB+lMnsqQ0mv4CVKEuCLxqBolL/ckiZaZ+oHB2XGSoL8BejaB2f5l
yY3oUUkeWCqE4mAQuCl2UD5/j14EBdpkmoi/T6bG/ppeq/0SWvciQemIhL35rf8a
eZ/dONTa4xSr9wy/qYm1cWk3LnmR/6nK1Ub/1wDwr09Rg2JGSNU=
=gqCL
-----END PGP SIGNATURE-----

--ayryj3rmmiaio4te--
