From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/6] power: supply: charger-manager: Remove unused index
 counting
Date: Wed, 5 Dec 2018 21:35:25 +0100
Message-ID: <20181205203525.esixfieniu23ruz2@earth.universe>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qrqkv3azaphkhj2x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org


--qrqkv3azaphkhj2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 07:01:08PM +0800, Baolin Wang wrote:
> Remove unused index counting.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index faa1a67..a1b420a 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1687,10 +1687,6 @@ static int charger_manager_probe(struct platform_d=
evice *pdev)
>  		return -EINVAL;
>  	}
> =20
> -	/* Counting index only */
> -	while (desc->psy_charger_stat[i])
> -		i++;
> -
>  	/* Check if charger's supplies are present at probe */
>  	for (i =3D 0; desc->psy_charger_stat[i]; i++) {
>  		struct power_supply *psy;
> --=20
> 1.7.9.5
>=20

--qrqkv3azaphkhj2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwINo0ACgkQ2O7X88g7
+potFw/+IgdhInsmVk/dBumK+yPfyqfpBDlXoilgO5kLiLwk9Bus6GmzIEmm4K2P
JShf+M/zk3Kqk/dkkLSG4A72/7GQEo+WT/Bn8ZCAsVToTemKd5775QV4hlkexhfs
wPPmjR4d26wimh7ORBci2q2xMCrQ6cFQbf0O4Fbd4tQK0ZYYPZjwPe3olzqfId4S
z5waI3TL5ORBxo0drWXRw/wm8j2wX/372EseFBLAwDBGZpsGZJCT7i0gGrQwoVXf
xr4Jbz/q2IRhRBsXq4RF/DqezvS3HpfZsClS0mVdoxNYeKD1nP56ecAshUCDbwTf
TlN8+s6V2AT/CJ0JmsASDO8WTOa2OjK68s1ckju1jHZ98DShtgzLCJIQx0FEM5T8
BRvutE3ySUYESYkvJJ+4Myj0vi8DDh+S6iJrENRdKewuxozmIUL4QHyKbK2HAsiZ
djOtnjjgSJZG5FLPEKqJjGG2xtLfKJLYO8NgG5mVL9aHO2+8udQSBOOISo0aQKFm
4gpWtm+B00jZs4eb50CnPM7/zD/yS6nGlFTRRlBLN4T7bxmwKpXMuSzGXsvZQ2Rq
P3wHyOcBV1l66SW5xDu6ulx7c0uTZHhi1DCD77USv9cL7xKBUPGlK+dTe320xQ1R
5uTYie7oFHtMmxCxc9cUb5YsVpJa1qatXaHMAj/oOoAajlilA1o=
=xCBV
-----END PGP SIGNATURE-----

--qrqkv3azaphkhj2x--
