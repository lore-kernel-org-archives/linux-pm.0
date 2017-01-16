From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] drivers: power: supply: Compress return logic into one
 line.
Date: Tue, 17 Jan 2017 00:42:19 +0100
Message-ID: <20170116234219.nkwgpyb4wyuq4ozq@earth>
References: <20170112022935.GA22272@embeddedgus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5essvq2vg3oilkjb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdAPXmY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Jan 2017 18:42:24 -0500
Content-Disposition: inline
In-Reply-To: <20170112022935.GA22272@embeddedgus>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--5essvq2vg3oilkjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 11, 2017 at 08:29:35PM -0600, Gustavo A. R. Silva wrote:
> Simplify return logic to avoid unnecessary variable assignments.
> These issues were detected using Coccinelle and the following semantic pa=
tch:
>=20
> @@
> local idexpression ret;
> expression e;
> @@
>=20
> -ret =3D
> +return
>      e;
> -return ret;
>=20
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/power/supply/ab8500_btemp.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index 6ffdc18..9b01b52 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -123,10 +123,7 @@ static LIST_HEAD(ab8500_btemp_list);
>   */
>  struct ab8500_btemp *ab8500_btemp_get(void)
>  {
> -	struct ab8500_btemp *btemp;
> -	btemp =3D list_first_entry(&ab8500_btemp_list, struct ab8500_btemp, nod=
e);
> -
> -	return btemp;
> +	return list_first_entry(&ab8500_btemp_list, struct ab8500_btemp, node);
>  }
>  EXPORT_SYMBOL(ab8500_btemp_get);
> =20
> @@ -470,7 +467,7 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500=
_btemp *di)
>  static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
>  	const struct abx500_res_to_temp *tbl, int tbl_size, int res)
>  {
> -	int i, temp;
> +	int i;
>  	/*
>  	 * Calculate the formula for the straight line
>  	 * Simple interpolation if we are within
> @@ -488,9 +485,8 @@ static int ab8500_btemp_res_to_temp(struct ab8500_bte=
mp *di,
>  			i++;
>  	}
> =20
> -	temp =3D tbl[i].temp + ((tbl[i + 1].temp - tbl[i].temp) *
> +	return tbl[i].temp + ((tbl[i + 1].temp - tbl[i].temp) *
>  		(res - tbl[i].resist)) / (tbl[i + 1].resist - tbl[i].resist);
> -	return temp;
>  }
> =20
>  /**

Thanks, queued.

-- Sebastian

--5essvq2vg3oilkjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9WlgACgkQ2O7X88g7
+pqGIw/6A4djm9aTM0eM4wkiaxI+P2pif9O5pr/Rxapb/BSLA0Yt6pcikquuzUch
orw/seT/6/4cWfuoeym3cXSJiudm/qOuHLBZZ8ydY9Nt2q4RW+slls6a2NdM8bMN
Bbssqff1JtBqgvCUF0ab3Cov2MpF0sdpHu/vvxpae0jJ1Hi4mA1AOiwi+RVKe0CQ
S7SLhevlTyKLVBPXSGTn42aE/7LYCagdIkNimoZ5G2BeOisOdHL1H6R4cOQstLeE
/C31rAxfPHU0Bf+5xnNUlMH55Qh7ySHxBUkFtON3AOqv/K8V3X+Fl0fnFudPBFHt
wfDo+PEGaMxMqcGKxv5F2+bjB6nfVghG91WDYxB2h68yyTde/KIzL1pfKT3b1JfN
RVhlDzRJQbDZ4rdWQrFRl5E5RxI6jE/OFiWu4dXwNIr/ARDwQ8Ir9Mvy3bLi1XpG
CPgQi5yh5Lb22ilMGhcUMbe2qpHzIdOjXPGjUhCG+Rq+MwAFgLykp9t6AVLDyX1A
zxR4lh92En15YJGbncnOTgyFt7svDx3VS0E7oGin4Mu3kZxjJqN+lC0MipzwWkuh
cE8RdGUcuN3mGVCMIHPz+KQlVbjrHqFeB9fyQKIPe2za7Un3UzLl7FJdX1XW1ddq
gYqAbA1qhqn3yhZUld/84LUTzY+G2PUjDbYhtzzRdkJBxcMmJ1M=
=Ykq7
-----END PGP SIGNATURE-----

--5essvq2vg3oilkjb--
