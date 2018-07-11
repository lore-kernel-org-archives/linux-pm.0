From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: adp5061: Fix a couple off by ones
Date: Wed, 11 Jul 2018 12:04:18 +0200
Message-ID: <20180711100418.p2t4mfvgyjbzrxwy@earth.universe>
References: <20180711075808.gpa3362vbins7crx@kili.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2y7tqp2z4gc4cr77"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711075808.gpa3362vbins7crx@kili.mountain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--2y7tqp2z4gc4cr77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 11, 2018 at 10:58:13AM +0300, Dan Carpenter wrote:
> We end up reading one element beyond the end of the adp5061_vmax[] array
> here.
>=20
> Fixes: fe8e81b7e899 ("adp5061: New driver for ADP5061 I2C battery charger=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, queued.

-- Sebastian

> diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp506=
1.c
> index c00a02ef7424..939fd3d8fb1a 100644
> --- a/drivers/power/supply/adp5061.c
> +++ b/drivers/power/supply/adp5061.c
> @@ -266,8 +266,8 @@ static int adp5061_get_max_voltage(struct adp5061_sta=
te *st,
>  		return ret;
> =20
>  	regval =3D ((regval & ADP5061_TERM_SET_VTRM_MSK) >> 2) - 0x0F;
> -	if (regval > ARRAY_SIZE(adp5061_vmax))
> -		regval =3D ARRAY_SIZE(adp5061_vmax);
> +	if (regval >=3D ARRAY_SIZE(adp5061_vmax))
> +		regval =3D ARRAY_SIZE(adp5061_vmax) - 1;
> =20
>  	val->intval =3D adp5061_vmax[regval] * 1000;
> =20
> @@ -344,8 +344,8 @@ static int adp5061_get_const_chg_current(struct adp50=
61_state *st,
>  		return ret;
> =20
>  	regval =3D ((regval & ADP5061_CHG_CURR_ICHG_MSK) >> 2);
> -	if (regval > ARRAY_SIZE(adp5061_const_ichg))
> -		regval =3D ARRAY_SIZE(adp5061_const_ichg);
> +	if (regval >=3D ARRAY_SIZE(adp5061_const_ichg))
> +		regval =3D ARRAY_SIZE(adp5061_const_ichg) - 1;
> =20
>  	val->intval =3D adp5061_const_ichg[regval] * 1000;
> =20

--2y7tqp2z4gc4cr77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltF1h8ACgkQ2O7X88g7
+pr4dBAAg7979N/X+zW3Pki8PNMR9SSiBEjTVg1Ul27hbS5O326rMBRARiWdabPv
LnofakYcx0CMDBRhJAAe0HIpzG6gFu+8MN4mY17IwD8GVk3eiHb83DQB0gKhp78+
jFKMF7DeJwQbRmKkk73nXyw7eliVhwJXD3T4dNTispJhgyYHOHYiQy0bDHX6ZdO/
Czk9F7vcdZt55glN3O+8wLofNMYpgg/vJTM8u9Lr58jCGnTyeLaQWk6jhKqeAuPe
95r62972SpdRFiaukBWJ5WV6zvVUmvS9YV3Avia3gcGeNgI90A0EEPYAoPouzNMz
hK+2eT0480As347XSotFbC9AtBRoIjvPD0XJDnbbVLCc5Xxz3fgX9fB4PLxcSRXt
hJAp0T8+NEEu6P/JdyCjpUpp+yOoaURWhGkBexFHTxTddcjFASSzYeEXXpiWm5KD
Dbv/MP+TDFDMx6CP5SoGfjHUnJV7k0CPOOCdG4edYfAEFZM04VnxH8RWhyEd3xWi
nV8AAb96ReH2l1zNI0VDxzgoMiTZ+MVYtzPd6egdE5WG6Cin3SIZahJ8BaKLLE6O
bV7whatfzPo4b54S3VP8JVye/aaoMvDD2SwoyNaQVuLx4iTIaxoQm5MR8AS4F20s
bkYH8Q69zuPAk9FhOb8zxiM2QaoLlBXWfh4SxTyTQaKvZZ/O8xk=
=xmKy
-----END PGP SIGNATURE-----

--2y7tqp2z4gc4cr77--
