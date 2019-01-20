From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: remove some duplicated includes
Date: Sun, 20 Jan 2019 22:39:45 +0100
Message-ID: <20190120213945.23lf5whwqrcbatg3@earth.universe>
References: <20181226165357.6426-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwcs2pxufa3ede2t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181226165357.6426-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--fwcs2pxufa3ede2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 26, 2018 at 11:53:57AM -0500, Yangtao Li wrote:
> We include of.h twice. It's unnecessary,so
> just remove them.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index e85361878450..529721660e68 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -156,8 +156,6 @@ static void power_supply_deferred_register_work(struc=
t work_struct *work)
>  }
> =20
>  #ifdef CONFIG_OF
> -#include <linux/of.h>
> -
>  static int __power_supply_populate_supplied_from(struct device *dev,
>  						 void *data)
>  {
> --=20
> 2.17.0
>=20

--fwcs2pxufa3ede2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6qEACgkQ2O7X88g7
+prp7g/+P9I8U3fsbBWFa/YCdJjqUsDmn/l8K625J+BK21zRwbDTSPqtSVkDWY8s
5cd8opLYw1UqQgsr5z1oXCJORFm/1cY8C+avHx8kbFiLa07P12iJGGELeFYaX/NM
zxXWx8YebVVf4blbsLcu/z7VkI/KXW8MhmbIMDPEU9cfBri0/ssNmP+CfPgvhFmb
M5XbfO6YBqRhcVRAiSSY8yKpk3xg5m2eMjhIv4hdtFtbjotaen3BXDpg0+9IhO4I
gQjFn9fWOlgiP4fAppwabJ596BDTCAUClYGl+bBW2h3F72U8dao5flkVlrvY7tUD
LCnBZTSVBGJi0AuI+H9vATtbHjDKXfG0Fc3zErHco9DxUO/7wLnEhQ+3WiO0NvMB
BFMfONS5tTCASmIVR76PrR2QW0yBV8GuTfQ6toorLhAQWQIzwQdMx9qoaQz5cM9p
7hp6oe+NwbBvttD9yALfgkGc2iudhs1id9FrJL5wlU772L88SbG3KlC6vX7szIYC
icg1K2q0lh8WngVf6jGk759vv1o0gX65609N/eQFFX4O11yOZj1E0tixf0qFAANt
qrmuoNv23jiWk4um6vmhmh+DeChdeBk16+i79nyZKoO3ghxC9lNN5vKTL7FIVZml
jQ8ndgCTLUKAJA6bQzmZqbl2eK3lkfm2biNQGj6tSSS6WEZNI4g=
=FTJ/
-----END PGP SIGNATURE-----

--fwcs2pxufa3ede2t--
