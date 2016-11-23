From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: bq27xxx_battery: Fix register map for
 BQ27510 and BQ27520
Date: Thu, 24 Nov 2016 00:08:33 +0100
Message-ID: <20161123230832.anbbhmllij4bxpsh@earth>
References: <20161104183313.2767-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ahqvslonff3ncfa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104183313.2767-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5ahqvslonff3ncfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 04, 2016 at 01:33:13PM -0500, Andrew F. Davis wrote:
> The BQ27510 and BQ27520 use a slightly different register map than the
> BQ27500, add a new type enum and add these gauges to it.
>=20
> Fixes: d74534c27775 ("power: bq27xxx_battery: Add support for additional =
bq27xxx family devices")
> Based-on-patch-by: Kenneth R. Crudup <kenny@panix.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 41 ++++++++++++++++++++++++=
+++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  4 +--
>  include/linux/power/bq27xxx_battery.h      |  3 ++-
>  3 files changed, 44 insertions(+), 4 deletions(-)

Queued into for-next. I think pali's hint, that bq27xxx_battery_overtemp()
should be implemented using a switch-case is valid to make the code more
readable. Please provide this change as follow-up patch.

-- Sebastian

--5ahqvslonff3ncfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg2IW4ACgkQ2O7X88g7
+poLgxAAnWdcav/ac6CcwRqJ079RI0tN6yE6yI/BUWTdtb0EanHLrYt2vfTnU2YZ
1E6La51RicPUZHopS9BJx/kov/yJOZYe5jheK9GngzPRdpftJTiSh+5KA86IoX8p
fU4+YM4B+qFui9Y3uFeWrUSX2Z74hXX/9detq0vPSTlTWkvYwkuU8upUimrEMg2O
/h5Agi1P82QE8tKQTbgVgRVihGAmbTjUVNoY5LYjILgnmDokE39g+6w6HnmUyB8a
U3u3IPk22xYhUz485LDFnBt/qgXFISMEgpt0BZzhnH50rChcoOFUlgVlUq8ORVev
ZE7E/Y2fZ+lV3iZAJshUMpNXANI1Dz7UffqaVz4nmhj7oGHO/XiS0kYLYehoJyR5
+lpCbeSDy/tm/RtWcM5jrS7BfinlgP/rkYhs0iVuzMVCfmdfGeW+cCQRSl/Pqdmv
LIcoSOVsfhFUiwnR/LyHIzkFyhYSetBmho7VaYKw3D4QvPwcBEDgtgOkbkPguCYo
l0G84VrfnMaTA5hMNyXu2QASstatnIvhfkDf38MXVb4zFmQnwfi0SVcyG32ddwEj
xBuUDMJlGNJbboJMPrigabfJJlymublPWIckM8tn158tUVXWPrlHabJrdYlYsYlc
XqDYyO1urfNGS9H3JtOulDlfkWTzXJiJAsXzRUdI5xAGPAfleIM=
=mRYe
-----END PGP SIGNATURE-----

--5ahqvslonff3ncfa--
