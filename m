From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RFC 2/5] power: supply: bq24190_charger: add support for
 bq24192 variant
Date: Mon, 22 Oct 2018 00:17:51 +0200
Message-ID: <20181021221751.kaq3tib5mpppoepf@earth.universe>
References: <20181001053005.18906-1-masneyb@onstation.org>
 <20181001053005.18906-3-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2p6wpipfwogpkpsq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181001053005.18906-3-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: andy.gross@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org


--2p6wpipfwogpkpsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 01, 2018 at 01:30:02AM -0400, Brian Masney wrote:
> From: Jonathan Marek <jonathan@marek.ca>
>=20
> This patch adds support for the bq24192 variant to bq24190_charger.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/power/supply/bq24190_charger.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index b58df04d03b3..e3836145286d 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1638,7 +1638,8 @@ static int bq24190_hw_init(struct bq24190_dev_info =
*bdi)
>  		return ret;
> =20
>  	if (v !=3D BQ24190_REG_VPRS_PN_24190 &&
> -	    v !=3D BQ24190_REG_VPRS_PN_24192I) {
> +		v !=3D BQ24190_REG_VPRS_PN_24192 &&
> +		v !=3D BQ24190_REG_VPRS_PN_24192I) {
>  		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
>  		return -ENODEV;
>  	}

This becomes too ugly. Do it like this instead:

switch(v) {
case BQ24190_REG_VPRS_PN_24190:
case BQ24190_REG_VPRS_PN_24192:
case BQ24190_REG_VPRS_PN_24192I:
    break;
default:
    dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
    return -ENODEV;
}

-- Sebastian

> @@ -1931,6 +1932,7 @@ static const struct dev_pm_ops bq24190_pm_ops =3D {
> =20
>  static const struct i2c_device_id bq24190_i2c_ids[] =3D {
>  	{ "bq24190" },
> +	{ "bq24192" },
>  	{ "bq24192i" },
>  	{ },
>  };
> @@ -1939,6 +1941,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
>  #ifdef CONFIG_OF
>  static const struct of_device_id bq24190_of_match[] =3D {
>  	{ .compatible =3D "ti,bq24190", },
> +	{ .compatible =3D "ti,bq24192", },
>  	{ .compatible =3D "ti,bq24192i", },
>  	{ },
>  };
> --=20
> 2.17.1
>=20

--2p6wpipfwogpkpsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM+w8ACgkQ2O7X88g7
+prsNg/9FJgQAeBDQbYwXzFtY/TvKxhxPMjaU8JAKO+DjMWSX/12y7pH/uTPmqOy
wvLQFWF/cLQbb32tvW78PxPkinKX9vcPnxBg9pCE6bsdTQEJk3vvje+fp6kzUYwx
E8oIPJj7bH3F4G0THc0Ii0Dn4yyYLrQJj0EqvEoXDHn+njiF6Lb9qaRLQaLxOqTp
eCfvsLdfVFRjM00KrqC3kC6Pb8DcidVBJAYf34uE91D2/rq49T2L9SPlapTIX+ZL
JISsDI7Kd3yGFBae6nXMXVti6twThBW3cyNJ05soaobohu+dCfqojyKfkURvEuIH
Wwl4+MNnMSDehUQ8oANzODKwnSVaR7jhajSztMn75xpok4GWdEj9QKW+DCWlVrvY
L/Ve6IwW3rE+zo0ZzN91q3wi5zjWIauiZVJhah0k6kyFL9n/9g4q6WgkN93tkKNq
sd61IYqB7VN4AUXnLCQU7LCwF+OnLdCOAH0l2HOrZBsUyOvnjHYlDP05Fi4i7hht
qqnDKiBxJkuSz/p34AFSulhYRZjbGtgE2ybjocob7kJ/+/Eh4WgZhlJdkwoG+UjG
SxHiU6FDyRlP3h/9Z5iN6qwEmtSI/4kNZN+COIU/R9qfgfa3qd4iWDG/zpgauUHn
pQH5JGf/ohiNzw0K+9hKBrYsVDrT9Ps0PJYiMdiysnZtEHJmBRo=
=NAaG
-----END PGP SIGNATURE-----

--2p6wpipfwogpkpsq--
