From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [patch] power: supply: lp8788: remove an unneeded NULL check
Date: Wed, 19 Oct 2016 05:38:03 +0200
Message-ID: <20161019033803.i4z65zpttyz2asft@earth>
References: <20161014073328.GC15168@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4vgqxzvu7j25jkdv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbcJSDiI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 23:38:08 -0400
Content-Disposition: inline
In-Reply-To: <20161014073328.GC15168@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Milo Kim <milo.kim@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org


--4vgqxzvu7j25jkdv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Fri, Oct 14, 2016 at 10:33:28AM +0300, Dan Carpenter wrote:
> We checked that "pdata->chg_params" is non-NULL earlier in this function
> so when we add "i" to it, it's still non-NULL.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index 7321b72..509e2b3 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -384,9 +384,6 @@ static int lp8788_update_charger_params(struct platfo=
rm_device *pdev,
>  	for (i =3D 0; i < pdata->num_chg_params; i++) {
>  		param =3D pdata->chg_params + i;
> =20
> -		if (!param)
> -			continue;
> -
>  		if (lp8788_is_valid_charger_register(param->addr)) {
>  			ret =3D lp8788_write_byte(lp, param->addr, param->val);
>  			if (ret)

Thanks, queued.

-- Sebastian

--4vgqxzvu7j25jkdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBuqaAAoJENju1/PIO/qaookP/iod/AD6afe2105jQ3T/U/bR
YGq314k+nt3Mt6LZ7XeUb4CZGB7OfkIl2KB57DdNTGcniVYkcdV2XwcswhBZ1F7p
9Mrny6zBO13Zj709/KKrV9VlTRIDuNbje+YJQyOaG2g5O61ugjOU5+btyk6yp1yp
ijMyTKuEF1lalvz8tLS+XBdTeQONk1jX547HYp9wrIiU7e/eqBxBsvb8hWciZxXX
vpBPYmEdcamrbY2YXJRtA2pjyecuPmtRqUsC5lNwvQwSjDs3cRiYjuaV9fp98QNa
0hcM2lvEJ7BhpnHGZRLi3RZZvaP69R6LUMrvWpWsiS0u09p1Ezhy00Z/FxQp6yck
YthRmkyVzS1Fh/nidV/IJgkmnvvRufq8u8/rhUsxZuFpXkGT4Whlo1k/lGxZl8QH
R//w0phDSDRYhP+xxqtAFbm4Dw96kRC8BW6+tKSS1nbA5YC1TRTHc1UjwMkVggle
1Uxm2B32BCPhr30ZtB6vWy33ARmHVC+jrzzEkJHEX/tONIlTSgrmEZjwKyg+tLNI
ddapxSXxxIwqjsmz3+eZNlfYVxTH0vPE6ovT8Pt9JugQV0ZErd1XH79smFoMFln/
1QQ+DsD1O+q8xRiI/Vr9myqu59aZdYZaxksifwd49jQdsEQJTC/CTr4d5s+bohJ1
RXm0mRyESkYGG6ssSbfy
=SOxR
-----END PGP SIGNATURE-----

--4vgqxzvu7j25jkdv--
