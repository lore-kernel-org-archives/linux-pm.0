From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 4/7] power: bq24190_charger: Uniform pm_runtime_get()
 failure handling
Date: Fri, 24 Mar 2017 10:13:02 +0100
Message-ID: <20170324091302.lhmbk62iihy2bqle@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yxng6qwwhs44ikul"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965012AbdCXJNH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 05:13:07 -0400
Content-Disposition: inline
In-Reply-To: <20170321220921.5834-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>


--yxng6qwwhs44ikul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 21, 2017 at 03:09:18PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> On pm_runtime_get() failure, always emit error message,
> and call pm_runtime_put_noidle() in irq handler.
>=20
> Fixes: 13d6fa8447fa power: bq24190_charger: Use PM runtime autosuspend
> Cc: Mark Greer <mgreer@animalcreek.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> ---
>  drivers/power/supply/bq24190_charger.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index c443988..ad09e48 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1267,12 +1267,13 @@ static void bq24190_check_status(struct bq24190_d=
ev_info *bdi)
>  static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>  {
>  	struct bq24190_dev_info *bdi =3D data;
> -	int ret;
> +	int error;
> =20
>  	bdi->irq_event =3D true;
> -	ret =3D pm_runtime_get_sync(bdi->dev);
> -	if (ret < 0) {
> -		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
> +	error =3D pm_runtime_get_sync(bdi->dev);
> +	if (error < 0) {
> +		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> +		pm_runtime_put_noidle(bdi->dev);
>  		return IRQ_NONE;
>  	}
>  	bq24190_check_status(bdi);
> @@ -1399,8 +1400,10 @@ static int bq24190_probe(struct i2c_client *client,
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_autosuspend_delay(dev, 600);
>  	ret =3D pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get failed: %i\n", ret);
>  		goto out1;
> +	}

This should goto out2, which will make out1 not used anymore.
Would be nice, if you move this patch to the beginning of the
series in the next version, so that I can pick it already while
waiting for Acks on the DT binding.

-- Sebastian

> =20
>  	ret =3D bq24190_hw_init(bdi);
>  	if (ret < 0) {
> --=20
> 2.9.3
>=20

--yxng6qwwhs44ikul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU4x4ACgkQ2O7X88g7
+pokuBAAgARhA7PruU6NOHYjUuqb9W10mbaBV3VQq+mifUxOz23TcEpjNK9Q6VIV
Oj1LKp8GPqM8X4mW6rUuNsYOgo8ftEeKjRTrT2mYkT/k1BeEDN8+gQpOheV8C6C1
8ASfKfjqsVmNGCD+CE2fBe2mug/q9AQybRcSSAlLRFKAGYECw68vVRcUfD+Fn5Kq
D8467wHNrqbcwRvqclFjfav37VbOI8ATsPH8orrcuW75soU5XNPWPvwHZwYStl05
oE1pJNvU09jJKOpjmsyEzoy1YiytI/I1msoKvtwas0ACo8DB5h1gqxfCjdxRaLwp
Spz9hu23l2iBy8MuiePk2u9z+vS6wLSLlI6sgw6e+n58NM2yACd9CBl+is/2P/7j
gTeJvbx1L1940uHUNo15xrbdLgx1ICq3J8Jql1Rwdgw/0rdEwQUl1rymqrfJt00o
dBSYQD7vmFCCqgan/9uJIWLxZYB+Gh/wFb8S57/JKV4zG9FLON2EueKmtGktCbec
/zQnF31ndsJU6BBVynPCUwPWnERIuBvb8H/C45FfZ52uWDXKGV0pSm94j2ofLht8
fBGlJU/YdOzevu9n+1RdUYuWwtpxcVrSUahd/X3LQygfYPi9A7fNTdU5p9nBmcT8
h85XQgetXRxU9oQ9tTEOcwbJXCi7Q6B0u7fhXjJgwwLVeGibw+4=
=jFUG
-----END PGP SIGNATURE-----

--yxng6qwwhs44ikul--
