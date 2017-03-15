From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] Power: supply: sbs-charger: simplified bool function
Date: Wed, 15 Mar 2017 22:23:41 +0100
Message-ID: <20170315212341.r5w4wzyjriuo55qh@earth>
References: <1487173581-19388-1-git-send-email-danielperezdeandres@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfdzz4mt2pbtl5oa"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753878AbdCOVXr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 17:23:47 -0400
Content-Disposition: inline
In-Reply-To: <1487173581-19388-1-git-send-email-danielperezdeandres@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Perez <danielperezdeandres@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolassaenzj@gmail.com


--hfdzz4mt2pbtl5oa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Feb 15, 2017 at 04:46:21PM +0100, Daniel Perez wrote:
> v1 -> v2:
>  - given Joe Perches' comment, I've further simplified the syntax
>    of the bool function, removing the ternary conditional
>=20
> Signed-off-by: Daniel Perez <danielperezdeandres@gmail.com>

Thanks, queued. Please move the Version history below ---, so that
it does not end up in the commit. I fixed that while applying.

-- Sebastian

> ---
>  drivers/power/supply/sbs-charger.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sb=
s-charger.c
> index 353765a..15947db 100644
> --- a/drivers/power/supply/sbs-charger.c
> +++ b/drivers/power/supply/sbs-charger.c
> @@ -137,10 +137,7 @@ static enum power_supply_property sbs_properties[] =
=3D {
> =20
>  static bool sbs_readable_reg(struct device *dev, unsigned int reg)
>  {
> -	if (reg < SBS_CHARGER_REG_SPEC_INFO)
> -		return false;
> -	else
> -		return true;
> +	return reg >=3D SBS_CHARGER_REG_SPEC_INFO;
>  }
> =20
>  static bool sbs_volatile_reg(struct device *dev, unsigned int reg)
> --=20
> 2.7.4
>=20

--hfdzz4mt2pbtl5oa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJsN0ACgkQ2O7X88g7
+ppjMA//dptTv+MYwp2HXH5icT50p0wTboOBTELtySwK9oyb08lxt8TJISuU5mZ+
fi9OopMUGbTeaSYppdUzjSpmzcePgT+AwK5a80KGmQsbvAzasdfN4VuleWZKK8nF
wrdF5waw/Ifz/1PPfqNPwyRbP9SRWEvQEPbi+cvgXgNY1bfUxLr3LY50KWL8UY0d
IkHVqlFFM06oC5lzlflssCQ7zhYLaEoTw3O5bk3sNBk0F9ZE/U70ER6wqztFgffg
n3Ydsri3SefKfi7h3zsEt5bcprnDl/sUvuvRiC2uHSbVID2VV0VbFBZl4W91kQBS
iwS/zz4LSrSo7Ge7s95NEzpBPXVNoNCCFlox9iiQzQ3bRjdNXp3eYivU8G+uQmKA
84cpB+5tNEV9W8hylj7+iG3paVSad1asXz+9CqqPx10duyDfA/Z/v3MlkcTW0cWf
B7vbpi6AKIb01WQQyZOAazmMEgCg3/1xbsr733Cy9B6KGItszTcG1FxgDubM1xmZ
WBN57D82uGmTPlQyI9FugbT2yq2EyoeTSDtuIke0y/muBD+dLGVWjqsM85pwktGs
IxFYSG8WOpOXLNh4Z/wzvJTKFU21Vd9jSOSKN3U5Rl7yRYsxesG7ws1tVSo9ph0t
aep2UeiFsi6ZTxtmmjbRTMiVwBukBexdxcOiOZzLBSGNtTaZDRc=
=VVXC
-----END PGP SIGNATURE-----

--hfdzz4mt2pbtl5oa--
