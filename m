From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power:ds2782:Fix description error
Date: Mon, 23 Jul 2018 00:09:58 +0200
Message-ID: <20180722220958.2mwhjewqbqvkpkup@earth.universe>
References: <20180718152033.5880-1-elicec@foxmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u2q75aoqqony7tcx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180718152033.5880-1-elicec@foxmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: elicec <elicec@foxmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--u2q75aoqqony7tcx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Elicec,

On Wed, Jul 18, 2018 at 03:20:33PM +0000, elicec wrote:
> After add support for ds2786 battery gas gauge=EF=BC=8Cthe description
> didn't update. fix it.
>=20
> Signed-off-by: elicec <elicec@foxmail.com>
> ---

Thanks for the patch. The change looks good, but the subject of the
patch should be prefixed with "power: supply: ds2782: ". Even more
importantly we don't accept patch contributions, that are using
pseudonyms:

Documentation/process/submitting-patches.rst

-- Sebastian

>  drivers/power/supply/ds2782_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply=
/ds2782_battery.c
> index a1b7e0592245..924e99d1e69e 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -471,5 +471,5 @@ static struct i2c_driver ds278x_battery_driver =3D {
>  module_i2c_driver(ds278x_battery_driver);
> =20
>  MODULE_AUTHOR("Ryan Mallon");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC drive=
r");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2782/DS2786 Stand-Alone Fuel Gauage I=
C driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.17.1
>=20
>=20
>=20

--u2q75aoqqony7tcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltVALYACgkQ2O7X88g7
+ppeDBAAmRlbbbG/Qaf0iJpPrMWJttmw0+H58zy43ADrIc8uJeETvFTJPx6r1P/v
cCsvBGmV3Ia9MTrp+9WJTkBbshw/nFN6GirvtklROwqAfjYuq/hBgjRy0YsRQ6YM
iKCrf4PLuz4d25rMf4a0RiVhuajfbIJDVqjpm16pwMZb9qqw+UZ+PRwJ0LUB0mR3
7rkZeSl81jaxbuHnnus73odf2Iphm/qTAH+kjg7rognjI22ikqj8U0lffpJZqN2h
C9oRldamKY712ci7l5Hxth4ognwdkEB3sib0OFQEv2JdDntVP0wOQFzW0ySah02i
J7Wn3CnZqvBdVJ16CotX5t8ybJSadSSk1//O/F3XXfBV1wdc7N1Xq8WAi6FScx1s
gSuiU3EDMUNDqbQOaUoxF4rchmq1/nVxmN0wexW8p8145XSKPF+hhWX3bhyPHyXu
KfM/LDRM48LxhvPlXqhXTRNOGlP4jOoEFDd59EOSpfI4Bf4sDXue+xN2kLA7c9vJ
1i84bAb8FIoPgF8eOrN1/1I2QEmD8N3l6fLc9kXDrxRl6LJg/c19b1rErxskL5aZ
Wpd23NeaSyRwn24bqZzAnovjjNCH4YCnPuMJJx5UUCu6R5wYG6rLwPs5MhZNAv5e
8TqCGPCV1yhWEbmTv5HBG8z0LxbF0gQ4czYSdIjHl8b5sGxEma4=
=Heau
-----END PGP SIGNATURE-----

--u2q75aoqqony7tcx--
