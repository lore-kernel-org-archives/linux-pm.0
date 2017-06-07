From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: ltc3651-charger: fix some error codes in probe
Date: Wed, 7 Jun 2017 22:15:18 +0200
Message-ID: <20170607201518.qkamfjftnjfv5za3@earth>
References: <20170518074346.flhmb7xi6m7j2cni@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="djbdymxwysspb3xs"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbdFGUPW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jun 2017 16:15:22 -0400
Content-Disposition: inline
In-Reply-To: <20170518074346.flhmb7xi6m7j2cni@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org


--djbdymxwysspb3xs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 18, 2017 at 10:43:46AM +0300, Dan Carpenter wrote:
> There are several cut and past bugs here.  ltc3651_charger->charger is
> NULL at this point, so we return success instead of the intended error
> codes.
>=20
> Fixes: c94d4ed017ae ("power: supply: Add ltc3651-charger driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, queued.

-- Sebastian

> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/suppl=
y/ltc3651-charger.c
> index 5f8d5c0b5721..eea63ff211c4 100644
> --- a/drivers/power/supply/ltc3651-charger.c
> +++ b/drivers/power/supply/ltc3651-charger.c
> @@ -110,21 +110,21 @@ static int ltc3651_charger_probe(struct platform_de=
vice *pdev)
>  	ltc3651_charger->acpr_gpio =3D devm_gpiod_get(&pdev->dev,
>  					"lltc,acpr", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
> -		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		ret =3D PTR_ERR(ltc3651_charger->acpr_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
>  		return ret;
>  	}
>  	ltc3651_charger->fault_gpio =3D devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,fault", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->fault_gpio)) {
> -		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		ret =3D PTR_ERR(ltc3651_charger->fault_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
>  		return ret;
>  	}
>  	ltc3651_charger->chrg_gpio =3D devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,chrg", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
> -		ret =3D PTR_ERR(ltc3651_charger->charger);
> +		ret =3D PTR_ERR(ltc3651_charger->chrg_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
>  		return ret;
>  	}

--djbdymxwysspb3xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4XtEACgkQ2O7X88g7
+ppetBAAi9FBJYI/DAXuTpFnuSSzrHL/4DL6/lAOG4jRg66IisfFK5ny8Ipytweb
Y1J/yGTyee6HuY1Fcl5KqJwGUYz9Q4Qxw0vWPIjTL0Q5HJB64yusnPRQtkyu14Es
ZDlxYm0Wu0xPaeXqkgPedRCWkgKKb9LqSYd2vQICQT7aml50SC5f6rGlhEpNMtlS
7xKOfk9j1J3Osblj2KqAJeky8WYi5rANi+HT3xAD524QKxfE5O0lYj/TKhlDDUy5
Yj3fJuJqwrKgnS87o5YET39LriKym0EVNefEH0iaKW1KpjgjKenCzZzWTs1NG887
OjB7tyuVdd6r3MDTjsfzO0eRJ7AxfoTzV1CRokKyER/5RUkWJg6WZ3LYnKsAGo8Q
jFpY3nPhkzVnT/24rnMMANxyuNbau/DnF6KJx91fEi2MhDc53RL8Ccn8WScbUzft
/+9u9Qk0OYXpqlZfLM3ox1pVaTiS+C/qoPHnxAhfYRpZ3IVxBFyLXQZmiL1RXnb7
JL0r3CxpgNM0JKKEo6YFGqZRCB3SjGTCxN7PA8AOpLvb6e1M5HuhDq8WS0k7J4sp
dFl7iG+FNFgZgDiZFt1VZILXuR7uQYDKFrF1a2c5byfxzaBdoL0GSDgqiMsp5h5r
zhzNBE9qA8mdNA6Vfw1xvXuwBxG3Mwyjb+Jop/HXf4omUxQFDLs=
=RbkU
-----END PGP SIGNATURE-----

--djbdymxwysspb3xs--
