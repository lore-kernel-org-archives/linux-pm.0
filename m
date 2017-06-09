From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v1] power: supply: twl4030_charger: Use
 sysfs_match_string() helper
Date: Fri, 9 Jun 2017 14:27:19 +0200
Message-ID: <20170609122719.sl5gmsztahsa35bj@earth>
References: <20170609120727.21910-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="okwdxljk5l7gjdef"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52737 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdFIM1Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 08:27:24 -0400
Content-Disposition: inline
In-Reply-To: <20170609120727.21910-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org


--okwdxljk5l7gjdef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 09, 2017 at 03:07:27PM +0300, Andy Shevchenko wrote:
> Use sysfs_match_string() helper instead of open coded variant.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In file included from ./include/linux/bitmap.h:8:0,
                 from ./include/linux/nodemask.h:94,
                 from ./include/linux/mmzone.h:16,
                 from ./include/linux/gfp.h:5,
                 from ./include/linux/kmod.h:22,
                 from ./include/linux/module.h:13,
                 from drivers/power/supply/twl4030_charger.c:16:
drivers/power/supply/twl4030_charger.c: In function =E2=80=98twl4030_bci_mo=
de_store=E2=80=99:
drivers/power/supply/twl4030_charger.c:672:28: error: passing argument 1 of=
 =E2=80=98__sysfs_match_string=E2=80=99 from incompatible pointer type [-We=
rror=3Dincompatible-pointer-types]
  mode =3D sysfs_match_string(modes, buf);
                            ^
=2E/include/linux/string.h:155:57: note: in definition of macro =E2=80=98sy=
sfs_match_string=E2=80=99
 #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_a)=
, _s)
                                                         ^~
=2E/include/linux/string.h:146:5: note: expected =E2=80=98const char * cons=
t*=E2=80=99 but argument is of type =E2=80=98char **=E2=80=99
 int __sysfs_match_string(const char * const *array, size_t n, const char *=
s);
     ^~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

-- Sebastian

> ---
>  drivers/power/supply/twl4030_charger.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 785a07bc4f39..2c2d1f457487 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -669,14 +669,10 @@ twl4030_bci_mode_store(struct device *dev, struct d=
evice_attribute *attr,
>  	int mode;
>  	int status;
> =20
> -	if (sysfs_streq(buf, modes[0]))
> -		mode =3D 0;
> -	else if (sysfs_streq(buf, modes[1]))
> -		mode =3D 1;
> -	else if (sysfs_streq(buf, modes[2]))
> -		mode =3D 2;
> -	else
> -		return -EINVAL;
> +	mode =3D sysfs_match_string(modes, buf);
> +	if (mode < 0)
> +		return mode;
> +
>  	if (dev =3D=3D &bci->ac->dev) {
>  		if (mode =3D=3D 2)
>  			return -EINVAL;
> --=20
> 2.11.0
>=20

--okwdxljk5l7gjdef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk6lCEACgkQ2O7X88g7
+prW/hAAmNKgoimqjEa9Ls7tkdeW4LetgSX81CB/7dTBg5zGZWcYhUsHupgWVECT
oP6VRYAM8TR4H2VY2Cg3ijpn72/V4SwZwi6JKeEFKpT11WFOwyL2grSX2H80KHk8
LOIg6eAo+/Dj2JdR1UJxS5rU9FNXboAKYepqmxG90GpbDYMQV1KfVo2OfZXdpDmr
GIEOjsPr/wwoSWdhW1NyFymHu0Ok43E11Zl2FaWu1GX4kbGhZgyLMyThBOipdegv
vREnAvc96VGQRW9Js4SHBiigVSZeAf+IADjgI0B7/cmIeTEg+hTvGE8uyltIvzOX
64HIj3nhlsC/CYlrpKRqNwn5wQsFsqFSDTZDjQ4aC1CwZnwrVlmG3VXfusoGOZjH
hrVaQDVhm9sRE6upxsUV/GlH43InNnZGjjsjVZ3M4c3WE/qhIiFVbsrK6clrs1m3
OqepmpNZNDdO0uhQIrHQz92oa54Kb/MdKMxXNfWpRcnkEmv8gZI5DEBzRagavR36
iaySHxseoz41uaeQaBIpQgjXFqiOQnpaRmtQttlqyhnnSS25hqVsnEKIwt0EJYmr
ejnOGmVC4CynEhaJA9rNqSIx1H0KZ2YrF07vbVhexpwPwruD35biAjL2F5YBIjaz
rjnNxhaeFcmIixEt3AIXmGQqF3/fSDCtpKh/u277TtoGAXQR/JQ=
=gart
-----END PGP SIGNATURE-----

--okwdxljk5l7gjdef--
