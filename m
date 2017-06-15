From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v7 01/10] power: supply: sbs-battery: remove incorrect
 le16_to_cpu calls
Date: Thu, 15 Jun 2017 16:49:50 +0200
Message-ID: <20170615144950.hhwmymwm7wdeo2mr@earth>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-2-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nyygz3mmayhtw6sp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1497535178-12001-2-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--nyygz3mmayhtw6sp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 15, 2017 at 09:59:29PM +0800, Phil Reid wrote:
> i2c_smbus commands handle the correct byte order for smbus transactions
> internally. This will currently result in incorrect operation on big
> endian systems.
>=20
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index e3a114e..cf43e38 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -199,7 +199,7 @@ static int sbs_read_word_data(struct i2c_client *clie=
nt, u8 address)
>  		return ret;
>  	}
> =20
> -	return le16_to_cpu(ret);
> +	return ret;
>  }
> =20
>  static int sbs_read_string_data(struct i2c_client *client, u8 address,
> @@ -265,7 +265,7 @@ static int sbs_read_string_data(struct i2c_client *cl=
ient, u8 address,
>  	memcpy(values, block_buffer + 1, block_length);
>  	values[block_length] =3D '\0';
> =20
> -	return le16_to_cpu(ret);
> +	return ret;
>  }
> =20
>  static int sbs_write_word_data(struct i2c_client *client, u8 address,
> @@ -278,8 +278,7 @@ static int sbs_write_word_data(struct i2c_client *cli=
ent, u8 address,
>  	retries =3D chip->i2c_retry_count;
> =20
>  	while (retries > 0) {
> -		ret =3D i2c_smbus_write_word_data(client, address,
> -			le16_to_cpu(value));
> +		ret =3D i2c_smbus_write_word_data(client, address, value);
>  		if (ret >=3D 0)
>  			break;
>  		retries--;
> --=20
> 1.8.3.1
>=20

--nyygz3mmayhtw6sp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCnosACgkQ2O7X88g7
+poXVA/6A/nxV+LMER10EccU0A1y/UY4SCgYuM8Zg61MDgQv6AHxRhjSAozRdCHj
K3je/KE39tyWHStQ36OYAThuGD6SvSkT6SU0wVeUlCjPxPt0fgks0Uomb6lsBF1x
Uh4eK0HSzgmwHOVTVITn8sXXB7FFKYz20mfFw1CGjBuC7NcsP8wW1BK7mJE3ggI1
0nJrWVudJX0Z73g6qoRNWt8itqMiLIMDMh5rVkRIQZ0S+cvUQEuilJ29rmotl4bz
qEfGkbEb3nXsOVYU1PwgBQlO5lAZ7+V7dlSDnYSS6XddmNOMOYjbGrqPvrv46IhZ
C3/GJQIdTALB2CaexdfQlINbsXblcvL9Sg+zXao6xnzOcJ3ZKiyoxWfSGcz6ZOFs
vRvhj/x+1IVBajS8Dv2AiyMrldSXoTjMk2B9XomzHyzhMxVZXaiK4cao8npEVhMi
hTbi2gxuBJMWdGQg5f7XifcJfUc5ILYaJBCsfP7qXnz4+nKjqRREW38ODLvsy2uD
p4PyIut3KRoGG9lBpLEDInhEwXct0V/OWZTU9NiDXmfQlHKKc0unG2x6rqi5yt4o
va2SzyMAR0MgESe5ptrZ8QSYFtDW2FZsggpunr/vwK4JDrZ6Tx+0mmuWbH4riGWH
9iWtF/g6xCupk0Od9H53jyQOcQVAL5XG7QGz0bZatfAd+5q3hio=
=Ojxx
-----END PGP SIGNATURE-----

--nyygz3mmayhtw6sp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
