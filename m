From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: lp8788: prevent out of bounds array access
Date: Tue, 11 Apr 2017 16:18:57 +0200
Message-ID: <20170411141857.ozxtxyftatg5i7ma@earth>
References: <20170325160049.18943-1-giedrius.statkevicius@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oymh5lalbvi2qc6r"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbdDKOTD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 10:19:03 -0400
Content-Disposition: inline
In-Reply-To: <20170325160049.18943-1-giedrius.statkevicius@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Giedrius =?utf-8?Q?Statkevi=C4=8Dius?= <giedrius.statkevicius@gmail.com>
Cc: milo.kim@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--oymh5lalbvi2qc6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 25, 2017 at 06:00:49PM +0200, Giedrius Statkevi=C4=8Dius wrote:
> val might become 7 in which case stime[7] (array of length 7) would be
> accessed during the scnprintf call later and that will cause issues.
> Obviously, string concatenation is not intended here so just a comma needs
> to be added to fix the issue.
>=20
> Signed-off-by: Giedrius Statkevi=C4=8Dius <giedrius.statkevicius@gmail.co=
m>
> ---
>  drivers/power/supply/lp8788-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index 509e2b341bd6..677f7c40b25a 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -651,7 +651,7 @@ static ssize_t lp8788_show_eoc_time(struct device *de=
v,
>  {
>  	struct lp8788_charger *pchg =3D dev_get_drvdata(dev);
>  	char *stime[] =3D { "400ms", "5min", "10min", "15min",
> -			"20min", "25min", "30min" "No timeout" };
> +			"20min", "25min", "30min", "No timeout" };
>  	u8 val;
> =20
>  	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);

Thanks, queued with Fixes Tag.

-- Sebastian

--oymh5lalbvi2qc6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs5cwACgkQ2O7X88g7
+pr97hAAmP8xtj7lgo4WvqI2ObKv+m9TIw967VAnZFEoqCzAjVKPpbAOp+0zWhMA
j/0NMJPzlw41rguWcCahIp7ME/74ObIozJBuFxZVmB6tRP+i3haWKS+QPgmyp3At
Ar4DMosumcQ+DAhjtJD5RRYrHvV+C2nGctXMfZ7hh5KzXrai+t/klXynSlIYBya/
kETm/S8ay/4gUB4KEBrx4koCyfLY53KUe2v6kVUBITGLtw6g1WNZeSkdOd9Tnaup
loexIOvYU5l5WVbv2YvwFjZM795IYccV8hTl/jc3bQRkX1V88w2KtHxP9ntZWq0j
QPwXa1GH30JZpQ+cvr08dKrp3M/Tq6EhFEmtxodBr6mLiRDjW1uz90ZIIJyVGNiM
V2VitcNJIDBbzKCJNx3aYFQOZtb3jASIeBznYbQd3vBaFb87JJfoqMf3zJIIEx6Q
n8KO7mJb/huGacfYAYXDQzqNf/Smi2GBfUGHUBCwAoaz0QuVP5zUhu2SBKcqG/SW
yCJbve0FlscBsW82reBrLUez4acqSSIgMA94HDWmzajPKlxsah848l313FMVT2ac
cfKgph+juFu91sFVHvnC8T5crDg/fQbO+kxm0Ak1iBFoVI1kvHcz5AQHjgmOt7tw
QfDswO/e9cRmmh2q/sbthVX5iZmj/ko6Y/neSdCV95uBaolazNw=
=bAij
-----END PGP SIGNATURE-----

--oymh5lalbvi2qc6r--
