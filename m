From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: fix spelling mistake "Gauage" -> "Guage"
Date: Sun, 21 Oct 2018 21:33:21 +0200
Message-ID: <20181021193321.nb5yxy6iwv2oih2m@earth.universe>
References: <20181013152727.5520-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="babzsxdsksejuhgu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181013152727.5520-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--babzsxdsksejuhgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 13, 2018 at 04:27:27PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in MODULE_DESCRIPTION text
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued with typo in subject fixed.

-- Sebastian

>  drivers/power/supply/ds2780_battery.c | 2 +-
>  drivers/power/supply/ds2781_battery.c | 2 +-
>  drivers/power/supply/ds2782_battery.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply=
/ds2780_battery.c
> index 370e9109342b..cad14ba1b648 100644
> --- a/drivers/power/supply/ds2780_battery.c
> +++ b/drivers/power/supply/ds2780_battery.c
> @@ -829,5 +829,5 @@ module_platform_driver(ds2780_battery_driver);
> =20
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Clifton Barnes <cabarnes@indesign-llc.com>");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2780 Stand-Alone Fuel Gauage IC drive=
r");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2780 Stand-Alone Fuel Gauge IC driver=
");
>  MODULE_ALIAS("platform:ds2780-battery");
> diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply=
/ds2781_battery.c
> index d1b5a19aae7c..5e794607f732 100644
> --- a/drivers/power/supply/ds2781_battery.c
> +++ b/drivers/power/supply/ds2781_battery.c
> @@ -829,6 +829,6 @@ module_platform_driver(ds2781_battery_driver);
> =20
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Renata Sayakhova <renata@oktetlabs.ru>");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2781 Stand-Alone Fuel Gauage IC drive=
r");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2781 Stand-Alone Fuel Gauge IC driver=
");
>  MODULE_ALIAS("platform:ds2781-battery");
> =20
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply=
/ds2782_battery.c
> index a1b7e0592245..019c58493e3d 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -471,5 +471,5 @@ static struct i2c_driver ds278x_battery_driver =3D {
>  module_i2c_driver(ds278x_battery_driver);
> =20
>  MODULE_AUTHOR("Ryan Mallon");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC drive=
r");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauge IC driver=
");
>  MODULE_LICENSE("GPL");
> --=20
> 2.17.1
>=20

--babzsxdsksejuhgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM1H8ACgkQ2O7X88g7
+pprFhAAmPohgOOtT1okXUH13JGLihrOXrnU/7YvJFRB6TiF2D4wQKUWQ0AtLuvA
FktHhIVa1l3OQ/mhUWqkKHBKfVIsls2EcOrq0dJ/EPVkDLCKcZk9JaaFsI6XzhxK
Z5vQdRS/yQQEGKNMaSu5EEl0M/BKdJuSZ36O4vlJYWYLJXWMGIbnT62174EWg/Ky
tXDHMhZvAP6XAbHbk6QmCVfYC8XNHYB8bFPRMwvZg90UIcqdFnEgPoQ99HbR/O05
5QT2/ubp8W1s/DXUn1uA1g24P/eE02zknRo+f9f81HjWAf6eOYDKEzXHq6FxqSrH
pqRdqEqwfC0eKZO3+sJd9a7Tslma6zemNOr+h5ZWGkTxztkMXs0rLcLeuOkm75k6
D6A2dk/cLb8iwfWx5OxEK9nnXAuFi9wcZ1C+L9GoR5tWqJNysSYy4GILpf3l4e1T
dNDjuKIdbP5PDejL0hVQNQXtJ09OC9r7yp3rwrh8HKPZDEXUeEsAp+d2tsBjWHcx
7NcvgER1l514JWxY0tl+NLl7CaUe/9qgOIRej91vtXRoMDtlbbDZrrG3AwH7TsGh
suc89km51h6xOCeOd8l6YMKh7VPGozZU3Dx9LzaCKouRAS9ZunA3PAjKchwdlgbT
QScY8gC23fciGlcLZ1BhQkp73nY59MdMwUj8pEXQ/2OAv/GVKII=
=tmqS
-----END PGP SIGNATURE-----

--babzsxdsksejuhgu--
