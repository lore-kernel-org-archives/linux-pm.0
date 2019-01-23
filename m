From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 4/7] power: supply: olpc_battery: Move priv data to a
 struct
Date: Wed, 23 Jan 2019 21:54:53 +0100
Message-ID: <20190123205453.f7zdvfv5dgxwzmsy@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-5-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl3o2g26527t362l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-5-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-pm@vger.kernel.org


--sl3o2g26527t362l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:02PM +0100, Lubomir Rintel wrote:
> The global variables for private data are not too nice. I'd like some
> more, and that would clutter the global name space even further.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

[...]

> -	ret =3D device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> +	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
>  		goto eeprom_failed;
> =20
> -	ret =3D device_create_file(&olpc_bat->dev, &olpc_bat_error);
> +	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
>  		goto error_failed;

Could you create another patch, that converts this to use the
functionality introduced in cef8fe6a382c? I missed the
device_create_* functions and you can actually test the change.
An example for such a conversion would be "711aebcfe3ba" (ds2781).

P.S.: This is not mandatory for applying this patchset of course.

-- Sebastian

--sl3o2g26527t362l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI1J0ACgkQ2O7X88g7
+pqLLw/+MA5CoVRhd+/0NbpJHzrZq5JNa9HigOsWWf0vMXxCpT7lvoOR5JqJibob
TPIKlZ1T3VVmTKEhPnIhJt/3zWKZJslm+o7FOn2UvPwKPB10SI2ia1ZzBaUCtc6U
S5bhBYg2yV/mmIzKmuwSjfcJJ0yrcj15jZT7LNJ2IX+TlhI8JU9av0vHVt/RlRtU
ov4/JTqnONlQUyEhiHT8iBqWz0EB3v0E9Op43Q7Ch4oxWIw8Q8cNuuxdenF0GURU
VO96AwXjWwzc4hHw4PAoB9gRa+NrnrTHrZ2J62Y7TQR5XBF5x8iDyCENcYiblFhM
iftkVvn2sOoDoRAp1djNpL+AQg8vObGiIfKkrAUImqR2FAPlc9AK/2+h+NJd58zD
9E2FReqELETZvslyC/XsHXSJEHLaQHnsergoWAUbEUJoxQ8PJiEOmZRpSIVezH6A
WkQYbgbA0UqMuF9g7earDTmd9Oi8BzR7bIvctWkE/+JPEFV9XvTMemnAL0zOTU6M
0jeBkw6uAxMcF+JjXeRUTYzHCVp64t5SYwHeEbr33ZzAI+YA3H/J8/YGLFAu4xX7
5bE1DMAlBCBIneFqZ1xLL4a0ADUzSMDw7cm8SlrfUse0E73AKt2lifKEnOKsSEtE
2H4aPjRaHCXW4Rxqr/WWfiAjLZdHSZ/nEkyzav+WWyizBGTQ+8A=
=Gkee
-----END PGP SIGNATURE-----

--sl3o2g26527t362l--
