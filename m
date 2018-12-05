From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 4/6] power: supply: charger-manager: Make code more
 readable
Date: Wed, 5 Dec 2018 21:36:59 +0100
Message-ID: <20181205203659.zq2fprcfwb6mpgfg@earth.universe>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
 <12b1b583c3da503be4ad7bed01e7b07a0a2b2126.1542362262.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yw56n3u67lc54tuf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12b1b583c3da503be4ad7bed01e7b07a0a2b2126.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org


--yw56n3u67lc54tuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 07:01:11PM +0800, Baolin Wang wrote:
> Make code more readable.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index a52bc77..dc0c9a6 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1520,19 +1520,19 @@ static struct charger_desc *of_cm_parse_desc(stru=
ct device *dev)
>  	/* chargers */
>  	of_property_read_u32(np, "cm-num-chargers", &num_chgs);
>  	if (num_chgs) {
> +		int i;
> +
>  		/* Allocate empty bin at the tail of array */
>  		desc->psy_charger_stat =3D devm_kcalloc(dev,
>  						      num_chgs + 1,
>  						      sizeof(char *),
>  						      GFP_KERNEL);
> -		if (desc->psy_charger_stat) {
> -			int i;
> -			for (i =3D 0; i < num_chgs; i++)
> -				of_property_read_string_index(np, "cm-chargers",
> -						i, &desc->psy_charger_stat[i]);
> -		} else {
> +		if (!desc->psy_charger_stat)
>  			return ERR_PTR(-ENOMEM);
> -		}
> +
> +		for (i =3D 0; i < num_chgs; i++)
> +			of_property_read_string_index(np, "cm-chargers",
> +						      i, &desc->psy_charger_stat[i]);
>  	}
> =20
>  	of_property_read_string(np, "cm-fuel-gauge", &desc->psy_fuel_gauge);
> --=20
> 1.7.9.5
>=20

--yw56n3u67lc54tuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwINuoACgkQ2O7X88g7
+pqhzhAAh4hcHrQcux8bqcUeITGftj52XkGN6+5U9mO5rOl1Iwspm5vGT0rbiSjX
tbssF7pDuZaeiNlJLYSvrcZB5NocDZ6ke2w/htnWCKMrmDW8Y06FO/eSiN2t3Ni7
Rmcp7sZaDz5kUMV8LYN4lx5xIBEipaChTVUniLCWeJcca91AYoG5T4qLJV/HSDX3
/YTaJT2ivk71rYcPvb+KO2mYkTZZKXScdh1QB70XLXAso+HzojhOleT/cqGgw5IJ
kIQFUbUBhMQiiHnYdUej68YzUnnpvL1qLC/UR3MOjDCV+/JN+rt4niTl0iHO6oIL
TMSZh2y9Ga4sW0hKteE3KFKZKjlNNwPbl2PhpDyG2slls6mTKRgVdt559w96/g6K
4vF7QeUG6sh90g918gMwDS9SZANqnv7GYJrwhf6TXpFG0SlEXxAX19pDSqsAUx2U
PLwC4rChH8YEvHUyJfHIl+ozUj3JBrizWuRUiiFD3n3MPkfM19ugy8WEAD9xfhxG
cNWScXlxQP5J7Zu4ORxwAa2jaBmWH2mDO0u8b4m8bDApiynKP6B4IIctQzFshFS9
6vei+qZTQbrt7DxeNQGlsDS9J3nFL7TllwCETtOJxOcXsWqYlQ5eIUgnrYp72Z2K
mpxb2RLq1py1S0L4hKCVNLa1Ybj7JdMHZx2jzr5HfTgX1AtspgU=
=29lh
-----END PGP SIGNATURE-----

--yw56n3u67lc54tuf--
